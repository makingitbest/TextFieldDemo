//
//  UITextField+CreateInputAccessoryView.h
//  TextFieldDemo
//
//  Created by WangQiao on 16/9/3.
//  Copyright © 2016年 WangQiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (CreateInputAccessoryView)

/**
 *  InputAccessoryView
 *
 *  @param height InputAccessoryView的高度设置,方法太简单,可以弃用了
 */
- (void)createInputAccessoryViewWithHeight:(CGFloat)height;

/**
 *  InputAccessoryView
 *
 *  @param height                  InputAccessoryView高度的设置
 *  @param inputAccessoryViewBlock 顺便在InputAccessoryView上面加载控件,这个方法不是很完善,方法可以弃用了
 */
- (void)createInputAccessoryViewWithHeight:(CGFloat)height
                        inputAccessoryView:(void (^)(UIView *inputAccessoryView))inputAccessoryViewBlock;

/**
 *  InputAccessoryView
 *
 *  @param height      InputAccessoryView高度的设置
 *  @param configBlock InputAccessoryView 加载控件,顺便实现控件对键盘的操作事件
 */
- (void)createInputAccessoryViewWithHeight:(CGFloat)height
                                    config:(void (^)(UITextField *textField, UIView *inputAccessoryView))configBlock;

@end
