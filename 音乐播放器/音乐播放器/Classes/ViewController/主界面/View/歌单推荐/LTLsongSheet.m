//
//  LTLsongSheet.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/18.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLsongSheet.h"
#import "LTLsongSheetCell.h"
#import "LTLGroupHeader.h"
#import "LTLsongSheetLayout.h"

@interface LTLsongSheet ()<UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate>
/**
 *  歌单数组
 */
@property(nonatomic,strong)NSMutableArray *songSheetArray;

//约束
@property (strong, nonatomic)  UICollectionViewFlowLayout *flowtLayout;

@end
//重用标识符
static NSString *HeaderID = @"HeaderView";
//cell重用标识符
static NSString *cellID = @"colleCell";

static NSString *FooterID = @"FooterView";

@implementation LTLsongSheet

#pragma mark - 懒加载
//懒加载
-(NSMutableArray *)songSheetArray
{
    if (_songSheetArray == nil) {
        _songSheetArray = [NSMutableArray array];
    }
    return _songSheetArray;
}

+(LTLsongSheet *)initSongSheet
{
    LTLsongSheetLayout *layout = [[LTLsongSheetLayout alloc]init];
    //尾视图
    //头视图高度
    layout.headerReferenceSize = CGSizeMake(25, 25);
    
    LTLsongSheet *songSheet = [[LTLsongSheet alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    songSheet.flowtLayout = layout;
    songSheet.backgroundColor = [UIColor whiteColor];
    return songSheet;
}

#pragma mark - 初始化
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.bounces = NO;
        
        self.delegate = self;
        self.dataSource = self;
        ///注册 cell
        [self registerNib:[UINib nibWithNibName:@"LTLsongSheetCell" bundle:nil] forCellWithReuseIdentifier:cellID];
        [self registerNib:[UINib nibWithNibName:@"LTLGroupHeader" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID];
    
        [self registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FooterID];
        
        //获取数据
        [self DataAcquisition];
        
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
    LTLRecommendAlbums *model =self.songSheetArray[section];
    
    return model.albums.count;
    //    return 100;
}
//组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.songSheetArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    //重用标识符
    //    static NSString *ID = @"colleCell";
    ///从循环池从取出 cell
    LTLsongSheetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    //取出模型数据
    LTLRecommendAlbums *Recommend = self.songSheetArray[indexPath.section];
    XMAlbum *model = Recommend.albums[indexPath.row];
    //赋值模型数据
    cell.model = model;
    
    return cell;
}
//设置头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {
        
        ///从循环池从取出 cellheadView
        LTLGroupHeader *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HeaderID forIndexPath:indexPath];
        headView.tag = indexPath.section;
        
        LTLRecommendAlbums *model = self.songSheetArray[indexPath.section];
        
        headView.model = model;
        
//        headView.backgroundColor = [UIColor blueColor];
        return headView;
        
    } else {
        
        UICollectionReusableView *FooterView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:FooterID forIndexPath:indexPath];
        FooterView.backgroundColor = [UIColor yellowColor];
        FooterView.highly = 0;
        if (indexPath.section == self.songSheetArray.count-1) {
             FooterView.highly = 36;
        }
        return FooterView;
    }
 
}

#pragma mark - 点击歌单
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"%ld",indexPath.row);
    LTLSongViewController *song = [[LTLSongViewController alloc]init];
    
    LTLRecommendAlbums *model = self.songSheetArray[indexPath.section];
    
    song.XMAlbumModel = model.albums[indexPath.row];
    
//    if ([self.LTLDelegate respondsToSelector:@selector(LTLsongSheet:VC:)]) {
//        [self.LTLDelegate LTLsongSheet:self VC:song];
//    }
    /// 当前信息
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"pushView"] = song;
    dic[@"toView"] = self;
    dic[@"isAnimate"] = @(YES);
    ///发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:LTLPushViewKey object:nil userInfo:[dic copy]];
}
#pragma mark - 数据
///数据
-(void)DataAcquisition
{

   [LTLNetworkRequest RecommendAlbums:^(NSArray<LTLRecommendAlbums *> * _Nullable modelArray) {
       [self.songSheetArray addObjectsFromArray:modelArray];
       [self reloadData];
   }];
    
}


@end
