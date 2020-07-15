import { NativeModules } from "react-native";
import { getClosestColor } from "./src";

const {
  ColorLens: { getPaletteFromImage },
  Pixel: { getPixel: _getPixel }
} = NativeModules;

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

export { getPixel, getPalette, getClosestColor };
