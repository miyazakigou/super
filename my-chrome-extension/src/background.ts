// This file defines the background script for the Chrome extension.
// It manages the extension's lifecycle and sets up event listeners.

chrome.runtime.onInstalled.addListener(() => {
    console.log("Extension installed");
});

chrome.runtime.onStartup.addListener(() => {
    console.log("Extension started");
});

// Add more event listeners and background logic as needed.