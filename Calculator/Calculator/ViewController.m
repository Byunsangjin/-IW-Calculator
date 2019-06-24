//
//  ViewController.m
//  Calculator
//
//  Created by Byunsangjin on 24/06/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIView *plusView;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *functionButtons;
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *numberButtons;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (UIView *buttonView in self.functionButtons) {
        UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(touchView:)];
        [tap setMinimumPressDuration:0.05];
        [buttonView addGestureRecognizer:tap];
    }
    
    for (UIView *buttonView in self.numberButtons) {
        UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(touchView:)];
        [tap setMinimumPressDuration:0.05];
        [buttonView addGestureRecognizer:tap];
    }
}

- (void)touchView: (UILongPressGestureRecognizer *)gesture {
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
