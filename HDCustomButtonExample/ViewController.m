//
//  ViewController.m
//  HDCustomButtonExample
//
//  Created by Aaron on 16/4/13.
//  Copyright © 2016年 HD. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+HDCustomButton.h"
#import "CustomViewController.h"

static NSString *KCellIdef = @"KCell";

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *typeArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"选择";
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:KCellIdef];
    _typeArray = @[
                   @[@0, @"返回按钮 - 默认 - action回调"],
                   @[@1, @"返回按钮 - 默认 - block回调"],
                   @[@2, @"返回按钮 - 文字"],
                   @[@3, @"返回按钮 - 图片"],
                   @[@4, @"返回按钮 - 文字 & 图片"],
                   
                   @[@5, @"右边按钮 - 文字"],
                   @[@6, @"右边按钮 - 图片"],
                   @[@7, @"右边按钮 - 文字 & 图片"],
                   
                   @[@8, @"右边按钮 - 多个按钮"],
                   ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _typeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KCellIdef forIndexPath:indexPath];
    cell.textLabel.text = _typeArray[indexPath.row][1];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    CustomViewController *next = [[CustomViewController alloc] init];
    next.index = indexPath.row;
    [self.navigationController pushViewController:next animated:YES];
}

@end
