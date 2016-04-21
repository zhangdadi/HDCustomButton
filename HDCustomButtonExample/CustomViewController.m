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
    self.title = @"演示";
    
    __weak typeof(self) weakSelf = self;
    
    
    switch (_index) {
        case 0: //返回按钮 - 默认 - action回调
        {
            self.hd_type(HDButtonTypeBack).hd_targe(self, @selector(leftButtonClick)).hd_end();
            break;
        }
        case 1: //返回按钮 - 默认 - block回调
        {
            self.hd_type(HDButtonTypeBack).hd_block(^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
                NSLog(@"leftButtonClick - block");
            }).hd_end();
            break;
        }
        case 2: //返回按钮 - 文字
        {
            self.hd_type(HDButtonTypeBack).hd_title(@"返回").hd_targe(self, @selector(leftButtonClick)).hd_end();
            break;
        }
        case 3: //返回按钮 - 图片
        {
            self.hd_type(HDButtonTypeBack).hd_imageName(@"icon_num_add").hd_targe(self, @selector(leftButtonClick)).hd_end();
            break;
        }
        case 4: //返回按钮 - 文字 & 图片
        {
            self.hd_type(HDButtonTypeBack).hd_title(@"自定义").hd_imageName(@"icon_num_add").hd_targe(self, @selector(leftButtonClick)).hd_end();
            break;
        }
            
        case 5: //右边按钮 - 文字
        {
            self.hd_type(HDButtonTypeRight).hd_title(@"右边").hd_targe(self, @selector(rightButtonClick)).hd_end();
            self.hd_type(HDButtonTypeBack).hd_targe(self, @selector(leftButtonClick)).hd_end();
            break;
        }
        case 6: //右边按钮 - 图片
        {
            self.hd_type(HDButtonTypeRight).hd_imageName(@"icon_num_add").hd_targe(self, @selector(rightButtonClick)).hd_end();
            self.hd_type(HDButtonTypeBack).hd_targe(self, @selector(leftButtonClick)).hd_end();
            break;
        }
        case 7: //右边按钮 - 文字 & 图片
        {
            self.hd_type(HDButtonTypeRight).hd_title(@"右边").hd_imageName(@"icon_num_add").hd_targe(self, @selector(rightButtonClick)).hd_end();
            self.hd_type(HDButtonTypeBack).hd_targe(self, @selector(leftButtonClick)).hd_end();
            break;
        }
        case 8: //右边按钮 - 多个按钮
        {
            UIBarButtonItem *item1 = self.hd_type(HDButtonTypeNav).hd_imageName(@"icon_num_add").hd_targe(self, @selector(rightButtonClick)).hd_end();
            UIBarButtonItem *item2 = self.hd_type(HDButtonTypeNav).hd_imageName(@"back").hd_targe(self, @selector(rightButtonClick)).hd_end();
            self.navigationItem.rightBarButtonItems = @[item1, item2];
            
            self.hd_type(HDButtonTypeBack).hd_targe(self, @selector(leftButtonClick)).hd_end();
            break;
        }
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)leftButtonClick {
    NSLog(@"leftButtonClick - action");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightButtonClick {
    NSLog(@"rightButtonClick - action");

}


@end
