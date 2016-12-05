//
//  LTLResult.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/30.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLResult.h"
#import "PYSearch.h"
#import "KPIndicatorView.h"
///专辑cell
#import "LTLMoreSongsCell.h"
///声音数组
#import "LTLMusicDetailCell.h"

@interface LTLResult ()<UITableViewDelegate,UITableViewDataSource>
///刷新指示
@property(nonatomic,strong) KPIndicatorView *indicatorView;
//结果显示
@property(nonatomic,strong) UITableView *tableView;
///专辑数组
@property (nonatomic,strong) NSMutableArray <XMAlbum *> *album;
///声音数组
@property (nonatomic,strong) NSMutableArray <XMTrack *> *track;
//提示
@property(nonatomic,strong) UILabel *label;

@end

static NSString *albumID = @"albumCell";
static NSString *trackID = @"TrackCell";
@implementation LTLResult
#pragma mark - 懒加载
-(UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 250, 36)];
        _label .text = @"正在为您搜索...";
        _label.centerX = self.indicatorView.centerX;
        _label.centerY = self.indicatorView.centerY + (self.indicatorView.highly + _label.highly)/2;
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
    }
    return _label;
}
-(NSMutableArray<XMAlbum *> *)album
{
    if (!_album) {
        _album = [NSMutableArray array];
    }
    return _album;
}
-(NSMutableArray<XMTrack *> *)track
{
    if (!_track) {
        _track = [NSMutableArray array];
    }
    return _track;
}

-(UITableView *)tableView
{
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.backgroundColor = [UIColor yellowColor];
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 88, 0);
        
        _tableView.hidden = YES;
        
        [_tableView registerNib:[UINib nibWithNibName:@"LTLMoreSongsCell" bundle:nil] forCellReuseIdentifier:albumID];
        
        [_tableView registerClass:[LTLMusicDetailCell class] forCellReuseIdentifier:trackID];
        
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 66;
        
        [self.contentView addSubview:_tableView];
    }
    return _tableView;
}

//数据指示
-(KPIndicatorView *)indicatorView
{
    if (!_indicatorView)
    {
        _indicatorView = [[KPIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 66, 66)];
        _indicatorView.colorOfMoveView = [LTLThemeManager sharedManager].themeColor;
        _indicatorView.center = CGPointMake(self.tableView.center.x, self.tableView.center.y-88);
        
        [self.contentView insertSubview:_indicatorView atIndex:0];
    }
    return _indicatorView;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        
        self.tag = 0;
    }
    return self;
}
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.indexPath) {
        
        return self.indexPath.section ? self.track.count : self.album.count;
    }
    else
    {
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.indexPath)
    {
        if (self.indexPath.section) {
            
            LTLMusicDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:trackID forIndexPath:indexPath];
            
            cell.TrackData = self.track[indexPath.row];
            
            return cell;
            
        }
        else
        {
            LTLMoreSongsCell *cell = [tableView dequeueReusableCellWithIdentifier:albumID forIndexPath:indexPath];
            
            cell.album = self.album[indexPath.row];
            
            return cell;
            
        }

    } else {
        return nil;
    }
}

#pragma mark - 处理
///处理
-(void)setSearchText:(NSString *)searchText
{
    _searchText = searchText;
    
    if (self.tag) {
        self.tag = 0;
        ///请求数据
        [self setDadt];
    }
    else
    {
        self.tag = 1;
    }
    
}
-(void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
    if (self.tag) {
        self.tag = 0;
        ///请求数据
        [self setDadt];
    }
    else
    {
        self.tag = 1;
    }
}
#pragma mark - 处理搜索数据
//搜索
-(void)setDadt
{
    if (self.searchText.length == 0 || self.indexPath == nil) {
        return;
    }
    
    [self.indicatorView startAnimating];
    self.indicatorView.hidden = NO;
    self.label.text =  @"正在为您搜索...";
    
    [LTLNetworkRequest searchtype:self.indexPath.section keyWord:self.searchText page:1 dimension:self.indexPath.row +2 dadt:^(NSArray<XMAlbum *> * _Nullable albumArray, NSArray<XMTrack *> * _Nullable trackArray, XMErrorModel * _Nullable error) {
        
        [self.album addObjectsFromArray:albumArray];
        
        [self.track addObjectsFromArray:trackArray];
        
        [self.indicatorView stopAnimating];
        self.indicatorView.hidden = YES;
        
//        LTLLog(@"track %ld", trackArray.count);
        
        if (self.album.count ==0 && self.track.count == 0 ) {
           
            self.tableView.hidden = YES;
            self.label.text = @"不好意思!乐库里没有您想要的!";
            
        } else {
            self.label.hidden = YES;
            self.tableView.hidden = NO;
            [self.tableView reloadData];
            
        }
        
    }];
}
-(void)removeData
{
    self.searchText = nil;
    self.indexPath = nil;
    [self.album removeAllObjects];
    self.tableView.hidden = YES;
    [self.tableView reloadData];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LTLExitKeyboard object:nil];
}

@end
