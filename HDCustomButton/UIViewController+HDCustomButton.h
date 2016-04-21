//
//  UIViewController+HDCustomButton.h
//  HDCustomButtonExample
//
//  Created by Aaron on 16/4/13.
//  Copyright © 2016年 HD. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  导航栏按钮类型
 */
typedef NS_ENUM(NSUInteger, HDButtonType) {
    /**
     *  返回按钮
     */
    HDButtonTypeBack = 0,
    /**
     *  导航栏左边按钮
     */
    HDButtonTypeLeft,
    /**
     *  导航栏右边按钮
     */
    HDButtonTypeRight,
    /**
     *  导航栏按钮
     */
    HDButtonTypeNav
};


typedef void(^HDButtonTypeBlock)();


@protocol HDCustomButtonProtocol <NSObject>

/**
 *  按钮类型
 */
@property (nonatomic, copy, readonly) UIViewController<HDCustomButtonProtocol> *(^hd_type)(HDButtonType hd_type);

/**
 *  按钮标题
 */
@property (nonatomic, copy, readonly) UIViewController<HDCustomButtonProtocol> *(^hd_title)(NSString *hd_title);

/**
 *  按钮图片
 */
@property (nonatomic, copy, readonly) UIViewController<HDCustomButtonProtocol> *(^hd_imageName)(NSString *hd_imageName);

@property (nonatomic, copy, readonly) UIViewController<HDCustomButtonProtocol> *(^hd_targe)(id targe, SEL action);

//@property (nonatomic, copy, readonly) UIViewController<HDCustomButtonProtocol> *(^hd_clickBlock)(HDButtonTypeBlock hd_clickBlock);

/**
 *  完成
 */
@property (nonatomic, copy, readonly) UIBarButtonItem *(^hd_end)();

@end


@interface UIViewController (HDCustomButton)<HDCustomButtonProtocol>

@end
