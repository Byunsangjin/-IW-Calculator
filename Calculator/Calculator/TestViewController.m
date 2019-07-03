//
//  TestViewController.m
//  Calculator
//
//  Created by Byunsangjin on 02/07/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

#import "TestViewController.h"
#import "ViewController.h"

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

// MARK:- Actions
- (IBAction)buttonTouched:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ViewController *VC = (ViewController *)[storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
    
    [self addChildViewController:VC];
    [self.view addSubview:VC.view];
}

@end
