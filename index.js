import { NativeModules} from 'react-native';
const { ColorLens: getPaletteFromImage} = NativeModules;

export const getPalette = (options, path, callback) => {
  const localIdentifier = path.substring(5)
  getPaletteFromImage(localIdentifier, (err,res)=>{
    if (err){
      callback(err)
    } else {
      callback(null,res)
    }
  })

}
