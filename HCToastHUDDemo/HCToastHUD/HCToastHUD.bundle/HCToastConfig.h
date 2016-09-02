//
//  HCToastConfig.h
//  HCToastHUDDemo
//
//  Created by Jentle on 16/9/3.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#ifndef HCToastConfig_h
#define HCToastConfig_h
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#define kScreenWidth                ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight               ([UIScreen mainScreen].bounds.size.height)
#define HCApplication                [UIApplication sharedApplication]
#define kWindow                      HCApplication.keyWindow
#define kStatusBarHeight [HCApplication statusBarFrame].size.height
#define kNavigationBarHeight 44.f
#define kUpSpare ((kStatusBarHeight)+(kNavigationBarHeight))
#define kTabBarHeight   49.0f
#define ALD(x)                      ((x) * kScreenWidth/750.0)
#define ALDHeight(y)                ((y) * kScreenHeight/1334.0)
#define HCFontWithPixel(a)     [UIFont systemFontOfSize:ALD(a)]

#endif /* HCToastConfig_h */
