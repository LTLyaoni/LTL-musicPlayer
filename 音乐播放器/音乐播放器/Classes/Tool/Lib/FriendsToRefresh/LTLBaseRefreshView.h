//
//  LTLBaseRefreshView.h
//  GSD_WeiXin(wechat)
//
//  Created by gsd on 16/3/5.
//  Copyright © 2016年 GSD. All rights reserved.
//



#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const kSDBaseRefreshViewObserveKeyPath;
UIKIT_EXTERN NSString *const LTLdecelerationRateObserveKeyPath;
typedef enum {
    SDWXRefreshViewStateNormal,
    SDWXRefreshViewStateWillRefresh,
    SDWXRefreshViewStateRefreshing,
} SDWXRefreshViewState;

@interface LTLBaseRefreshView : UIView
//{
//    /** 记录scrollView刚开始的inset */
//    UIEdgeInsets _scrollViewOriginalInset;
//}
@property (nonatomic, strong) UIScrollView *scrollView;
/** 记录scrollView刚开始的inset */
@property (nonatomic, assign) UIEdgeInsets scrollViewOriginalInset;

/** 进入刷新状态 */
- (void)beginRefreshing;
/** 结束刷新状态 */
- (void)endRefreshing;

@property (nonatomic, assign) UIEdgeInsets scrollViewOriginalInsets;
@property (nonatomic, assign) SDWXRefreshViewState refreshState;

@property(nonatomic,assign) BOOL dragging;

@end
