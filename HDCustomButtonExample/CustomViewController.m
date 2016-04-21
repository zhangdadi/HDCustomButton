//
//  CustomViewController.m
//  HDCustomButtonExample
//
//  Created by Aaron on 16/4/13.
//  Copyright © 2016年 HD. All rights reserved.
//

#import "CustomViewController.h"
#import "UIViewController+HDCustomButton.h"

@interface CustomViewController ()
@property (nonatomic, strong) NSString *str;
@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //-------------------action回调按钮-----------------
    //默认的返回按钮
    self.hd_type(HDButtonTypeBack).hd_targe(self, @selector(leftButtonClick)).hd_end();
    
    self.hd_type(HDButtonTypeRight).hd_title(@"测试").hd_targe(self, @selector(rightButtonClick)).hd_end();
    
    
    //-------------------block回调按钮-----------------
    __weak typeof(self) weakSelf = self;
    
    //默认的返回按钮
    self.hd_type(HDButtonTypeBack).hd_clickBlock(^{
        NSLog(@"leftButtonClick-Block");
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }).hd_end();

    self.hd_type(HDButtonTypeRight).hd_title(@"测试").hd_clickBlock(^{
        NSLog(@"rightButtonClick-Block");
    }).hd_end();

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftButtonClick {
    NSLog(@"leftButtonClick");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonClick {
    NSLog(@"rightButtonClick");

}


@end
