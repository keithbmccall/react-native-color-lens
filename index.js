import { NativeModules } from "react-native";

const {
  ColorLens: { getPaletteFromImage },
  Pixel: { getPixel: _getPixel }
} = NativeModules;

export const getPalette = (path, callback) => {
  const localIdentifier = path.substring(5);
  getPaletteFromImage(localIdentifier, (err, res) => {
    if (err) {
      callback(err);
    } else {
      callback(null, res);
    }
  });
};

export const getPixel = async (path, options) => {
  return await _getPixel(path, options, (err, color) => {
    if (err) {
      console.log("error in getPixel with arguments ", { path, options });
      return "#000000";
    }

    return color;
  });
};
