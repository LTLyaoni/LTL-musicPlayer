//
//  LTLResult.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/30.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLResult.h"
#import "PYSearch.h"
#import "LTLuserInfo.h"
#import "LTLSongViewController.h"
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

@property(nonatomic,assign) NSUInteger page;

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
        
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            self.page = 0;
            [_tableView.mj_footer resetNoMoreData];
            [self dataAcquisitionDadt:nil];
        }];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self dataAcquisitionDadt:nil];
        }];
        
        
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
        
        self.page = 0;
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
            
            cell.trackData = self.track[indexPath.row];
            
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (self.indexPath)
    {
        if (self.indexPath.section) {
            
            NSRange range = NSMakeRange(indexPath.row, self.track.count - indexPath.row);
            NSArray *arrayL = [self.track subarrayWithRange:range];
            
            [self playNotification:[arrayL copy] serialNumber:0];
            
        }
        else
        {
            
             XMAlbum *model = self.album[indexPath.row];
            LTLSongViewController *song = [[LTLSongViewController alloc]init];
            song.XMAlbumModel = model;
        
            [[self viewController].navigationController pushViewController:song animated:YES];
            
        }
        
    }


}
-(void)playNotification:(NSMutableArray *)arrya serialNumber:(NSUInteger)serialNumber
{
    if (arrya.count != 0 ) {
        
        /// 当前播放信息
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        LTLuserInfo *userInfo = [[LTLuserInfo alloc]init];
        userInfo.serialNumber = serialNumber;
        userInfo.songArray = [arrya copy];
        dic[@"Play"] = userInfo;
        ///发送播放通知
        [[NSNotificationCenter defaultCenter] postNotificationName:LTLPlay object:nil userInfo:[dic copy]];
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
    [self dataAcquisitionDadt:^{
        self.tableView.hidden = YES;
        self.label.text = @"不好意思!乐库里没有您想要的!";
    }];
    
}

///获取数据
-(void)dataAcquisitionDadt:( nullable void (^)())LTL
{
    self.page++;
    LTLLog(@"%ld",self.page);
    [LTLNetworkRequest searchtype:self.indexPath.section keyWord:self.searchText page:self.page dimension:self.indexPath.row +2 dadt:^(NSArray<XMAlbum *> * _Nullable albumArray, NSArray<XMTrack *> * _Nullable trackArray, XMErrorModel * _Nullable error)
     {
         if (!error) {
             
             if (self.page == 1) {
                 [self.album removeAllObjects];
                 [self.track removeAllObjects];
             }
             [self.album addObjectsFromArray:albumArray];
             
             [self.track addObjectsFromArray:trackArray];
             
             [self.indicatorView stopAnimating];
             self.indicatorView.hidden = YES;
             
             
             if (albumArray.count ==0 && trackArray.count == 0 ) {
                 
                 if (LTL) {
                     LTL();
                 }
                 self.page--;
                 [self.tableView.mj_footer endRefreshingWithNoMoreData];
             } else {
                 self.label.hidden = YES;
                 self.tableView.hidden = NO;
                 [self.tableView reloadData];
                 [self.tableView.mj_footer endRefreshing];
                 [self.tableView.mj_header endRefreshing];
                 
             }
             
         }
         
     }];
}

-(void)removeData
{
    self.page = 0;
    self.searchText = nil;
    self.indexPath = nil;
    [self.album removeAllObjects];
    [self.track removeAllObjects];
    self.tableView.hidden = YES;
    [self.tableView reloadData];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [[NSNotificationCenter defaultCenter] postNotificationName:LTLExitKeyboard object:nil];
}

@end
