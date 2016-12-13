//
//  LTLBaseRefreshView.m
//  GSD_WeiXin(wechat)
//
//  Created by gsd on 16/3/5.
//  Copyright © 2016年 GSD. All rights reserved.
//


#import "LTLTimeLineRefreshHeader.h"
#import "LTLAlbumReflashIcon.h"

//static const CGFloat criticalY = -(LTL_WindowW);

#define kSDTimeLineRefreshHeaderRotateAnimationKey @"RotateAnimationKey"

@interface LTLTimeLineRefreshHeader ()

@property(nonatomic,assign) BOOL animations;
@property(nonatomic,assign) CGFloat criticalY;
@end



@implementation LTLTimeLineRefreshHeader

{
    CABasicAnimation *_rotateAnimation;
    CGRect _selfRect;
}
-(CGFloat)criticalY
{
    if (!_criticalY) {
        _criticalY = -(LTL_WindowW/5.8);
    }
    return _criticalY;
}
+ (nonnull instancetype)refreshHeaderWithCenter:( CGPoint)center iamge:( nullable UIImageView *)iamge refreshing:(nullable void (^)())LTL
{
    LTLTimeLineRefreshHeader *header = [[LTLTimeLineRefreshHeader alloc]init];
    header.refreshingBlock = LTL;
    header.center = center;
    return header;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
        self.animations = NO;
        self.dragging = YES;
    }
    return self;
}

- (void)setupView
{
    self.backgroundColor = [UIColor clearColor];
    
    UIImage *image = [LTLAlbumReflashIcon imageOfArtboardWithSize:CGSizeMake(25, 25) resizing:LTLAlbumReflashIconResizingBehaviorAspectFill];
    
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"AlbumReflashIcon"]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView sizeToFit];
    
    imageView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) ;
    
    [self addSubview:imageView];
    
    self.imageView = imageView;
    
    
    _rotateAnimation = [[CABasicAnimation alloc] init];
    _rotateAnimation.keyPath = @"transform.rotation.z";
    _rotateAnimation.fromValue = @0;
    _rotateAnimation.toValue = @(M_PI * 2);
    _rotateAnimation.duration = 1.8;
    _rotateAnimation.repeatCount = MAXFLOAT;
}

-(void)setImageView:(UIImageView *)imageView
{
    _imageView = imageView;
    
    self.bounds = _imageView.bounds;
    
    imageView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) ;
}

//-(void)setScrollView:(UIScrollView *)scrollView
//{
//    [super setScrollView:scrollView];
//
////    CGRect rect = self.frame;
////    rect = CGRectOffset(rect, 0, -_scrollViewOriginalInset.top);
////    _selfRect = rect;
////    self.frame = rect;
//}

- (void)setRefreshState:(SDWXRefreshViewState)refreshState
{
    
    [super setRefreshState:refreshState];
    
    if (refreshState == SDWXRefreshViewStateRefreshing)
    {
        if (self.refreshingBlock) {
            self.refreshingBlock();
        }
        [self.layer addAnimation:_rotateAnimation forKey:kSDTimeLineRefreshHeaderRotateAnimationKey];
        
    } else if (refreshState == SDWXRefreshViewStateNormal)
    {
        
        self.animations = YES;
        
        [self.layer removeAnimationForKey:kSDTimeLineRefreshHeaderRotateAnimationKey];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.transform = CGAffineTransformIdentity;
            self.alpha = 0;
        } completion:^(BOOL finished) {
            self.animations = NO;
        }];

    }
}

-(void)beginRefreshing
{
    [super beginRefreshing];
    //    [self updateRefreshHeaderWithOffsetY:criticalY];
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -self.criticalY);
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
        self.transform = transform;
    } completion:^(BOOL finished) {
        self.refreshState = SDWXRefreshViewStateRefreshing;
    }];
    
}

- (void)updateRefreshHeaderWithOffsetY:(CGFloat)y
{
    
    CGFloat offisetY = y + self.scrollViewOriginalInset.top;
    
    CGFloat alpha = offisetY/77;

    if (!self.scrollView.isDragging && offisetY == 0) {
        
        self.dragging = YES;
        
    }
    
    CGFloat rotateValue = offisetY / 66.0 * M_PI;
    
    if (offisetY <= self.criticalY) {
        offisetY = self.criticalY;
        
        if (self.scrollView.isDragging && self.refreshState == SDWXRefreshViewStateNormal)
        {
            self.refreshState = SDWXRefreshViewStateWillRefresh;
        }
        else if (!self.scrollView.isDragging && self.refreshState == SDWXRefreshViewStateWillRefresh)       {
            self.refreshState = SDWXRefreshViewStateRefreshing;
        }
        if (!self.dragging )
        {
            return;
        }
        
    }
    
    if (self.refreshState == SDWXRefreshViewStateRefreshing || self.animations)
    {
        
        self.dragging = NO;
        return;
    }
    
    self.alpha = -alpha;
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, -offisetY);
    //    transform = CGAffineTransformTranslate(transform, 0, -y);
    CGAffineTransform  transformRotate = CGAffineTransformRotate(transform, rotateValue);
    self.transform = transformRotate;
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{

    
    if (keyPath == kSDBaseRefreshViewObserveKeyPath)
    {
       
        [self updateRefreshHeaderWithOffsetY:self.scrollView.contentOffset.y];
        
    }
}

@end
