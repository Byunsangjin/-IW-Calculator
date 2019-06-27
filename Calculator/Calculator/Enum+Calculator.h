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
    ADD,
    SUB,
    MULTIPLE,
    DIVISION
} Operator;

typedef enum : NSUInteger {
    PLUSMINUS,
    POINT,
    CE,
    C,
    DELETE
} Etc;

@end

NS_ASSUME_NONNULL_END
