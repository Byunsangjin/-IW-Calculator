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

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIView *titleView;
@property (strong, nonatomic) IBOutlet UILabel *textLabel;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *functionButtons;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *numberButtons;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *etcButtons;

@property double number;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self ButtonsAddGesture];
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
        NSMutableString *numString = [NSMutableString stringWithFormat:@"%.9g", self.number]; // 소수점을 제외하고 9자리 수의 double형 format
        if (numString.length >= 10) {
            return;
        }
        
        NSNumber *n = [NSNumber numberWithDouble:self.number];
        NSMutableString *stringNum = [[n stringValue] mutableCopy];
        
        if ([stringNum isEqualToString:@"0"]) {
            stringNum = [@"" mutableCopy];
        }
        
        [stringNum appendString:[NSString stringWithFormat:@"%ld", gesture.view.tag]];
        
        self.number = [stringNum doubleValue];
        self.textLabel.text = stringNum;
    }
}

- (void)operatorBtnTouched: (UILongPressGestureRecognizer *)gesture {
    [self changeOpacityFromGesture:gesture];
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        
    }
}

- (void)etcBtnTouched: (UILongPressGestureRecognizer *)gesture {
    [self changeOpacityFromGesture:gesture];
    
    if (gesture.state == UIGestureRecognizerStateEnded) {
        switch (gesture.view.tag) {
            case CE:
                self.number = 0;
                self.textLabel.text = @"0";
                break;
            default:
                break;
        }
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



