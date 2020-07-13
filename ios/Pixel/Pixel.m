//
//  Pixel.m
//  ColorLens
//
//  Created by Keith McCall on 7/12/20.
//  Copyright © 2020 acid. All rights reserved.
//

#include "Pixel.h"
#import <React/RCTImageLoader.h>
#import "UIImage+ColorAtPixel.h"

@implementation Pixel

@synthesize bridge = _bridge;


- (void )getHex:(NSString *)path options:(NSDictionary *)options callback:(RCTResponseSenderBlock)callback
{
    [[_bridge moduleForName:@"ImageLoader" lazilyLoadIfNecessary:YES] loadImageWithURLRequest:[RCTConvert NSURLRequest:path] callback:^(NSError *error, UIImage *image) {
        if (error || image == nil) { // if couldn't load from bridge create a new UIImage
            if ([path hasPrefix:@"data:"] || [path hasPrefix:@"file:"]) {
                NSURL *imageUrl = [[NSURL alloc] initWithString:path];
                image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageUrl]];
            } else {
                image = [[UIImage alloc] initWithContentsOfFile:path];
            }

            if (image == nil) {
                callback(@[@"Could not create image from given path.", @""]);
                return;
            }
        }
 
        NSInteger x = [RCTConvert NSInteger:options[@"x"]];
        NSInteger y = [RCTConvert NSInteger:options[@"y"]];
        if (options[@"width"] && options[@"height"]) {
            NSInteger scaledWidth = [RCTConvert NSInteger:options[@"width"]];
            NSInteger scaledHeight = [RCTConvert NSInteger:options[@"height"]];
            float originalWidth = image.size.width;
            float originalHeight = image.size.height;
            
            x = x * (originalWidth / scaledWidth);
            y = y * (originalHeight / scaledHeight);
            
        }
        
        CGPoint point = CGPointMake(x, y);
        
        UIColor *pixelColor = [image colorAtPixel:point];
        callback(@[[NSNull null], hexStringForColor(pixelColor)]);
     
    }];
}

NSString * hexStringForColor( UIColor* color ) {
    const CGFloat *components = CGColorGetComponents(color.CGColor);
    CGFloat r = components[0];
    CGFloat g = components[1];
    CGFloat b = components[2];
    NSString *hexString=[NSString stringWithFormat:@"#%02X%02X%02X", (int)(r * 255), (int)(g * 255), (int)(b * 255)];

    return hexString;
}

@end

