//
//  ViewController.m
//  Calculator
//
//  Created by Byunsangjin on 24/06/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Borders.h"
#import "Enum+Calculator.h"
#import "CalculatorStack.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIView *titleView;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *functionButtons;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *numberButtons;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *etcButtons;

@property NSMutableString *mString;

@property NSString *lastPushedString;
@property NSInteger lastOperator;

@property BOOL isTurnedOperator;

@property CalculatorStack *cStack;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self ButtonsAddGesture];
    self.mString = [@"0" mutableCopy];
    self.lastPushedString = self.mString;
    self.isTurnedOperator = YES;
    self.cStack = CalculatorStack.shared;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    UIColor *borderColor = [UIColor colorWithRed:221/255.0 green:222/255.0 blue:224/255.0 alpha:1];
    [self.titleView addLayerWithWidth:1 color:borderColor top:YES left:NO right:NO bottom:YES];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext>  _Nonnull context) {
        UIColor *borderColor = [UIColor colorWithRed:221/255.0 green:222/255.0 blue:224/255.0 alpha:1];
        [self.titleView addLayerWithWidth:1 color:borderColor top:YES left:NO right:NO bottom:YES];
    } completion:nil];
}

- (void)ButtonsAddGesture {
    for (UIView *buttonView in self.functionButtons) {
        UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(operatorBtnTouched:)];
        [tap setMinimumPressDuration:0.02];
        [buttonView addGestureRecognizer:tap];
    }
    
    for (UIView *buttonView in self.numberButtons) {
        UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(numBtnTouched:)];
        [tap setMinimumPressDuration:0.02];
        [buttonView addGestureRecognizer:tap];
    }
    
    for (UIView *buttonView in self.etcButtons) {
        UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(etcBtnTouched:)];
        [tap setMinimumPressDuration:0.02];
        [buttonView addGestureRecognizer:tap];
    }
    
    
}

- (void)numBtnTouched: (UILongPressGestureRecognizer *)gesture {
    [self changeOpacityFromGesture:gesture];
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        NSInteger length = [self.mString containsString:@"."] ? self.mString.length - 1 : self.mString.length;
        if (length > 8) {
            return;
        }
        
        if ([self.mString isEqualToString:@"0"] || [self.mString isEqualToString:@"-0"])
            [self.mString replaceCharactersInRange:NSMakeRange(self.mString.length - 1, 1) withString:@""];
        
        [self.mString appendString:[NSString stringWithFormat:@"%ld", gesture.view.tag]];
        
        self.textLabel.text = self.mString;
        self.isTurnedOperator = YES;
    }
}

- (void)operatorBtnTouched: (UILongPressGestureRecognizer *)gesture {
    [self changeOpacityFromGesture:gesture];
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        NSNumber *op = [NSNumber numberWithInteger:gesture.view.tag];
        
        
        
        // Result 예외처리
        if ([op integerValue] == RESULT) {
            if ([self.cStack operatorCount] == 0) {
                return;
            }
//
//            if ([self.cStack operandCount] == 1 && [self.cStack operatorCount] == 1) {
//                [self.cStack operatorPop];
//                return;
//            }
        }
    
        [self.cStack push:self.mString];
        
        if([[self.cStack operatorPeek] integerValue] == MULTIPLE || [[self.cStack operatorPeek] integerValue] == DIVISION) {
            [self.cStack calculate];
        }
        
        if ([op integerValue] == ADD || [op integerValue] == SUB) {
            [self.cStack calculate];
        }
        
        [self.cStack push:op];
        
        self.mString = [@"0" mutableCopy];
        self.textLabel.text = [self.cStack operandPeek];
    }
}

- (void)etcBtnTouched: (UILongPressGestureRecognizer *)gesture {
    [self changeOpacityFromGesture:gesture];
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        switch (gesture.view.tag) {
            case POINT: {
                if (self.mString.length < 10 && ![self.mString containsString:@"."])
                    [self.mString appendString:@"."];
                
                break;
            }
            case PLUSMINUS: {
                if ([self.mString containsString:@"-"])
                    [self.mString deleteCharactersInRange: NSMakeRange(0, 1)];
                else
                    [self.mString insertString:@"-" atIndex:0];
                break;
            }
            case C: {
                [self.cStack clearStack];
                self.lastOperator = 0;
                self.lastPushedString = @"0";
            }
            case CE: {
                self.mString = [@"0" mutableCopy];
                break;
            }
            case DELETE: {
                NSInteger length = self.mString.length;
                if (([self.mString containsString:@"-"] && length == 2) || length == 1)
                    self.mString = [@"0" mutableCopy];
                else
                    [self.mString deleteCharactersInRange: NSMakeRange(length - 1, 1)];
                break;
            }
            default:
                break;
        }
        
        self.textLabel.text = self.mString;
        self.isTurnedOperator = YES;
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

@end



