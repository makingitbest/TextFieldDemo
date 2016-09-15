//
//  ViewController.m
//  TextFieldDemo
//
//  Created by WangQiao on 16/9/3.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import "ViewController.h"
#import "UIView+SetRect.h"
#import "UITextField+CreateInputAccessoryView.h"

@interface ViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITextField  *textField;

@property (nonatomic, strong) UITextField  *normalTextField;

@property (nonatomic, strong) UITextField  *nameTextField;

@property (nonatomic, strong) UITextField  *passWordTextFeild;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    
    {
        self.textField = [[UITextField alloc] initWithFrame:CGRectMake(15, Height/ 2.0f - 100, Width - 30, 44)];
        self.textField.borderStyle = UITextBorderStyleRoundedRect;
        self.textField.placeholder = @"请测试";
        self.textField.delegate    = self;
        
        UIView *inputViewAccessoryView           = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Width, 40)];
        inputViewAccessoryView.layer.borderWidth = 1;
        inputViewAccessoryView.backgroundColor   = [UIColor grayColor];
        
        UILabel *label      = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        label.text          = @"逢佳节";
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor     = [UIColor blueColor];
        [inputViewAccessoryView addSubview:label];
        
        self.textField.inputAccessoryView      = inputViewAccessoryView;
        [self.scrollView addSubview:self.textField];
    }
    
    {
        self.normalTextField = [[UITextField alloc] initWithFrame:CGRectMake(15, Height / 2.0f - 50, Width - 30, 44)];
        self.normalTextField.borderStyle = UITextBorderStyleRoundedRect;
        self.normalTextField.placeholder = @"普通";
        self.normalTextField.delegate    = self;
        [self.normalTextField createInputAccessoryViewWithHeight:40]; 
        [self.scrollView addSubview:self.normalTextField];
    }
    
    {
        self.nameTextField                    = [[UITextField alloc] initWithFrame:CGRectMake(15, Height/ 2.0f, Width - 30, 44)];
        self.nameTextField.borderStyle        = UITextBorderStyleRoundedRect;
        self.nameTextField.placeholder        = @"请输入姓名";
        self.nameTextField.delegate           = self;
        [self.nameTextField createInputAccessoryViewWithHeight:40 inputAccessoryView:^(UIView *inputAccessoryView) {
            
            inputAccessoryView.layer.borderWidth = 1.f;
            inputAccessoryView.backgroundColor   = [UIColor grayColor];
            
            // 这里的button 没有添加什么事件,点击响应的是self.passWordTextFeild
            UIButton *button  = [[UIButton alloc] initWithFrame:CGRectMake(Width - 110, 5, 100, 30)];
            [button setTitle:@"点击跳转" forState:UIControlStateNormal];
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [inputAccessoryView addSubview:button];
        }];
        
        [self.scrollView addSubview:self.nameTextField];
    }
    
    // 这里封装的方法,将点击事件传出
    
    {
        self.passWordTextFeild                    = [[UITextField alloc] initWithFrame:CGRectMake(15, Height/ 2.0f + 50, Width - 30, 44)];
        self.passWordTextFeild.borderStyle        = UITextBorderStyleRoundedRect;
        self.passWordTextFeild.placeholder        = @"请输入密码";
        self.passWordTextFeild.delegate           = self;
        [self.passWordTextFeild createInputAccessoryViewWithHeight:40 config:^(UITextField *textField, UIView *inputAccessoryView) {
            
            inputAccessoryView.backgroundColor   = [UIColor grayColor];
            
            // 在 inputAccessoryView 上添加一个按钮,用于处理点击事件,收回键盘
            UIButton *button         = [[UIButton alloc] initWithFrame:CGRectMake(Width - 80, 10, 50, 30)];
            [button setTitle:@"确定" forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button addTarget:textField action:@selector(resignFirstResponder) forControlEvents:UIControlEventTouchUpInside];
            [inputAccessoryView addSubview:button];
        }];
        
        [self.scrollView addSubview:self.passWordTextFeild];
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapEvent:)];
    [self.view addGestureRecognizer:tap];
}

- (void)tapEvent:(UITapGestureRecognizer *)tap {
    
    [self.view endEditing:YES];
}


- (void)buttonClick:(UIButton *)button{
    
    [self.passWordTextFeild becomeFirstResponder];
    
    NSLog(@"我被点击了,self 代表了本控制器");
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return YES;
}

//  已经开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    
    
    [UIView animateWithDuration:0.35f animations:^{
        
        if ([self.normalTextField isEqual:textField]) {
            
            self.scrollView.contentOffset = CGPointMake(0, 50);
        }
        
        if ([textField isEqual:self.nameTextField]) {
            
            self.scrollView.contentOffset = CGPointMake(0, 80);
        }

        if ([textField isEqual:self.passWordTextFeild]) {
            
            self.scrollView.contentOffset = CGPointMake(0, 100);
        }
    }];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    return YES;
}

// 已经结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [UIView animateWithDuration:0.35f animations:^{
        
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }];
}

// 控制文字输入的长度
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (textField.text.length > 10) {
        
        return NO;
        
    } else {
        
        return YES;
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    
    return YES;
}

// 按return收回键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
    return YES;
}

@end


