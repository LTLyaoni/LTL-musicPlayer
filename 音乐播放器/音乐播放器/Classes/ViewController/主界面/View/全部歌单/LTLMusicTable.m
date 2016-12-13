
//  LTLMusicTable.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/18.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLMusicTable.h"
#import "LTLsongSheetLayout.h"
#import "LTLsongSheetCell.h"


@interface LTLMusicTable ()<UICollectionViewDelegate,UICollectionViewDataSource>

/**
 *  歌单数组
 */
@property(nonatomic,strong)NSMutableArray <XMAlbum *> *songSheetArray;

@property(nonatomic,assign)NSUInteger page;

@end
//cell重用标识符
static NSString *cellID = @"colleCell";
//重用标识符
static NSString *HeaderID = @"SongHeaderView";

@implementation LTLMusicTable
//懒加载
-(NSMutableArray *)songSheetArray
{
    if (_songSheetArray == nil) {
        _songSheetArray = [NSMutableArray array];
    }
    return _songSheetArray;
}

#pragma mark - 初始化
+(LTLMusicTable *)initLTLMusicTable
{
    LTLsongSheetLayout *Layout =[[LTLsongSheetLayout alloc]init];
    
//    Layout.headerReferenceSize = CGSizeMake(100, 100);
    
    CGFloat w = (LTL_WindowW-30-2*10)/2;
    Layout.itemSize = CGSizeMake( w, w+30);
    
    LTLMusicTable *musicTable = [[LTLMusicTable alloc]initWithFrame:CGRectZero collectionViewLayout:Layout];
    
    
    
    musicTable.backgroundColor = [UIColor whiteColor];
    
    return musicTable;
}
//初始化
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        _page = 0;
        
        self.delegate = self;
        self.dataSource = self;
        ///注册 cell
        [self registerNib:[UINib nibWithNibName:@"LTLsongSheetCell" bundle:nil] forCellWithReuseIdentifier:cellID];
        
        [self DataAcquisition];
        
        self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(DataAcquisition)];
        
        self.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           
            [self.mj_footer resetNoMoreData];
            _page = 0;
            
            [self DataAcquisition];
        }];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(DataAcquisition) name:LTLRefreshKey object:nil];
    }
    return self;
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

//Items数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.songSheetArray.count;
}
//组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    //重用标识符
    //    static NSString *ID = @"colleCell";
    ///从循环池从取出 cell
    LTLsongSheetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    //取出模型数据
//    LTLRecommendAlbums *Recommend = self.songSheetArray[indexPath.section];
    XMAlbum *model = self.songSheetArray[indexPath.row];;
    //赋值模型数据
    cell.model = model;
    
    return cell;
}



#pragma mark - 数据
///数据
-(void)DataAcquisition
{
    self.page++;
    
    [LTLNetworkRequest AlbumsListID:17 tag_name:@"音乐台" Page: _page  dimension:LTLDimensionNewest dadt:^(NSArray<XMAlbum *> * _Nullable modelArray, XMErrorModel * _Nullable error)
     {
         if (modelArray.count)
         {
             if (self.page == 1) {
                 [self.songSheetArray removeAllObjects];
             }
             
             [self.songSheetArray addObjectsFromArray:modelArray];
             
             [self reloadData];
             //结束刷新状态
             [self.mj_footer endRefreshing];
             [self.mj_header endRefreshing];
             
         } else {
             [self.mj_footer endRefreshingWithNoMoreData];
             self.page--;
         }
        
    }];
    
}
#pragma mark - 点击歌单
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"%ld",indexPath.row);
    LTLSongViewController *song = [[LTLSongViewController alloc]init];
    
    
    song.XMAlbumModel = _songSheetArray[indexPath.item];
    /// 当前信息
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"pushView"] = song;
    dic[@"toView"] = self;
    dic[@"isAnimate"] = @(NO);
    ///发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:LTLPushViewKey object:nil userInfo:[dic copy]];
}

@end
