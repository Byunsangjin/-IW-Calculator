//
//  NSString+Borders.m
//  Calculator
//
//  Created by Byunsangjin on 25/06/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

#import "UIView+Borders.h"

@implementation UIView (Borders)

- (void)addLayerWithWidth:(CGFloat)width color:(UIColor *)color direction:(Border)direction {
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = color.CGColor;
    layer.frame = CGRectMake(direction & RIGHT ? self.frame.size.width - width : 0,
                             direction & BOTTOM ? self.frame.size.height - width : 0,
                             direction & (LEFT|RIGHT) ? width : self.frame.size.width,
                             direction & (LEFT|RIGHT) ? self.frame.size.height : width);
    
    [self.layer addSublayer:layer];
}

@end
