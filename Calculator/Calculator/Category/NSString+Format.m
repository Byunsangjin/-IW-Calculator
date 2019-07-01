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
    
    NSDecimalNumber *decimalN = [NSDecimalNumber decimalNumberWithString: self];
    double integerPart = floor([decimalN doubleValue]);
    double decimalPart = [decimalN doubleValue] - floor(integerPart);
    
    if (integerPart < 1000) {
        return self;
    }
    
    if (integerPart > 1000000000) {
        return [NSString stringWithFormat:@"%.9g", [self doubleValue]];
    }
    
    NSMutableString *integerString = [[formatter stringFromNumber: [NSNumber numberWithInteger:integerPart]] mutableCopy];
    NSMutableString *decimalString = [[NSString stringWithFormat:@"%.9g", decimalPart] mutableCopy];
    
    NSLog(@"%@", decimalString);
    if (decimalString.length > 2) {
        NSInteger commaCnt = integerString.length / 3;
        
        [decimalString deleteCharactersInRange: NSMakeRange(0, 1)];
        [integerString appendString:decimalString];
        
        
        NSInteger length = integerString.length;
        if (length > 10) length = 10;
        
        
        return [integerString substringWithRange:NSMakeRange(0, length + commaCnt)];
    }
    
    return integerString;
}

@end
