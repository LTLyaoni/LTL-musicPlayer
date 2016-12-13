//
//  LTLBaseRefreshView.m
//  GSD_WeiXin(wechat)
//
//  Created by gsd on 16/3/5.
//  Copyright © 2016年 GSD. All rights reserved.
//



#import "LTLBaseRefreshView.h"

NSString *const kSDBaseRefreshViewObserveKeyPath = @"contentOffset";



@interface LTLBaseRefreshView ()<UIScrollViewDelegate>

@end

@implementation LTLBaseRefreshView

- (void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    _scrollViewOriginalInset = _scrollView.contentInset;
    
    [scrollView addObserver:self forKeyPath:kSDBaseRefreshViewObserveKeyPath options:NSKeyValueObservingOptionNew context:nil];
   
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self.scrollView removeObserver:self forKeyPath:kSDBaseRefreshViewObserveKeyPath];
      
    }
}

- (void)endRefreshing
{
    [self performSelector:@selector(end) withObject:nil afterDelay:1.2f];
    
}

-(void)end
{
    self.refreshState = SDWXRefreshViewStateNormal;
}

-(void)beginRefreshing
{

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    // 子类实现
}

//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    self.dragging = YES;
//}

@end
