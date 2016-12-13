//
//  UITableView+LTLTableView.h
//  JXMovableCellTableView
//
//  Created by LiTaiLiang on 16/12/8.
//  Copyright © 2016年 jiaxin. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LTLMovableCellTableViewDataSource <NSObject>

@required
/**
 每次开始移动都要获取一次数据源,不然数据会错乱
 *  获取tableView的数据源数组
 */
- (NSArray *)dataSourceArrayInTableView:(UITableView *)tableView;
/**
 *  返回移动之后调换后的数据源
 */
- (void)tableView:(UITableView *)tableView newDataSourceArrayAfterMove:(NSArray *)newDataSourceArray;

@end

@protocol LTLMovableCellTableViewDelegate <NSObject>
@optional
/**
 *  将要开始移动indexPath位置的cell
 */
- (void)tableView:(UITableView *)tableView willMoveCellAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  完成一次从fromIndexPath cell到toIndexPath cell的移动
 */
- (void)tableView:(UITableView *)tableView didMoveCellFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;
/**
 *  结束移动cell在indexPath
 */
- (void)tableView:(UITableView *)tableView endMoveCellAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  结束移动cell cell 到toIndexPath
 */
- (void)tableView:(UITableView *)tableView endMoveCellFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;


@end

@interface UITableView (LTLTableView)

@property (nonatomic, weak) id<LTLMovableCellTableViewDataSource> LTLdataSource;
@property (nonatomic, weak) id<LTLMovableCellTableViewDelegate> LTLdelegate;
/**
 *  长按手势最小触发时间，默认1.0，最小0.2
 */
@property (nonatomic, assign) CGFloat gestureMinimumPressDuration;
/**
 *  是否允许拖动到屏幕边缘后，开启边缘滚动，默认YES
 */
@property (nonatomic, assign) BOOL canEdgeScroll;
/**
 *  边缘滚动触发范围，默认150，越靠近边缘速度越快
 */
@property (nonatomic, assign) CGFloat edgeScrollRange;
/**
 *  是否允许拖动，默认NO
 */
@property (nonatomic, assign) BOOL drag;

@end
