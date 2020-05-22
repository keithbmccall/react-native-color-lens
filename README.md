# react-native-color-lens

A React-Native util for extracting the dominant colors from an image. Uses ColorThiefSwift as a foundation.

## Getting started

`npm install react-native-color-lens --save`

or

`yarn add react-native-color-lens`

## API

### `getPalette(imageUri, callback)` 

`imageUri: String - uri location of local image`

`callback: Func - (err, swatches) => {}`

## Thanks

- Thanks to Kazuki Ohara for ColorThiefSwift 
    - https://github.com/yamoridon/ColorThiefSwift
- Thanks to Sven Woltmann for Java implementation
    - https://github.com/SvenWoltmann/color-thief-java
- Thanks to Lokesh Dhakar for the original ColorThief implementation in JS
    - http://lokeshdhakar.com/projects/color-thief/
    - https://github.com/lokesh/color-thief/

## Contact
- keithcodes@gmail.com
