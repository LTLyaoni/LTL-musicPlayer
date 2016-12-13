//
//  LTLTimeLineRefreshHeader.h
//  GSD_WeiXin(wechat)
//
//  Created by gsd on 16/3/5.
//  Copyright © 2016年 GSD. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "LTLBaseRefreshView.h"

@interface LTLTimeLineRefreshHeader : LTLBaseRefreshView

+ (nonnull instancetype)refreshHeaderWithCenter:( CGPoint)center iamge:( nullable UIImageView *)iamge refreshing:(nullable void (^)())LTL ;

@property (nonatomic, copy)  void(^ _Nullable refreshingBlock)();

@property(nonatomic,weak)  UIImageView * _Nullable imageView;


@end
