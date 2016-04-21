//
//  UIViewController+HDCustomButton.m
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


#import "UIViewController+HDCustomButton.h"
#import <objc/runtime.h>

@implementation UIViewController (HDCustomButton)

static char HDCustomButtonTypeViewKey;
static char HDCustomButtonTitleViewKey;
static char HDCustomButtonImageNameViewKey;

static char HDCustomButtonClickTargeViewKey;
static char HDCustomButtonClickActionViewKey;
static char HDCustomButtonClickBlockViewKey;




- (UIViewController<HDCustomButtonProtocol> *(^)(HDButtonType))hd_type {
    return ^id(HDButtonType hd_type) {
        objc_setAssociatedObject(self, &HDCustomButtonTypeViewKey,
                                 @(hd_type),
                                 OBJC_ASSOCIATION_ASSIGN);
        return self;
    };
}

- (UIViewController<HDCustomButtonProtocol> *(^)(NSString *))hd_title {
    return ^id(NSString *hd_title) {
        objc_setAssociatedObject(self, &HDCustomButtonTitleViewKey,
                                 hd_title,
                                 OBJC_ASSOCIATION_ASSIGN);
        return self;
    };
}

- (UIViewController<HDCustomButtonProtocol> *(^)(NSString *))hd_imageName {
    return ^id(NSString *hd_imageName) {
        objc_setAssociatedObject(self, &HDCustomButtonImageNameViewKey,
                                 hd_imageName,
                                 OBJC_ASSOCIATION_ASSIGN);
        return self;
    };
}

- (UIViewController<HDCustomButtonProtocol> *(^)(id, SEL))hd_targe {
    return ^id(id hd_targe, SEL hd_action) {
        
        objc_setAssociatedObject(self, &HDCustomButtonClickTargeViewKey,
                                 hd_targe,
                                 OBJC_ASSOCIATION_ASSIGN);
        
        objc_setAssociatedObject(self, &HDCustomButtonClickActionViewKey,
                                 NSStringFromSelector(hd_action),
                                 OBJC_ASSOCIATION_ASSIGN);

        return self;
    };
}

- (UIViewController<HDCustomButtonProtocol> *(^)(HDButtonTypeBlock))hd_block {
    return ^id(HDButtonTypeBlock hd_block) {
        objc_setAssociatedObject(self, &HDCustomButtonClickBlockViewKey,
                                 hd_block,
                                 OBJC_ASSOCIATION_COPY_NONATOMIC);
        return self;
    };
}


- (UIBarButtonItem *(^)())hd_end {
    return ^id() {
     
        HDButtonType type = [objc_getAssociatedObject(self, &HDCustomButtonTypeViewKey) integerValue];
        NSString *title = objc_getAssociatedObject(self, &HDCustomButtonTitleViewKey);
        NSString *imageName = objc_getAssociatedObject(self, &HDCustomButtonImageNameViewKey);
        
        id targe = objc_getAssociatedObject(self, &HDCustomButtonClickTargeViewKey);
        NSString *actionStr = objc_getAssociatedObject(self, &HDCustomButtonClickActionViewKey);
        HDButtonTypeBlock block = objc_getAssociatedObject(self, &HDCustomButtonClickBlockViewKey);
    
        if (type == HDButtonTypeBack) {
            if (title.length == 0 && imageName.length != 0) {
                title = @"返回";
            }
            
            if (imageName.length == 0) {
                imageName = @"back";
            }
        }
        
        UIBarButtonItem *barButtonItem = [self customNavButtonWithTitle:title imageName:imageName target:self action:@selector(hd_navButtonClickWithButton:)];
        
        objc_setAssociatedObject(barButtonItem.customView, &HDCustomButtonClickTargeViewKey,
                                 targe,
                                 OBJC_ASSOCIATION_ASSIGN);
        
        objc_setAssociatedObject(barButtonItem.customView, &HDCustomButtonClickActionViewKey,
                                 actionStr,
                                 OBJC_ASSOCIATION_COPY_NONATOMIC);
        
        objc_setAssociatedObject(barButtonItem.customView,
                                 &HDCustomButtonClickBlockViewKey,
                                 block,
                                 OBJC_ASSOCIATION_COPY_NONATOMIC);

        
        switch (type) {
            case HDButtonTypeBack:
            {
                if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
                    NSArray *viewControllers = self.navigationController.viewControllers;
                    if (viewControllers.count >= 2) {
                        ((UIViewController *)viewControllers[viewControllers.count - 2]).navigationItem.title = @"";
                    }
                }
            }

            case HDButtonTypeLeft: {
                [self.navigationItem setHidesBackButton:YES];
                [self.navigationItem setLeftBarButtonItem:barButtonItem];
                break;
            }
                
            case HDButtonTypeRight: {
                ((UIButton *)barButtonItem.customView).contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
                [self.navigationItem setRightBarButtonItem:barButtonItem];
                break;
            }
                
            default:
                break;
        }
        
        [self hd_clean];
        return barButtonItem;
    };
}

- (UIBarButtonItem *)customNavButtonWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)targe action:(SEL)action {
    UIButton *itemButtom = [UIButton buttonWithType:UIButtonTypeCustom];
    
    UIImage *image;
    if (imageName != nil) {
        image = [UIImage imageNamed:imageName];
        [itemButtom setImage:image forState:UIControlStateNormal];
    }
    
    itemButtom.titleLabel.font = [UIFont systemFontOfSize: 16];
    [itemButtom setTitle:title forState:UIControlStateNormal];
    [itemButtom setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    UIColor *color = [UINavigationBar appearance].tintColor;
    if (color == nil) {
        color = [UIColor blackColor];
    }
    [itemButtom setTitleColor:color forState:UIControlStateNormal];
    itemButtom.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [itemButtom addTarget:targe action:action forControlEvents:UIControlEventTouchUpInside];
    if (title == nil && imageName != nil) {
        [itemButtom setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    } else {
        [itemButtom setFrame:CGRectMake(0, 0, 80, 40)];
    }
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]
                                      initWithCustomView:itemButtom];
    return barButtonItem;
}

- (void)hd_navButtonClickWithButton:(id)button {
    
    id targe = objc_getAssociatedObject(button, &HDCustomButtonClickTargeViewKey);
    SEL action = NSSelectorFromString(objc_getAssociatedObject(button, &HDCustomButtonClickActionViewKey));
    if ([targe respondsToSelector:action]) {
        IMP imp = [targe methodForSelector:action];
        void (*func)(id, SEL) = (void *)imp;
        func(targe, action);
    }
    
    HDButtonTypeBlock block = objc_getAssociatedObject(button, &HDCustomButtonClickBlockViewKey);
    if (block) {
        block();
    }
}

- (void)hd_clean {
    self.hd_title(nil);
    self.hd_imageName(nil);
    self.hd_targe(nil, nil);
    self.hd_block(nil);
}

@end
