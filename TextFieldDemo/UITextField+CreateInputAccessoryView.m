//
//  UITextField+CreateInputAccessoryView.m
//  TextFieldDemo
//
//  Created by WangQiao on 16/9/3.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "UITextField+CreateInputAccessoryView.h"

@implementation UITextField (CreateInputAccessoryView)

- (void)createInputAccessoryViewWithHeight:(CGFloat)height {

    UIView *inputAccessoryView         = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height)];
    inputAccessoryView.backgroundColor = [UIColor greenColor];

    self.inputAccessoryView = inputAccessoryView;
}

- (void)createInputAccessoryViewWithHeight:(CGFloat)height
                        inputAccessoryView:(void (^)(UIView *inputAccessoryView))inputAccessoryViewBlock {

    UIView *inputAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height)];
    
    if (inputAccessoryViewBlock) {
        
        inputAccessoryViewBlock(inputAccessoryView);
    }
    
    self.inputAccessoryView = inputAccessoryView;
}


- (void)createInputAccessoryViewWithHeight:(CGFloat)height
                                    config:(void (^)(UITextField *textField, UIView *inputAccessoryView))configBlock {
    
    UIView *inputAccessoryView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, height)];
    
    if (configBlock) {
        
        configBlock(self, inputAccessoryView);
    }
    
    self.inputAccessoryView = inputAccessoryView;
}

@end
