//
//  ViewController.m
//  Calculator
//
//  Created by Byunsangjin on 24/06/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

#import "ViewController.h"
#import "Category/UIView+Borders.h"
#import "CalculatorStack.h"
#import "Category/NSString+Format.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIView *titleView;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *functionButtons;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *numberButtons;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *etcButtons;
@property (strong, nonatomic) IBOutlet UIView *resultButton;

@property NSMutableString *numberString;
@property CalculatorStack *cStack;

@property BOOL isOperatorTurn;
@property BOOL isResult;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self ButtonsAddGesture];
    
    self.numberString = [@"0" mutableCopy];
    self.isOperatorTurn = YES;
    self.cStack = CalculatorStack.shared;
}

- (void)viewWillLayoutSubviews {
    [self borderSet];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.view setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3]];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backViewTouched:)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        [self borderSet];
    } completion:nil];
}

- (void)ButtonsAddGesture {
    NSDictionary *buttonDic = @{@"operatorBtnTouched:" : self.functionButtons,
                                @"numBtnTouched:" : self.numberButtons,
                                @"etcBtnTouched:" : self.etcButtons,
                                @"resultBtnTouched:" : [NSArray arrayWithObject:self.resultButton]};

    [buttonDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        SEL selector = NSSelectorFromString(key);
        
        for (UIView *buttonView in obj) {
            UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:selector];
            [tap setMinimumPressDuration:0.02];
            [buttonView addGestureRecognizer:tap];
        }
    }];
}

- (void)borderSet {
    UIColor *borderColor = [UIColor colorWithRed:221/255.0 green:222/255.0 blue:224/255.0 alpha:1];
    [self.titleView addLayerWithWidth:1 color:borderColor direction:TOP|BOTTOM];
}

- (void)numBtnTouched: (UILongPressGestureRecognizer *)gesture {
    [self changeOpacityFromGesture:gesture];
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if (self.isResult)
            self.numberString = [@"0" mutableCopy];
        
        NSInteger length = [self.numberString containsString:@"."] ? self.numberString.length - 1 : self.numberString.length;
        if (length > 8) {
            return;
        }
        
        if ([self.numberString isEqualToString:@"0"] || [self.numberString isEqualToString:@"-0"])
            [self.numberString replaceCharactersInRange:NSMakeRange(self.numberString.length - 1, 1) withString:@""];
        
        NSString *inputNumber = [NSString stringWithFormat:@"%ld", (long)gesture.view.tag];
        [self.numberString appendString:inputNumber];
        
        [self inputedNumOrEtc];
    }
}

- (void)operatorBtnTouched: (UILongPressGestureRecognizer *)gesture {
    [self changeOpacityFromGesture:gesture];
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        NSNumber *op = [NSNumber numberWithInteger:gesture.view.tag];
        NSString *number = self.numberString;
        
        if (self.isOperatorTurn == NO) { // 연속해서 Operator를 눌렀다면
            [self.cStack changeLastOperator:op];
            return;
        }
        
        [self.cStack push:number];
        
        NSInteger operator = [[self.cStack operatorPeek] integerValue];
        if(operator == MULTIPLE || operator == DIVISION) {
            [self.cStack calculate];
        }
        
        if ([op integerValue] == ADD || [op integerValue] == SUB) {
            [self.cStack calculate];
        }
        
        [self.cStack push:op];
        
        number = [self.cStack operandPeek];
        self.textLabel.text = [number resultDecimal];
        self.numberString = [@"0" mutableCopy];
        
        self.isOperatorTurn = NO;
    }
}

- (void)etcBtnTouched: (UILongPressGestureRecognizer *)gesture {
    [self changeOpacityFromGesture:gesture];
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        if ([self.numberString isEqualToString:@"NaN"]) {
            self.numberString = [@"0" mutableCopy];
        }
        
        switch (gesture.view.tag) {
            case POINT: {
                if (self.isResult)
                    self.numberString = [@"0" mutableCopy];
                
                if (self.numberString.length < 9 && ![self.numberString containsString:@"."])
                    [self.numberString appendString:@"."];
                break;
            }
            case PLUSMINUS: {
                if ([self.numberString containsString:@"-"])
                    [self.numberString deleteCharactersInRange: NSMakeRange(0, 1)];
                else
                    [self.numberString insertString:@"-" atIndex:0];
                break;
            }
            case C: {
                [self.cStack clearStack];
            }
            case CE: {
                self.numberString = [@"0" mutableCopy];
                break;
            }
            case DELETE: {
                NSInteger length = self.numberString.length;
                if (([self.numberString containsString:@"-"] && length == 2) || length == 1 || self.isResult)
                    self.numberString = [@"0" mutableCopy];
                else
                    [self.numberString deleteCharactersInRange: NSMakeRange(length - 1, 1)];
                break;
            }
            default:
                break;
        }
        
        [self inputedNumOrEtc];
    }
}

- (void)resultBtnTouched: (UILongPressGestureRecognizer *)gesture {
    [self changeOpacityFromGesture: gesture];
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        self.isResult = YES;
        if ([self.cStack operatorCount] == 0) {
            return;
        }
        
        NSString *number = self.numberString;
        if ([self.cStack operandCount] == 1) {
            [self.cStack push:number];
            [self.cStack calculate];
            
            self.numberString = [[self.cStack operandPop] mutableCopy];
            self.textLabel.text = [self.numberString resultDecimal];
            return;
        }
        
        [self.cStack push:number];
        [self.cStack allCalculate];
        
        self.numberString = [[self.cStack operandPop] mutableCopy];
        self.textLabel.text = [self.numberString resultDecimal];
    }
}

- (void)changeOpacityFromGesture: (UILongPressGestureRecognizer *)gesture {
    UIColor *originColor = gesture.view.backgroundColor;
    UIColor *opacityColor;
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        opacityColor = [originColor colorWithAlphaComponent:0.3];
        [gesture.view setBackgroundColor:opacityColor];
    } else if (gesture.state == UIGestureRecognizerStateEnded) {
        opacityColor = [originColor colorWithAlphaComponent:1];
        [gesture.view setBackgroundColor:opacityColor];
    }
}

- (void)inputedNumOrEtc {
    self.textLabel.text = [self.numberString decimal];
    self.isOperatorTurn = YES;
    self.isResult = NO;
}

- (void)backViewTouched: (UITapGestureRecognizer *)gesture {
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
}

@end
