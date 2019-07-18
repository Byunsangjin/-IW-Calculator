//
//  NSString+Borders.h
//  Calculator
//
//  Created by Byunsangjin on 25/06/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSUInteger, Border) {
    LEFT = 1 << 0,
    TOP = 1 << 1,
    BOTTOM = 1 << 2,
    RIGHT = 1 << 3
};

@interface UIView (Borders)

- (void)addLayerWithWidth:(CGFloat)width color:(UIColor *)color direction:(Border)direction;

@end

NS_ASSUME_NONNULL_END
