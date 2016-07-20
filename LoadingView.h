//
//  LoadingView.h
//  LimitFree
//
//  Created by Hailong.wang on 15/8/27.
//  Copyright (c) 2015年 Hailong.wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView {
    //你懂的
    UIActivityIndicatorView *_activity;
    //黑色的背景
    UIView *_backView;
    //提示语
    UILabel *_alertLabel;
}

//初始化
+ (LoadingView *)shareSingleton;
//召唤loading页
+ (void)showLoadingView:(UIView *)superView;
//隐藏
+ (void)hideLoadingView;
@end





