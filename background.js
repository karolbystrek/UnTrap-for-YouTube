const SENTINEL = "data-ogz6bapy";

function isYouTubeUrl(url) {
  if (!url) return false;
  try {
    const { hostname } = new URL(url);
    return hostname === "youtube.com" || hostname.endsWith(".youtube.com");
  } catch {
    return false;
  }
}

function iconForBlockingOff(blockingOff) {
  return blockingOff ? "symbol:eye" : "symbol:eye.slash";
}

async function setTabIcon(tabId, blockingOff) {
  await browser.action.setIcon({
    tabId,
    variants: [{ any: iconForBlockingOff(blockingOff) }]
  });
}

async function syncTab(tabId, url) {
  if (!isYouTubeUrl(url)) {
    await browser.action.disable(tabId);
    return;
  }

  await browser.action.enable(tabId);

  try {
    const result = await browser.scripting.executeScript({
      target: { tabId },
      func: (attr) => document.documentElement.hasAttribute(attr),
      args: [SENTINEL]
    });
    await setTabIcon(tabId, Boolean(result[0]?.result));
  } catch {
    await setTabIcon(tabId, false);
  }
}

browser.action.onClicked.addListener(async (tab) => {
  if (!tab?.id || !isYouTubeUrl(tab.url)) return;

  try {
    const result = await browser.scripting.executeScript({
      target: { tabId: tab.id },
      func: (attr) => {
        const blockingOff = document.documentElement.toggleAttribute(attr);
        window.dispatchEvent(new Event("resize"));
        return blockingOff;
      },
      args: [SENTINEL]
    });

    await setTabIcon(tab.id, Boolean(result[0]?.result));
  } catch (error) {
    console.error("Failed to toggle distractions: " + error);
  }
});

browser.tabs.onUpdated.addListener((tabId, changeInfo, tab) => {
  if (changeInfo.status === "complete" || changeInfo.url) {
    syncTab(tabId, tab.url);
  }
});

browser.tabs.onActivated.addListener(async ({ tabId }) => {
  try {
    const tab = await browser.tabs.get(tabId);
    await syncTab(tabId, tab.url);
  } catch (error) {
    console.error("Failed to sync tab icon: " + error);
  }
});

browser.tabs.query({}).then((tabs) => {
  for (const tab of tabs) {
    if (tab.id != null) syncTab(tab.id, tab.url);
  }
}).catch(() => {});
