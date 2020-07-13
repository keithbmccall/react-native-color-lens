//  ColorLens.m
//  ColorLens
//
//  Created by Keith McCall on 7/12/20.
//  Copyright © 2020 acid. All rights reserved.
//

#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(ColorLens, NSObject)

    RCT_EXTERN_METHOD(getPaletteFromImage:(NSString *)path callback:(RCTResponseSenderBlock *)callback)
    RCT_EXTERN_METHOD(getHex:(NSString *)path options:(NSDictionary *)options callback:(RCTResponseSenderBlock)callback)
@end

