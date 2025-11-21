# My Chrome Extension

This project is a Chrome extension that enhances your browsing experience with various features. Below is an overview of the project's structure and functionality.

## Project Structure

- **src/**: Contains all the source files for the extension.
  - **manifest.json**: Defines the metadata for the Chrome extension, including its name, version, permissions, and entry points for scripts.
  - **background.ts**: Implements the background script for managing the extension's lifecycle and setting up event listeners.
  - **content/**: Contains the content scripts that interact with web pages.
    - **contentScript.ts**: Code for manipulating web pages.
  - **popup/**: Contains files related to the popup UI.
    - **popup.html**: HTML structure for the popup displayed when the extension icon is clicked.
    - **popup.ts**: Logic for handling user interactions in the popup.
  - **options/**: Contains files for the options page where users can configure settings.
    - **options.html**: HTML structure for the options page.
    - **options.ts**: Logic for saving and retrieving settings.
  - **types/**: Contains TypeScript type definitions.
    - **index.d.ts**: Custom types and interfaces used in the extension.

- **package.json**: Configuration file for npm, listing dependencies and scripts.
- **tsconfig.json**: TypeScript compiler options, specifying files to compile and output settings.
- **webpack.config.js**: Configuration for Webpack, handling module bundling and output settings.
- **README.md**: Documentation for the project, providing an overview and usage instructions.

## Installation

To install the project, clone the repository and run the following command:

```
npm install
```

## Usage

After installation, you can build the project using:

```
npm run build
```

Then, load the unpacked extension in Chrome by navigating to `chrome://extensions/` and selecting "Load unpacked". Choose the `src` directory of the project.

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any suggestions or improvements.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.