//
//  HCToastHUD.h
//  HelperCar
//
//  Created by Jentle on 16/8/10.
//  Copyright © 2016年 allydata. All rights reserved.
//  成功和失败的提示，自动隐藏

#import <UIKit/UIKit.h>

@interface HCToastHUD : UIView

/**
 *  操作成功的提示
 *
 *  @param status 提示文字
 */
+ (void)showSuccessWithStatus:(NSString *)status;
/**
 *  操作失败的提示
 *
 *  @param status 提示文字
 */
+ (void)showErrorWithStatus:(NSString *)status;
/**
 *  操作警告的提示
 *
 *  @param status 提示文字
 */
+ (void)showWarningWithStatus:(NSString *)status;
/**
 *  操作成功的提示
 *
 *  @param view   父视图
 *  @param status 提示文字
 */
+ (void)showSuccessForView:(UIView *)view withStatus:(NSString *)status;
/**
 *  操作失败的提示
 *
 *  @param view   父视图
 *  @param status 提示文字
 */
+ (void)showErrorForView:(UIView *)view withStatus:(NSString *)status;
/**
 *  操作警告的提示
 *
 *  @param status 提示文字
 */
+ (void)showWarningForView:(UIView *)view withStatus:(NSString *)status;


@end
