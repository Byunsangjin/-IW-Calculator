//
//  NSString+Borders.m
//  Calculator
//
//  Created by Byunsangjin on 25/06/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

#import "UIView+Borders.h"

@implementation UIView (Borders)

- (void)addLayerWithWidth: (CGFloat)width color: (UIColor *)color top: (BOOL)top left: (BOOL)left right: (BOOL)right bottom:(BOOL)bottom  {
    if (top) {
        [self.layer addSublayer: [self getTopLayerWithWidth:width color:color]];
    }
    
    if (left) {
        [self.layer addSublayer: [self getLeftLayerWithWidth:width color:color]];
    }
    
    if (right) {
        [self.layer addSublayer: [self getRightLayerWithWidth:width color:color]];
    }
    
    if (bottom) {
        [self.layer addSublayer: [self getBottomLayerWithWidth:width color:color]];
    }
}

- (CALayer *)getLayerWithFrame: (CGRect)frame {
    CALayer *layer = [CALayer layer];
    layer.frame = frame;
    
    return layer;
}

- (CALayer *)getTopLayerWithWidth: (CGFloat)width color: (UIColor *)color {
    CALayer *layer = [self getLayerWithFrame:CGRectMake(0, 0, self.frame.size.width, width)];
    layer.backgroundColor = color.CGColor;
    return layer;
}

- (CALayer *)getLeftLayerWithWidth: (CGFloat)width color: (UIColor *)color {
    CALayer *layer = [self getLayerWithFrame:CGRectMake(0, 0, width, self.frame.size.height)];
    layer.backgroundColor = color.CGColor;
    return layer;
}

- (CALayer *)getRightLayerWithWidth: (CGFloat)width color: (UIColor *)color {
    CALayer *layer = [self getLayerWithFrame:CGRectMake(self.frame.size.width - width, 0, width, self.frame.size.height)];
    layer.backgroundColor = color.CGColor;
    return layer;
}

- (CALayer *)getBottomLayerWithWidth: (CGFloat)width color: (UIColor *)color {
    CALayer *layer = [self getLayerWithFrame:CGRectMake(0, self.frame.size.height - width, self.frame.size.width, width)];
    layer.backgroundColor = color.CGColor;
    return layer;
}

@end
