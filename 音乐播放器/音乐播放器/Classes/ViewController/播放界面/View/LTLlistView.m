//
//  LTLlistView.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/12/7.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLlistView.h"
#import "LTLlistCell.h"

@interface LTLlistView ()<UITableViewDelegate,UITableViewDataSource,LTLPlayManagerDelegate,LTLMovableCellTableViewDataSource,LTLMovableCellTableViewDelegate>
@property(nonatomic,strong) NSMutableArray* list;
@property(nonatomic,strong) LTLPlayManager *play;

@property(nonatomic,assign) NSUInteger integer;
@end


static NSString *ID = @"listViewID";

@implementation LTLlistView

#pragma mark - 懒加载
-(NSMutableArray *)list
{
    if (!_list) {
        _list = [NSMutableArray array];
        
        [_list addObjectsFromArray:[self.play.playlist copy]];
        
    }
    return _list;
}
-(LTLPlayManager *)play
{
    if (!_play) {
        _play = [LTLPlayManager sharedInstance];

    }
    return _play;
}
#pragma mark - 初始化
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        
        self.delegate = self;
        self.dataSource = self;
        self.LTLdataSource = self;
        self.LTLdelegate = self;
        self.rowHeight = 48;
        self.drag = YES;
        [self registerNib:[UINib nibWithNibName:@"LTLlistCell" bundle:nil] forCellReuseIdentifier:ID];
        
        [self setEditing:NO animated:YES];
        
        
        self.backgroundColor = [[UIColor lightGrayColor] modifyAlpha:0.12];
        
    }
    return self;
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTLlistCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    if (self.play.indexPathRow == indexPath.row)
    {
        self.integer = self.play.indexPathRow;
        if (self.play.isPlay) {
            
            cell.state = NAKPlaybackIndicatorViewStatePlaying;
            
        }
        else
        {
            cell.state = NAKPlaybackIndicatorViewStatePaused;
            
        };
    }
    else
    {
       cell.state = NAKPlaybackIndicatorViewStateStopped; 
    }
    cell.tag = indexPath.row;
    
    XMTrack *dadt = self.list[indexPath.row];
    
    cell.data = dadt;
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.list removeObjectAtIndex:indexPath.row];
        [self.play removeSong:indexPath.row];
        [tableView reloadData];
    }
}
////默认编辑模式下，每个cell左边有个红色的删除按钮，设置为None即可去掉
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleNone;
//}
// 设置cell为可移动模式 与 tableview：moveXXXXX方法共同使用
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
#pragma mark - LTLMovableCellTableViewDataSource
/**
 每次开始移动都要获取一次数据源,不然数据会错乱
 *  获取tableView的数据源数组
 */
- (NSArray *)dataSourceArrayInTableView:(UITableView *)tableView
{
    return self.list.copy;
}
/**
 *  返回移动之后调换后的数据源
 */
- (void)tableView:(UITableView *)tableView newDataSourceArrayAfterMove:(NSArray *)newDataSourceArray
{
    self.list = newDataSourceArray.copy;
}

#pragma mark - LTLMovableCellTableViewDelegate

-(void)tableView:(UITableView *)tableView endMoveCellFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    [self.play songExchangeAtIndex:fromIndexPath.row withObjectAtIndex:toIndexPath.row];
    [self reloadData];
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:self.play.indexPathRow inSection:0];
    LTLlistCell *palycCell = [tableView cellForRowAtIndexPath:cellIndexPath];
    
    if (self.play.indexPathRow == indexPath.row) {
        
        [self.play pauseMusic];
        
        if (self.play.isPlay) {
            
            palycCell.state = NAKPlaybackIndicatorViewStatePlaying;
            
        }
        else
        {
            palycCell.state = NAKPlaybackIndicatorViewStatePaused;
        
        };
        
    } else {
        
//        palycCell.state = NAKPlaybackIndicatorViewStateStopped;
        [self.play setNumberOfPlay:indexPath.row];
//        LTLlistCell *cell =[tableView cellForRowAtIndexPath:indexPath];
//        self.integer = self.play.indexPathRow;
//        cell.state = NAKPlaybackIndicatorViewStatePlaying;
    
    }
}

-(void)playChange
{
    
    NSIndexPath *cellIndexPath = [NSIndexPath indexPathForRow:self.integer inSection:0];
    LTLlistCell *palycCell = [self cellForRowAtIndexPath:cellIndexPath];
    
    if (self.integer == self.play.indexPathRow ) {
        
        if (self.play.isPlay) {
            
            palycCell.state = NAKPlaybackIndicatorViewStatePlaying;
            
        }
        else
        {
            palycCell.state = NAKPlaybackIndicatorViewStatePaused;
            
        };
    }
    else
    {
        palycCell.state = NAKPlaybackIndicatorViewStateStopped;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.play.indexPathRow inSection:0];
        LTLlistCell *Cell = [self cellForRowAtIndexPath:indexPath];
        Cell.state = NAKPlaybackIndicatorViewStatePlaying;
        
        self.integer = self.play.indexPathRow;
        
    }
}

@end
