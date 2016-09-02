//
//  HCToastHUD.m
//  HelperCar
//
//  Created by Jentle on 16/8/10.
//  Copyright © 2016年 allydata. All rights reserved.
//

#import "HCToastHUD.h"
#import "HCToastHUD.bundle/HCToastConfig.h"

static CFTimeInterval const kDefaultForwardAnimationDuration = 0.5;
static CFTimeInterval const kDefaultBackwardAnimationDuration = 0.5;
static CFTimeInterval const kDefaultWaitAnimationDuration = 1.0;


static HCToastHUD *toastHUD;

@interface HCToastHUD()

@property (nonatomic, assign) CFTimeInterval  forwardAnimationDuration;
@property (nonatomic, assign) CFTimeInterval  backwardAnimationDuration;
@property (nonatomic, assign) UIEdgeInsets    textInsets;
@property (nonatomic, assign) CGFloat         maxWidth;

@end

@implementation HCToastHUD

+ (void)initialize{
    toastHUD = [[HCToastHUD alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.forwardAnimationDuration = kDefaultForwardAnimationDuration;
        self.backwardAnimationDuration = kDefaultBackwardAnimationDuration;
    }
    return self;
}
/**
 *  操作成功的提示
 *
 *  @param status 提示文字
 */
+ (void)showSuccessWithStatus:(NSString *)status{
    [self showSuccessForView:kWindow withStatus:status];
}
/**
 *  操作失败的提示
 *
 *  @param status 提示文字
 */
+ (void)showErrorWithStatus:(NSString *)status{
    [self showErrorForView:kWindow withStatus:status];
}
/**
 *  操作警告的提示
 *
 *  @param status 提示文字
 */
+ (void)showWarningWithStatus:(NSString *)status{
    [self showWarningForView:kWindow withStatus:status];
}
/**
 *  操作成功的提示
 *
 *  @param view   父视图
 *  @param status 提示文字
 */
+ (void)showSuccessForView:(UIView *)view withStatus:(NSString *)status{
    NSBundle *bundle = [NSBundle bundleForClass:[HCToastHUD class]];
    NSURL *url = [bundle URLForResource:@"HCToastHUD" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    UIImage *successImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"success" ofType:@"png"]];
    [toastHUD addToastWithImage:successImage view:view status:status];

}
/**
 *  操作失败的提示
 *
 *  @param view   父视图
 *  @param status 提示文字
 */
+ (void)showErrorForView:(UIView *)view withStatus:(NSString *)status{
    NSBundle *bundle = [NSBundle bundleForClass:[HCToastHUD class]];
    NSURL *url = [bundle URLForResource:@"HCToastHUD" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    UIImage *errorImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"error" ofType:@"png"]];
    [toastHUD addToastWithImage:errorImage view:view status:status];
    
}
/**
 *  操作警告的提示
 *
 *  @param status 提示文字
 */
+ (void)showWarningForView:(UIView *)view withStatus:(NSString *)status{
    NSBundle *bundle = [NSBundle bundleForClass:[HCToastHUD class]];
    NSURL *url = [bundle URLForResource:@"HCToastHUD" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    UIImage *infoImage = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"info" ofType:@"png"]];
    [toastHUD addToastWithImage:infoImage view:view status:status];
}


/**
 *  设置子控件以及布局
 */
