//
//  Enum+Calculators.h
//  Calculator
//
//  Created by Byunsangjin on 25/06/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Enum_Calculator : NSObject

typedef enum : NSUInteger {
    RESULT,
    PLUS,
    MINUS,
    MULTIPLICATION,
    DIVISION
} Operator;

typedef enum : NSUInteger {
    CE,
    C,
    DELETE
} Etc;

typedef enum : NSUInteger {
    PLUSMINUS = -1,
    POINT = -2
} NumberPad;

@end

NS_ASSUME_NONNULL_END
