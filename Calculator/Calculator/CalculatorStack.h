//
//  CalculatorStack.h
//  Calculator
//
//  Created by Byunsangjin on 26/06/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Enum+Calculator.h"

NS_ASSUME_NONNULL_BEGIN

@interface CalculatorStack : NSObject

+ (instancetype)shared;

- (void)push: (id)object;
- (void)changeLastOperator: (id)object;
- (void)calculate;
- (void)clearStack;

- (NSNumber *)operatorPeek;
- (NSString *)operandPeek;

- (NSNumber *)operatorPop;
- (NSString *)operandPop;

- (NSInteger)operatorCount;
- (NSInteger)operandCount;

@end

NS_ASSUME_NONNULL_END
