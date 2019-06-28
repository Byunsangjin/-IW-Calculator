//
//  NSString+Format.m
//  Calculator
//
//  Created by Byunsangjin on 28/06/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

#import "NSString+Format.h"

@implementation NSString (Format)

- (NSString *)decimalFormat {
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle: NSNumberFormatterDecimalStyle];
    NSNumber *number = [formatter numberFromString:self];
    
    return [formatter stringFromNumber:number];
}

@end
