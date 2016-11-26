//
//  LTLMoreSongs.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/23.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLMoreSongs.h"
#import "LTLMoreSongsCell.h"
#import "LTLSongViewController.h"

@interface LTLMoreSongs ()

//数据数组
@property(nonatomic,strong)NSMutableArray <XMAlbum *>*dadtArray;

@end
//重用
static NSString *ID = @"MoreSongsCell";

@implementation LTLMoreSongs
#pragma mark - 懒加载
-(NSMutableArray<XMAlbum *> *)dadtArray
{
    if (!_dadtArray) {
        _dadtArray = [NSMutableArray array];
    }
    return _dadtArray;
}
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _model.display_tag_name;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"LTLMoreSongsCell" bundle:nil] forCellReuseIdentifier:ID];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 66;
    
    [self DataAcquisition];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0);
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    return self.dadtArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTLMoreSongsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    XMAlbum *model = self.dadtArray[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTLSongViewController *song = [[LTLSongViewController alloc]init];
    XMAlbum *model = self.dadtArray[indexPath.row];
    song.XMAlbumModel = model;
    
    [self.navigationController pushViewController:song animated:YES];
}


#pragma mark - 数据
///数据
-(void)DataAcquisition
{
    if ( !_model.tag_name && _data == nil ) {
        
        [LTLNetworkRequest AlbumsGuessLikeDadt:^(NSArray<XMAlbum *> * _Nullable modelArray, XMErrorModel * _Nullable error) {
            [self.dadtArray addObjectsFromArray:modelArray];
            [self.tableView reloadData];
        }];
        
    }
    else
    {
        NSString *name = _data.tagName ?  _data.tagName : _model.tag_name;
        
        NSLog(@"LTL%@",name);
        
        [LTLNetworkRequest AlbumsListID:2 tag_name:name   Page:1 dimension:LTLDimensionClassicOrPlayUp dadt:^(NSArray<XMAlbum *> * _Nullable modelArray, XMErrorModel * _Nullable error) {
            
            [self.dadtArray addObjectsFromArray:modelArray];
            [self.tableView reloadData];
        }];
    }
}

@end
