//
//  Pixel.m
//  ColorLens
//
//  Created by Keith McCall on 7/12/20.
//

/*
Copyright (c) 2018 Chris LeBlanc

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*/

#include "Pixel.h"
#import <React/RCTImageLoader.h>
#import "UIImage+ColorAtPixel.h"

@implementation Pixel

@synthesize bridge = _bridge;
RCT_EXPORT_MODULE();

RCT_EXPORT_METHOD(getPixel:(NSString *)path
                  options:(NSDictionary *)options
                  callback:(RCTResponseSenderBlock)callback)
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

