//
//  LTLMusicLibrary.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/21.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLMusicLibrary.h"
#import "LTLCategoryTableCell.h"
#import "LTLMoreSongs.h"

@interface LTLMusicLibrary ()<UITableViewDelegate,UITableViewDataSource>
///数据
@property(nonatomic,strong)NSArray <XMTag*> *dataArrat;
@end
static NSString *ID = @"MusicLibraryCell";
@implementation LTLMusicLibrary


#pragma mark - 初始化
///初始化
+(LTLMusicLibrary *)initLTLMusicLibrary
{
    LTLMusicLibrary *MusicLibrary = [[LTLMusicLibrary alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];

    return MusicLibrary;
}
//初始化
-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        //注册
        [self registerClass:[LTLCategoryTableCell class] forCellReuseIdentifier:ID];
        
        self.estimatedSectionHeaderHeight = 5;
//        self.estimatedSectionFooterHeight = 2;
        
        self.rowHeight = LTL_WindowW *2/5 ;
        
        [self DataAcquisition];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DataAcquisition) name:LTLRefreshKey object:nil];
        
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//底部高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArrat.count;
}
///行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
///cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTLCategoryTableCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.songTag = self.dataArrat[indexPath.section];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    LTLMoreSongs *MoreSongs = [[LTLMoreSongs alloc]init];
    
    XMTag *model =  self.dataArrat[indexPath.section];
    
    MoreSongs.data = model;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"pushView"] = MoreSongs;
    dic[@"toView"] = self;
    dic[@"isAnimate"] = 0;
    ///发送播放通知
    [[NSNotificationCenter defaultCenter] postNotificationName:LTLPushViewKey object:nil userInfo:[dic copy]];


}

#pragma mark - 数据
///数据
-(void)DataAcquisition
{
    
    [LTLNetworkRequest TagsList:^(NSArray<XMTag *> * _Nullable modelArray, XMErrorModel * _Nullable error) {
      
        self.dataArrat = modelArray;
        
        [self reloadData];
        
    }];
    
}
@end
