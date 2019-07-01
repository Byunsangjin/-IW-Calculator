//
//  NSString+Format.m
//  Calculator
//
//  Created by Byunsangjin on 28/06/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

#import "NSString+Format.h"

@implementation NSString (Format)

- (NSString *)resultDecimal {
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle: NSNumberFormatterDecimalStyle];
    
    NSDecimalNumber *decimalN = [NSDecimalNumber decimalNumberWithString: self];
    double integerPart = [self roundOffWithNumber:[decimalN doubleValue]];
    double decimalPart = [decimalN doubleValue] - integerPart;
    
    if (integerPart > 1000000000) {
        return [NSString stringWithFormat:@"%.9g", [self doubleValue]];
    }
    
    NSMutableString *integerString = [[formatter stringFromNumber: [NSNumber numberWithInteger:integerPart]] mutableCopy];
    NSMutableString *decimalString = [[NSString stringWithFormat:@"%.9g", decimalPart] mutableCopy];
    
    [decimalString deleteCharactersInRange: NSMakeRange(0, 1)];
    [integerString appendString:decimalString];
    
    [integerString decimal];
    
    return integerString;
}

- (NSString *)decimal {
    NSInteger integerPart = [self integerValue];
    NSInteger integerLength = [NSString stringWithFormat:@"%ld", integerPart].length;
    
    integerPart = [self roundOffWithNumber:integerPart];
    
    if (integerPart > -1000 && integerPart < 1000)
        return self;
    
    
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle: NSNumberFormatterDecimalStyle];
    
    NSMutableString *integerString = [[formatter stringFromNumber: [NSNumber numberWithInteger:integerPart]] mutableCopy];
    
    NSMutableString *wholeString = [self mutableCopy];
    [wholeString replaceCharactersInRange:NSMakeRange(0, integerLength) withString:integerString];

    return wholeString;
}

- (double)roundOffWithNumber: (double)number {
    if (number > 0)
        number = floor(number);
    else
        number = ceil(number);
    
    return number;
}

@end
