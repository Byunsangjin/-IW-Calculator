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
    if ([self isEqualToString:@"NaN"]) {
        return self;
    }
    
    NSDecimalNumber *decimalN = [NSDecimalNumber decimalNumberWithString: self];
    double integerPart = [self roundOffWithNumber:[decimalN doubleValue]];
    double decimalPart = [decimalN doubleValue] - integerPart;
    
    if (integerPart > 1000000000) {
        return [NSString stringWithFormat:@"%.9g", [self doubleValue]];
    }
    
    NSMutableString *integerString = [[NSString stringWithFormat:@"%.9g", integerPart] mutableCopy];
    NSMutableString *decimalString = [[NSString stringWithFormat:@"%.7g", decimalPart] mutableCopy]; // 8자리 이상부터 부동 소수점 문제 발생
    
    if ([decimalString characterAtIndex:0] == '-') {
        [decimalString deleteCharactersInRange: NSMakeRange(0, 1)];
    }
    
    [decimalString deleteCharactersInRange: NSMakeRange(0, 1)];
    [integerString appendString:decimalString];
    
    return [integerString decimal];
}

- (NSString *)decimal {
    NSInteger integerPart = [self integerValue];
    NSInteger integerLength = [NSString stringWithFormat:@"%ld", integerPart].length;
    
    if (integerPart > -1000 && integerPart < 1000)
        return self;
    
    NSNumberFormatter *formatter = [NSNumberFormatter new];
    [formatter setNumberStyle: NSNumberFormatterDecimalStyle];
    
    NSMutableString *integerString = [[formatter stringFromNumber: [NSNumber numberWithInteger:integerPart]] mutableCopy];
    
    NSMutableString *wholeString = [self mutableCopy];
    [wholeString replaceCharactersInRange:NSMakeRange(0, integerLength) withString:integerString];

    if ((wholeString.length - integerLength / 3) > 9) { // 소수점 존재하면...
        return [wholeString substringToIndex: 9 + integerLength / 3 + 1];
    }
    
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
