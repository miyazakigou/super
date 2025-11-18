// This file contains the logic for the options page, including saving and retrieving settings.

document.addEventListener('DOMContentLoaded', () => {
    const saveButton = document.getElementById('save') as HTMLButtonElement;
    const inputField = document.getElementById('inputField') as HTMLInputElement;

    // Load saved settings
    chrome.storage.sync.get(['mySetting'], (result) => {
        if (result.mySetting) {
            inputField.value = result.mySetting;
        }
    });

    // Save settings on button click
    saveButton.addEventListener('click', () => {
        const valueToSave = inputField.value;
        chrome.storage.sync.set({ mySetting: valueToSave }, () => {
            console.log('Settings saved:', valueToSave);
        });
    });
});