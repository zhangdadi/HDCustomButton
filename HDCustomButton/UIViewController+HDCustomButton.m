//
//  UIViewController+HDCustomButton.m
//  HDCustomButtonExample
//
//  Created by Aaron on 16/4/13.
//  Copyright © 2016年 HD. All rights reserved.
//

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

//- (UIViewController<HDCustomButtonProtocol> *(^)(SEL))hd_action {
//    return ^id(SEL hd_action) {
//        objc_setAssociatedObject(self, &HDCustomButtonClickActionViewKey,
//                                 NSStringFromSelector(hd_action),
//                                 OBJC_ASSOCIATION_ASSIGN);
//        return self;
//    };
//}

//- (UIViewController<HDCustomButtonProtocol> *(^)(HDButtonTypeBlock))hd_clickBlock {
//    return ^id(HDButtonTypeBlock hd_clickBlock) {
//        objc_setAssociatedObject(self, &HDCustomButtonClickBlockViewKey,
//                                 hd_clickBlock,
//                                 OBJC_ASSOCIATION_ASSIGN);
//        return self;
//    };
//}


- (UIBarButtonItem *(^)())hd_end {
    return ^id() {
     
        HDButtonType type = [objc_getAssociatedObject(self, &HDCustomButtonTypeViewKey) integerValue];
        NSString *title = objc_getAssociatedObject(self, &HDCustomButtonTitleViewKey);
        NSString *imageName = objc_getAssociatedObject(self, &HDCustomButtonImageNameViewKey);
        
        id targe = objc_getAssociatedObject(self, &HDCustomButtonClickTargeViewKey);
        SEL action = NSSelectorFromString(objc_getAssociatedObject(self, &HDCustomButtonClickActionViewKey));
        
        if (type == HDButtonTypeBack) {
            if (title.length == 0 && imageName.length != 0) {
                title = @"返回";
            }
            
            if (imageName.length == 0) {
                imageName = @"back";
            }
        }
        
        UIBarButtonItem *barButtonItem = [self customNavButtonWithTitle:title imageName:imageName target:targe action:action];
        
        switch (type) {
            case HDButtonTypeBack:
            {
                if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
                    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
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
        
        return barButtonItem;
    };
}

- (UIBarButtonItem *)customNavButtonWithTitle:(NSString *)title imageName:(NSString *)imageName target:(id)targe action:(SEL)action {
    UIButton *itemButtom = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:imageName];
    [itemButtom setImage:image forState:UIControlStateNormal];
    itemButtom.titleLabel.font = [UIFont systemFontOfSize: 16];
    [itemButtom setTitle:title forState:UIControlStateNormal];
    [itemButtom setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, -5)];
    UIColor *color = [UINavigationBar appearance].tintColor;
    if (color == nil) {
        color = [UIColor blackColor];
    }
    [itemButtom setTitleColor:color forState:UIControlStateNormal];
    itemButtom.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [itemButtom addTarget:targe action:action
         forControlEvents:UIControlEventTouchUpInside];
    if (title == nil && imageName != nil) {
        [itemButtom setFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    } else {
        [itemButtom setFrame:CGRectMake(0, 0, 80, 40)];
    }
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc]
                                      initWithCustomView:itemButtom];
    return barButtonItem;
}

//- (void)hd_navButtonClick {
//    HDButtonTypeBlock block = objc_getAssociatedObject(self, &HDCustomButtonClickBlockViewKey);
//    if (block) {
//        block();
//    }
//}


@end
