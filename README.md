## HDCustomButton
* 用法简单的自定义导航栏按钮：一行代码搞定

##效果如下
![1](http://zhangdadi.github.io/image/HDCustomButton/1.gif)


##使用方法


* 返回按钮 - 默认 - action回调

```
self.hd_type(HDButtonTypeBack).hd_targe(self, @selector(leftButtonClick)).hd_end();

```

* 返回按钮 - 默认 - block回调

```
self.hd_type(HDButtonTypeBack).hd_block(^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
                NSLog(@"leftButtonClick - block");
            }).hd_end();

```

* 返回按钮 - 文字

```
self.hd_type(HDButtonTypeBack).hd_title(@"返回").hd_targe(self, @selector(leftButtonClick)).hd_end();

```

* 返回按钮 - 图片

```
            self.hd_type(HDButtonTypeBack).hd_imageName(@"icon_num_add").hd_targe(self, @selector(leftButtonClick)).hd_end();

```

* 返回按钮 - 文字 & 图片

```
                        self.hd_type(HDButtonTypeBack).hd_title(@"自定义").hd_imageName(@"icon_num_add").hd_targe(self, @selector(leftButtonClick)).hd_end();

```

* 右边按钮 - 多个按钮

```
       

```
