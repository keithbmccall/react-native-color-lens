#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(ColorLens, NSObject)

   RCT_EXTERN_METHOD(getPaletteFromImage:(NSString *)path callback:(RCTResponseSenderBlock *)callback)
@end

