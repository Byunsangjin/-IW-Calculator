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

@interface UIView (Borders)

- (void)addLayerWithWidth: (CGFloat)width color: (UIColor *)color top: (BOOL)top left: (BOOL)left right: (BOOL)right bottom:(BOOL)bottom;

@end

NS_ASSUME_NONNULL_END
