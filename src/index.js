// Get nearest pantone

const hexRgb = require("hex-rgb");
const rgbHex = require("rgb-hex");
const diff = require("color-diff");
const { pantones } = require("./pantones.json");

const get_rgbObject = hexColor => {
  const rgbcolor = hexRgb(hexColor);
  return {
    r: rgbcolor[0],
    g: rgbcolor[1],
    b: rgbcolor[2]
  };
};

const pantoneRGBList = pantones.map(color => get_rgbObject(color.hex));

exports.getClosestColor = inputHex => {
  const inputRGB = get_rgbObject(inputHex);
  const nearestPantone = diff.closest(inputRGB, pantoneRGBList);
  const nearestPantoneHex = rgbHex(nearestPantone.R, nearestPantone.G, nearestPantone.B);
  const indexInPantonesList = pantones.findIndex(x => x.hex == `#${nearestPantoneHex}`);

  return { ...pantones[indexInPantonesList], rgb: inputRGB, hex: inputHex };
};
