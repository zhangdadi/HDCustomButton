//
//  UIViewController+HDCustomButton.h
//  HDCustomButtonExample
//
//  Created by Aaron(张达棣) on 16/4/13.
//  Copyright © 2016年 HD. All rights reserved.
//
//  HDCustomButton https://github.com/zhangdadi/HDCustomButton
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.


#import <UIKit/UIKit.h>

/**
 *  导航栏按钮类型
 */
typedef NS_ENUM(NSUInteger, HDButtonType) {
    /**
     *  返回按钮 - 有右滑返回手势功能
     */
    HDButtonTypeBack = 0,
    /**
     *  导航栏左边按钮 - 无右滑返回手势功能
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

/**
 *  回调targe
 */
@property (nonatomic, copy, readonly) UIViewController<HDCustomButtonProtocol> *(^hd_targe)(id targe, SEL action);

/**
 *  回调block
 */
@property (nonatomic, copy, readonly) UIViewController<HDCustomButtonProtocol> *(^hd_block)(HDButtonTypeBlock hd_block);

/**
 *  完成
 */
@property (nonatomic, copy, readonly) UIBarButtonItem *(^hd_end)();

@end


@interface UIViewController (HDCustomButton)<HDCustomButtonProtocol>

@end
