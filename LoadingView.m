//
//  LoadingView.m
//  LimitFree
//
//  Created by Hailong.wang on 15/8/27.
//  Copyright (c) 2015年 Hailong.wang. All rights reserved.
//

#import "LoadingView.h"

static LoadingView *loading = nil;

@implementation LoadingView

+ (LoadingView *)shareSingleton {
    if (!loading) {
        //以0，0，0，0的状态初始化
        //只有在展示的时候才能确定展示区域的大小
        loading = [[LoadingView alloc] initWithFrame:CGRectZero];
        loading.backgroundColor = [UIColor whiteColor];
    }
    return loading;
}

+ (void)showLoadingView:(UIView *)superView {
    if (!loading) {
        loading = [LoadingView shareSingleton];
    }
    loading.autoresizesSubviews = YES;
    loading.frame = superView.frame;
    [superView addSubview:loading];
}

+ (void)hideLoadingView {
    [loading hideView];
    [UIView animateWithDuration:1 animations:^{
        [loading setYOffset:loading.superview.height];
    } completion:^(BOOL finished) {
        [loading removeFromSuperview];
    }];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

//构建loadingView的视图内容
- (void)createView {
    //创建背景的黑色视图
    [self createBackView];
    //创建菊花
    [self createActivityView];
    //创建提示语标签
    [self createLabel];
}

- (void)createLabel {
    _alertLabel = [Factory createLabelWithTitle:@"玩命加载中" frame:CGRectMake(0, _activity.bottom, _backView.width, _backView.height - _activity.bottom)];
    _alertLabel.textAlignment = NSTextAlignmentCenter;
    _alertLabel.textColor = [UIColor whiteColor];
    [_backView addSubview:_alertLabel];
}

- (void)createActivityView {
    _activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    _activity.frame = CGRectMake((_backView.width - _activity.width)/2, (_backView.height - _activity.height)/2 - LeftDistance, _activity.width, _activity.height);
    //当菊花停止时候不隐藏😄
    _activity.hidesWhenStopped = NO;
    [_activity startAnimating];
    [_backView addSubview:_activity];
}

- (void)createBackView {
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    _backView.center = self.center;
    _backView.backgroundColor = RGBA(0, 0, 0, 0.5);
    //加圆角看着好看😄
    _backView.layer.cornerRadius = 3.f;
    _backView.layer.masksToBounds = YES;
    _backView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    [self addSubview:_backView];
}

- (void)hideView {
    [_activity stopAnimating];
    _alertLabel.text = @"加载完成";
    
}

@end










