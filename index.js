import hexRgb from "hex-rgb";
import rgbHex from "rgb-hex";
import diff from "color-diff";
import { pantones } from "./pantones.json";
import { NativeModules } from "react-native";

const {
  ColorLens: { getPaletteFromImage },
  Pixel: { getPixel: _getPixel }
} = NativeModules;

const getRGB = hexColor => {
  const rgbcolor = hexRgb(hexColor);
  return {
    R: rgbcolor[0],
    G: rgbcolor[1],
    B: rgbcolor[2]
  };
};

const pantoneRGBList = pantones.map(color => getRGB(color.hex));

const getHexFromRGB = ({ red, green, blue }) => `#${rgbHex(red, green, blue)}`;

const getPantone = inputHex => {
  const inputRGB = getRGB(inputHex);
  const { R: red, G: green, B: blue } = diff.closest(inputRGB, pantoneRGBList);
  const nearestPantoneHex = getHexFromRGB({ red, green, blue });
  const indexInPantonesList = pantones.findIndex(x => x.hex == nearestPantoneHex);

  return { ...pantones[indexInPantonesList], rgb: inputRGB, hex: inputHex };
};

const getPalette = (path, callback) => {
  const localIdentifier = path.substring(5);
  getPaletteFromImage(localIdentifier, (err, res) => {
    if (err) {
      callback(err);
    } else {
      callback(null, res);
    }
  });
};

const getPixel = (path, options) =>
  new Promise((resolve, reject) => {
    _getPixel(path, options, (err, color) => {
      if (err) return reject(err);

      resolve(color);
    });
  });

export { getPixel, getPalette, getPantone, getHexFromRGB };
