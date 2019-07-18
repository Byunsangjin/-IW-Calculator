//
//  CalculatorStack.m
//  Calculator
//
//  Created by Byunsangjin on 26/06/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

#import "CalculatorStack.h"

@interface CalculatorStack()

@property NSMutableArray *operatorStack;
@property NSMutableArray *operandStack;

@end

@implementation CalculatorStack

+ (instancetype)shared
{
    static CalculatorStack *cStack = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cStack = [CalculatorStack new];
    });
    
    return cStack;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.operatorStack = [NSMutableArray new];
        self.operandStack = [NSMutableArray new];
    }
    return self;
}

- (void)push:(id)object {
    if ([object isKindOfClass: [NSNumber class]]) { // Operator
        [self.operatorStack addObject:object];
    } else { // Operand
        [self.operandStack addObject:object];
    }
}

- (NSNumber *)operatorPop {
    NSNumber *operator = [self operatorPeek];
    [self.operatorStack removeLastObject];
    
    return operator;
}

- (NSString *)operandPop {
    NSString *operand = [self operandPeek];
    [self.operandStack removeLastObject];
    
    return operand;
}
- (NSNumber *)operatorPeek {
    return [self.operatorStack lastObject];
}

- (NSString *)operandPeek {
    return [self.operandStack lastObject];
}

- (NSInteger)operatorCount {
    return self.operatorStack.count;
}

- (NSInteger)operandCount {
    return self.operandStack.count;
}

- (void)calculate {
    if (self.operandStack.count < 2 || self.operatorStack.count == 0) {
        return;
    }
    
    double num1 = [[self operandPop] doubleValue];
    double num2 = [[self operandPop] doubleValue];
    
    NSString *result;
    NSInteger op = [[self operatorPop] integerValue];
    
    switch (op) {
        case ADD:
            result = [NSString stringWithFormat:@"%.9lf", num2 + num1];
            break;
        case SUB:
            result = [NSString stringWithFormat:@"%.9lf", num2 - num1];
            break;
        case MULTIPLE:
            result = [NSString stringWithFormat:@"%.9lf", num2 * num1];
            break;        
        case DIVISION:
            result = [NSString stringWithFormat:@"%.9lf", num2 / num1];
            break;
        default:
            break;
    }
    
    [self push:result];
}

- (void)allCalculate {
    while([self operatorCount] != 0) {
        [self calculate];
    }
}

- (void)clearStack {
    self.operandStack = [NSMutableArray new];
    self.operatorStack = [NSMutableArray new];
}

- (void)changeLastOperator:(id)object {
    if([self operatorPop] != NULL)
        [self push:object];
    return;
}

@end
