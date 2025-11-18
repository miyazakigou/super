const popupButton = document.getElementById('popup-button');
const resultDiv = document.getElementById('result');

popupButton.addEventListener('click', () => {
    chrome.tabs.query({ active: true, currentWindow: true }, (tabs) => {
        const activeTab = tabs[0];
        if (activeTab) {
            chrome.scripting.executeScript({
                target: { tabId: activeTab.id },
                function: () => {
                    // ここにコンテンツスクリプトのロジックを追加
                    return 'Hello from the content script!';
                }
            }, (results) => {
                if (results && results[0]) {
                    resultDiv.textContent = results[0].result;
                }
            });
        }
    });
});