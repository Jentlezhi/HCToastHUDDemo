//
//  ViewController.m
//  HCToastHUDDemo
//
//  Created by Jentle on 16/9/2.
//  Copyright © 2016年 Jentle. All rights reserved.
//

#import "ViewController.h"
#import "HCToastHUD.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.操作成功的提示
    [HCToastHUD showSuccessForView:self.view withStatus:@"设置成功"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //2.操作失败的提示
    [HCToastHUD showErrorForView:self.view withStatus:@"操作失败"];
}

@end