- (void)addToastWithImage:(UIImage *)image view:(UIView *)view  status:(NSString *)status{
    BOOL isAddSuperView = NO;
    for (UIView *item in view.subviews) {
        if ([item isKindOfClass:[HCToastHUD class]]) {
            isAddSuperView = YES;
        }
    }
    if (isAddSuperView) return;
    toastHUD.backgroundColor = [UIColor clearColor];
    CGFloat toastHUDW = kScreenWidth;
    CGFloat toastHUDH = kScreenHeight-kUpSpare-kTabBarHeight;
    CGFloat toastHUDX = 0;
    CGFloat toastHUDY = kUpSpare;
    toastHUD.frame = CGRectMake(toastHUDX, toastHUDY, toastHUDW, toastHUDH);
    [view addSubview:toastHUD];
    
    CGFloat successViewDefaultW = ALDHeight(280);
    CGFloat successViewDefaultH = ALDHeight(140);
    UIView *successView = [[UIView alloc] init];
    UIColor *successViewBgColor = [UIColor blackColor];
    successView.backgroundColor = [successViewBgColor colorWithAlphaComponent:0.9];
    successView.layer.cornerRadius = 8.0f;
    successView.layer.masksToBounds = YES;
    [toastHUD addSubview:successView];
    [toastHUD addAnimationGroupWithView:successView];
    
    //动态计算文字的宽度
    CGSize statusSize = [toastHUD sizeForString:status font:HCFontWithPixel(26) size:CGSizeMake(CGFLOAT_MAX, ALD(26))];
    
    //加载框宽度动态适应
    CGFloat ststusMargin = ALD(20);
    CGFloat otherMargin = ALD(26);
    statusSize.width += otherMargin;
    if (statusSize.width > successViewDefaultW - 2*ststusMargin) {
        //限制最大宽度
        if (statusSize.width > kScreenWidth - ALD(180)*2) {
            statusSize.width = kScreenWidth - ALD(180)*2;
        }
        
        [successView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(toastHUD);
            make.size.equalTo(CGSizeMake(statusSize.width + 2*ststusMargin, successViewDefaultH));
        }];
        
    }else{
        [successView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(toastHUD);
            make.size.equalTo(CGSizeMake(successViewDefaultW, successViewDefaultH));
        }];
    }
    


    UIImage *tintedImage = [toastHUD image:image withTintColor:[UIColor whiteColor]];
    UIImageView *successIcon = [[UIImageView alloc] initWithImage:tintedImage];
    [successView addSubview:successIcon];
    [successIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(successView);
        make.top.equalTo(successView).offset(ALDHeight(15));
    }];
    
    UILabel *successLabel = [[UILabel alloc] init];
    successLabel.textColor = [self colorWithHexColorString:@"#FFFFFF"];
    successLabel.textAlignment = NSTextAlignmentCenter;
    successLabel.text = status;
    successLabel.font = [UIFont systemFontOfSize:ALD(26)];
    [successView addSubview:successLabel];
    [successLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(successView);
        make.bottom.equalTo(successView).offset(-ALDHeight(15));
        make.size.equalTo(CGSizeMake(statusSize.width, statusSize.height));
    }];
}
/**
 *  图片颜色渲染
 *
 *  @param image 原图片
 *  @param color 渲染色
 *
 *  @return 渲染后的颜色
 */
-  (UIImage*)image:(UIImage *)image withTintColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, image.scale);
    CGContextRef c = UIGraphicsGetCurrentContext();
    [image drawInRect:rect];
    CGContextSetFillColorWithColor(c, [color CGColor]);
    CGContextSetBlendMode(c, kCGBlendModeSourceAtop);
    CGContextFillRect(c, rect);
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tintedImage;
}
/**
 *  动画组
 */
- (void)addAnimationGroupWithView:(UIView *)view{
    CABasicAnimation *forwardAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    forwardAnimation.duration = self.forwardAnimationDuration;
    forwardAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5f :1.7f :0.6f :0.85f];
    forwardAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    forwardAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    
    CABasicAnimation *backwardAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    backwardAnimation.duration = self.backwardAnimationDuration;
    backwardAnimation.beginTime = forwardAnimation.duration + kDefaultWaitAnimationDuration;
    backwardAnimation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.4f :0.15f :0.5f :-0.7f];
    backwardAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    backwardAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[forwardAnimation,backwardAnimation];
    animationGroup.duration = forwardAnimation.duration + backwardAnimation.duration + kDefaultWaitAnimationDuration;
    animationGroup.removedOnCompletion = NO;
    animationGroup.delegate = self;
    animationGroup.fillMode = kCAFillModeForwards;
    
    [view.layer addAnimation:animationGroup forKey:nil];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if(flag){
        [self removeFromSuperview];
    }
}

- (CGSize)sizeForString:(NSString *)string font:(UIFont *)font size:(CGSize)size
{
    return [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : font} context:nil].size;
}

- (UIColor *)colorWithHexColorString:(NSString *)hexColorString{
    
    return [self colorWithHexColorString:hexColorString alpha:1.0f];
}

- (UIColor *)colorWithHexColorString:(NSString *)hexColorString alpha:(float)alpha
{
    if ([hexColorString length] <6){//长度不合法
        return [UIColor blackColor];
    }
    NSString *tempString=[hexColorString lowercaseString];
    if ([tempString hasPrefix:@"0x"]){//检查开头是0x
        tempString = [tempString substringFromIndex:2];
    }else if ([tempString hasPrefix:@"#"]){//检查开头是#
        tempString = [tempString substringFromIndex:1];
    }
    if ([tempString length] !=6){
        return [UIColor blackColor];
    }
    //分解三种颜色的值
    NSRange range;
    range.location =0;
    range.length =2;
    NSString *rString = [tempString substringWithRange:range];
    range.location =2;
    NSString *gString = [tempString substringWithRange:range];
    range.location =4;
    NSString *bString = [tempString substringWithRange:range];
    //取三种颜色值
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString]scanHexInt:&r];
    [[NSScanner scannerWithString:gString]scanHexInt:&g];
    [[NSScanner scannerWithString:bString]scanHexInt:&b];
    return [UIColor colorWithRed:((float) r /255.0f)
                           green:((float) g /255.0f)
                            blue:((float) b /255.0f)
                           alpha:alpha];
}


@end
