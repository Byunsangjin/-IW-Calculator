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
//    return self;
    
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle: NSNumberFormatterDecimalStyle];
    
    NSDecimalNumber *decimalN = [NSDecimalNumber decimalNumberWithString: self];
    double integerPart = floor([decimalN doubleValue]);
    double decimalPart = [decimalN doubleValue] - floor(integerPart);
    
    
    if (integerPart > 1000000000) {
        return [NSString stringWithFormat:@"%.9g", [self doubleValue]];
    }
    
    NSString *integerString = [formatter stringFromNumber: [NSNumber numberWithInteger:integerPart]];
    NSMutableString *decimalString = [[NSString stringWithFormat:@"%.9g", decimalPart] mutableCopy];
    if (decimalString.length > 2) {
        [decimalString deleteCharactersInRange: NSMakeRange(0, 2)];
        return [NSString stringWithFormat:@"%@.%@", integerString, decimalString];
    }
    
    return integerString;
}

@end
