//
//  ViewController.h
//  Calculator
//
//  Created by Byunsangjin on 24/06/2019.
//  Copyright © 2019 Byunsangjin. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
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

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *mainView;

@end

