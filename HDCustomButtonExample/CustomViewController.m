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

@end

@implementation CustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.hd_type(HDButtonTypeBack).hd_targe(self, @selector(leftButtonClick)).hd_end();
    self.hd_type(HDButtonTypeRight).hd_title(@"测试").hd_targe(self, @selector(rightButtonClick)).hd_end();
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
