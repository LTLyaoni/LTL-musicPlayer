//
//  UITableView+LTLTableView.m
//  JXMovableCellTableView
//
//  Created by LiTaiLiang on 16/12/8.
//  Copyright © 2016年 jiaxin. All rights reserved.
//

#import "UITableView+LTLTableView.h"
#import <objc/runtime.h>

static NSTimeInterval LTLMovableCellAnimationTime = 0.25;

@interface UITableView ()
@property (nonatomic, strong) UILongPressGestureRecognizer *gesture;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) NSIndexPath *startIndexPath;
@property (nonatomic, strong) UIView *tempView;
@property (nonatomic, strong) NSMutableArray *tempDataSource;
@property (nonatomic, strong) CADisplayLink *edgeScrollTimer;
@end



@implementation UITableView (LTLTableView)
#pragma mark - 不暴露的 变量
#pragma mark - gesture
static const char gestureKey = '\0';
- (void)setGesture:(UILongPressGestureRecognizer *)gesture
{
    if (gesture != self.gesture) {
        
        objc_setAssociatedObject(self, &gestureKey,
                                 gesture, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
}

-(UILongPressGestureRecognizer *)gesture
{
    return objc_getAssociatedObject(self, &gestureKey);
}
#pragma mark - selectedIndexPath
static const char selectedIndexPathKey = '\0';
- (void)setSelectedIndexPath:(NSIndexPath *)selectedIndexPath
{
    if (selectedIndexPath != self.selectedIndexPath) {
        
        objc_setAssociatedObject(self, &selectedIndexPathKey,
                                 selectedIndexPath, OBJC_ASSOCIATION_ASSIGN);
        
    }
}

-(NSIndexPath *)selectedIndexPath
{
    return objc_getAssociatedObject(self, &selectedIndexPathKey);
}
#pragma mark - selectedIndexPath
static const char startIndexPathKey = '\0';
- (void)setStartIndexPath:(NSIndexPath *)startIndexPath
{
    if (startIndexPath != self.startIndexPath) {
        
        objc_setAssociatedObject(self, &startIndexPathKey,
                                 startIndexPath, OBJC_ASSOCIATION_ASSIGN);
        
    }
}

-(NSIndexPath *)startIndexPath
{
    return objc_getAssociatedObject(self, &startIndexPathKey);
}
#pragma mark - tempView
static const char tempViewKey = '\0';
- (void)setTempView:(UIView *)tempView
{
    if (tempView != self.tempView) {
        
        objc_setAssociatedObject(self, &tempViewKey,
                                 tempView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
}

-(UIView *)tempView
{
    return objc_getAssociatedObject(self, &tempViewKey);
}
#pragma mark - tempDataSource
static const char tempDataSourceKey = '\0';
- (void)setTempDataSource:(NSMutableArray *)tempDataSource
{
    if (tempDataSource != self.tempDataSource) {
        
        objc_setAssociatedObject(self, &tempDataSourceKey,
                                 tempDataSource, OBJC_ASSOCIATION_RETAIN);
        
    }
}

-(NSMutableArray *)tempDataSource
{
    return objc_getAssociatedObject(self, &tempDataSourceKey);
}
#pragma mark - tempDataSource
static const char edgeScrollTimerKey = '\0';
- (void)setEdgeScrollTimer:(CADisplayLink *)edgeScrollTimer
{
    if (edgeScrollTimer != self.edgeScrollTimer) {
        
        objc_setAssociatedObject(self, &edgeScrollTimerKey,
                                 edgeScrollTimer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
}

-(CADisplayLink *)edgeScrollTimer
{
    return objc_getAssociatedObject(self, &edgeScrollTimerKey);
}
#pragma mark - 暴露的 API
#pragma mark - LTLdelegate
static const char LTLdelegateKey = '\0';
- (void)setLTLdelegate:(id<LTLMovableCellTableViewDelegate>)LTLdelegate
{
    if (LTLdelegate != self.LTLdelegate) {
      
        objc_setAssociatedObject(self, &LTLdelegateKey,
                                 LTLdelegate, OBJC_ASSOCIATION_ASSIGN);

    }
}

-(id<LTLMovableCellTableViewDelegate>)LTLdelegate
{
    return objc_getAssociatedObject(self, &LTLdelegateKey);
}
#pragma mark - LTLdelegate
static const char LTLdataSourceKey = '\0';
- (void)setLTLdataSource:(id<LTLMovableCellTableViewDataSource>)LTLdataSource
{
    if(LTLdataSource != self.LTLdataSource) {
        
        objc_setAssociatedObject(self, &LTLdataSourceKey,
                                 LTLdataSource, OBJC_ASSOCIATION_ASSIGN);
        
    }
}

-(id<LTLMovableCellTableViewDataSource>)LTLdataSource
{
    return objc_getAssociatedObject(self, &LTLdataSourceKey);
}
#pragma mark - gestureMinimumPressDuration
-(CGFloat)gestureMinimumPressDuration
{
    return [objc_getAssociatedObject(self, @selector(gestureMinimumPressDuration)) floatValue];
    
}
-(void)setGestureMinimumPressDuration:(CGFloat)gestureMinimumPressDuration
{
    if (gestureMinimumPressDuration != self.gestureMinimumPressDuration) {
        NSNumber *gestureMinimumPressDurationNumber = @(gestureMinimumPressDuration);
        objc_setAssociatedObject(self, @selector(gestureMinimumPressDuration), gestureMinimumPressDurationNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
#pragma mark - canEdgeScroll
-(BOOL)canEdgeScroll
{
    return [objc_getAssociatedObject(self, @selector(canEdgeScroll)) boolValue];
}
-(void)setCanEdgeScroll:(BOOL)canEdgeScroll
{
    if (canEdgeScroll != self.canEdgeScroll) {
        NSNumber *canEdgeScrollNumber = @(canEdgeScroll);
        objc_setAssociatedObject(self, @selector(canEdgeScroll), canEdgeScrollNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
#pragma mark - edgeScrollRange
-(CGFloat)edgeScrollRange
{
    return [objc_getAssociatedObject(self, @selector(edgeScrollRange)) floatValue];
    
}
-(void)setEdgeScrollRange:(CGFloat)edgeScrollRange
{
    if (edgeScrollRange != self.edgeScrollRange) {
        NSNumber *edgeScrollRangeNumber = @(edgeScrollRange);
        objc_setAssociatedObject(self, @selector(edgeScrollRange), edgeScrollRangeNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}
#pragma mark - drag
-(BOOL)drag
{
    return [objc_getAssociatedObject(self, @selector(drag)) boolValue];
}
-(void)setDrag:(BOOL)drag
{
    if (drag != self.drag) {
        NSNumber *dragNumber = @(drag);
        objc_setAssociatedObject(self, @selector(drag), dragNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    if (drag) {
        
        self.tempDataSource = [NSMutableArray array];
        
        [self LTLinitData];
     
        [self LTLaddGesture];
    }
}
#pragma mark - 逻辑处理
- (void)LTLinitData
{
    self.gestureMinimumPressDuration = 1.f;
    self.canEdgeScroll = YES;
    self.edgeScrollRange = 150.f;
}
- (void)LTLaddGesture
{
    self.gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(LTL_processGesture:)];
   
    self.gesture.minimumPressDuration = self.gestureMinimumPressDuration;
    [self addGestureRecognizer:self.gesture];
}
- (void)LTL_processGesture:(UILongPressGestureRecognizer *)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            [self jx_gestureBegan:gesture];
//            NSLog(@"打印");
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
//            if (!_canEdgeScroll) {
                [self jx_gestureChanged:gesture];
//            }
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        {
            [self jx_gestureEndedOrCancelled:gesture];
        }
            break;
        default:
            break;
    }
}

#pragma mark - 处理

- (void)jx_gestureBegan:(UILongPressGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:gesture.view];
    NSIndexPath *selectedIndexPath = [self indexPathForRowAtPoint:point];
   
    self.startIndexPath = selectedIndexPath;
    
    if (!selectedIndexPath) {
        return;
    }
    if (self.LTLdelegate && [self.LTLdelegate respondsToSelector:@selector(tableView:willMoveCellAtIndexPath:)]) {
        [self.LTLdelegate tableView:self willMoveCellAtIndexPath:selectedIndexPath];
    }
    if (self.canEdgeScroll) {
        //开启边缘滚动
        [self jx_startEdgeScroll];
    }
    //每次移动开始获取一次数据源
    if (self.LTLdataSource && [self.LTLdataSource respondsToSelector:@selector(dataSourceArrayInTableView:)]) {
        self.tempDataSource = [self.LTLdataSource dataSourceArrayInTableView:self].mutableCopy;
    }
    self.selectedIndexPath = selectedIndexPath;
    UITableViewCell *cell = [self cellForRowAtIndexPath:selectedIndexPath];
    self.tempView = [self jx_snapshotViewWithInputView:cell];
//    if (self.drawMovalbeCellBlock) {
//        //将_tempView通过block让使用者自定义
//        self.drawMovalbeCellBlock(_tempView);
//    }else
//    {
        //配置默认样式
        self.tempView.layer.shadowColor = [UIColor grayColor].CGColor;
        self.tempView.layer.masksToBounds = NO;
        self.tempView.layer.cornerRadius = 0;
        self.tempView.layer.shadowOffset = CGSizeMake(-5, 0);
        self.tempView.layer.shadowOpacity = 0.4;
        self.tempView.layer.shadowRadius = 5;
//    }
    self.tempView.frame = cell.frame;
    [self addSubview:self.tempView];
    //隐藏cell
    cell.hidden = YES;
    [UIView animateWithDuration:LTLMovableCellAnimationTime animations:^{
        self.tempView.center = CGPointMake(self.tempView.center.x, point.y);
    }];
}

- (void)jx_gestureChanged:(UILongPressGestureRecognizer *)gesture
{
    CGPoint point = [gesture locationInView:gesture.view];
    NSIndexPath *currentIndexPath = [self indexPathForRowAtPoint:point];
    if (currentIndexPath && ![self.selectedIndexPath isEqual:currentIndexPath]) {
        //交换数据源和cell
        [self jx_updateDataSourceAndCellFromIndexPath:self.selectedIndexPath toIndexPath:currentIndexPath];
        if (self.LTLdelegate && [self.LTLdelegate respondsToSelector:@selector(tableView:didMoveCellFromIndexPath:toIndexPath:)]) {
            [self.LTLdelegate tableView:self didMoveCellFromIndexPath:self.selectedIndexPath toIndexPath:currentIndexPath];
        }
        self.selectedIndexPath = currentIndexPath;
    }
    //让截图跟随手势
    self.tempView.center = CGPointMake(self.tempView.center.x, point.y);
}

- (void)jx_gestureEndedOrCancelled:(UILongPressGestureRecognizer *)gesture
{
    if (self.canEdgeScroll) {
        [self jx_stopEdgeScroll];
    }
    //返回交换后的数据源
    if (self.LTLdataSource && [self.LTLdataSource respondsToSelector:@selector(tableView:newDataSourceArrayAfterMove:)]) {
        [self.LTLdataSource tableView:self newDataSourceArrayAfterMove:self.tempDataSource.copy];
    }
    if (self.LTLdelegate && [self.LTLdelegate respondsToSelector:@selector(tableView:endMoveCellAtIndexPath:)]) {
        [self.LTLdelegate tableView:self endMoveCellAtIndexPath:self.selectedIndexPath];
    }
    
    if (self.LTLdelegate && [self.LTLdelegate respondsToSelector:@selector(tableView:endMoveCellFromIndexPath:toIndexPath:)]) {
        [self.LTLdelegate tableView:self endMoveCellFromIndexPath:self.startIndexPath toIndexPath:self.selectedIndexPath];
    }
    
    UITableViewCell *cell = [self cellForRowAtIndexPath:self.selectedIndexPath];
    [UIView animateWithDuration:LTLMovableCellAnimationTime animations:^{
        self.tempView.frame = cell.frame;
    } completion:^(BOOL finished) {
        cell.hidden = NO;
        [self.tempView removeFromSuperview];
        self.tempView = nil;
    }];
}

#pragma mark Private action

- (UIView *)jx_snapshotViewWithInputView:(UIView *)inputView
{
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    return snapshot;
}

- (void)jx_updateDataSourceAndCellFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    if ([self numberOfSections] == 1) {
        //只有一组
        
//        LTLLog(@"%@ to  %@ ",fromIndexPath ,toIndexPath);
        
        [self.tempDataSource exchangeObjectAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
        //交换cell
        [self moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
    }else {
        //有多组
        id fromData = self.tempDataSource[fromIndexPath.section][fromIndexPath.row];
        id toData = self.tempDataSource[toIndexPath.section][toIndexPath.row];
        NSMutableArray *fromArray = [self.tempDataSource[fromIndexPath.section] mutableCopy];
        NSMutableArray *toArray = [self.tempDataSource[toIndexPath.section] mutableCopy];
        [fromArray replaceObjectAtIndex:fromIndexPath.row withObject:toData];
        [toArray replaceObjectAtIndex:toIndexPath.row withObject:fromData];
        [self.tempDataSource replaceObjectAtIndex:fromIndexPath.section withObject:fromArray];
        [self.tempDataSource replaceObjectAtIndex:toIndexPath.section withObject:toArray];
        //交换cell
        [self beginUpdates];
        [self moveRowAtIndexPath:fromIndexPath toIndexPath:toIndexPath];
        [self moveRowAtIndexPath:toIndexPath toIndexPath:fromIndexPath];
        [self endUpdates];
    }
}

#pragma mark EdgeScroll

- (void)jx_startEdgeScroll
{
    self.edgeScrollTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(jx_processEdgeScroll)];
    [self.edgeScrollTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)jx_processEdgeScroll
{
    [self jx_gestureChanged:self.gesture];
    CGFloat minOffsetY = self.contentOffset.y + self.edgeScrollRange;
    CGFloat maxOffsetY = self.contentOffset.y + self.bounds.size.height - self.edgeScrollRange;
    CGPoint touchPoint = self.self.tempView.center;
    //处理上下达到极限之后不再滚动tableView，其中处理了滚动到最边缘的时候，当前处于edgeScrollRange内，但是tableView还未显示完，需要显示完tableView才停止滚动
    if (touchPoint.y < self.edgeScrollRange) {
        if (self.contentOffset.y <= 0) {
            return;
        }else {
            if (self.contentOffset.y - 1 < 0) {
                return;
            }
            [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y - 1) animated:NO];
            self.tempView.center = CGPointMake(self.tempView.center.x, self.tempView.center.y - 1);
        }
    }
    if (touchPoint.y > self.contentSize.height - self.edgeScrollRange) {
        if (self.contentOffset.y >= self.contentSize.height - self.bounds.size.height) {
            return;
        }else {
            if (self.contentOffset.y + 1 > self.contentSize.height - self.bounds.size.height) {
                return;
            }
            [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y + 1) animated:NO];
            self.tempView.center = CGPointMake(self.tempView.center.x, self.tempView.center.y + 1);
        }
    }
    //处理滚动
    CGFloat maxMoveDistance = 20;
    if (touchPoint.y < minOffsetY) {
        //cell在往上移动
        CGFloat moveDistance = (minOffsetY - touchPoint.y)/self.edgeScrollRange*maxMoveDistance;
        [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y - moveDistance) animated:NO];
        self.tempView.center = CGPointMake(self.tempView.center.x, self.tempView.center.y - moveDistance);
    }else if (touchPoint.y > maxOffsetY) {
        //cell在往下移动
        CGFloat moveDistance = (touchPoint.y - maxOffsetY)/self.edgeScrollRange*maxMoveDistance;
        [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y + moveDistance) animated:NO];
        self.tempView.center = CGPointMake(self.tempView.center.x, self.tempView.center.y + moveDistance);
    }
}

- (void)jx_stopEdgeScroll
{
    if (self.edgeScrollTimer) {
        [self.edgeScrollTimer invalidate];
        self.edgeScrollTimer = nil;
    }
}

@end
