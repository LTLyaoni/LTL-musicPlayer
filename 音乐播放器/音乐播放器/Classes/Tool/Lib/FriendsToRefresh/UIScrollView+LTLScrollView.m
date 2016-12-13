//
//  UIScrollView+LTLScrollView.m
//  代码修改
//
//  Created by LiTaiLiang on 16/12/6.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "UIScrollView+LTLScrollView.h"

@implementation UIScrollView (LTLScrollView)
#pragma mark - header
static const char LTLrefreshHeaderKey = '\0';
- (void)setLTLrefreshHeader:(LTLTimeLineRefreshHeader *)LTLrefreshHeader
{
    if (LTLrefreshHeader != self.LTLrefreshHeader) {
        // 删除旧的，添加新的
        [self.LTLrefreshHeader removeFromSuperview];
//        [self insertSubview:LTLrefreshHeader atIndex:0];
        
        if (!LTLrefreshHeader.superview)
        {
//            _refreshHeader = [LTLTimeLineRefreshHeader refreshHeaderWithCenter:CGPointMake(40, 0) size:CGSizeMake(66, 66)];
//            
//            _refreshHeader.backgroundColor = [UIColor redColor];
            LTLrefreshHeader.scrollView = self;

            [self.superview addSubview:LTLrefreshHeader];
            //        [self.view addSubview:_refreshHeader];
        } else {
            [self.superview bringSubviewToFront:LTLrefreshHeader];
        }
        
        
        if ([self viewController].automaticallyAdjustsScrollViewInsets ) {
            
            LTLrefreshHeader.scrollViewOriginalInset = UIEdgeInsetsMake(LTLrefreshHeader.scrollViewOriginalInset.top +20, 0, 0, 0);
        }

        // 存储新的
        [self willChangeValueForKey:@"LTLrefreshHeader"]; // KVO
        objc_setAssociatedObject(self, &LTLrefreshHeaderKey,
                                 LTLrefreshHeader, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"LTLrefreshHeader"]; // KVO
    }

}

- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}


-(LTLTimeLineRefreshHeader *)LTLrefreshHeader
{
    return objc_getAssociatedObject(self, &LTLrefreshHeaderKey);
}
@end
