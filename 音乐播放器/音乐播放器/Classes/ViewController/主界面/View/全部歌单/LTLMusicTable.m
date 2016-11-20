
//  LTLMusicTable.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/18.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLMusicTable.h"
#import "LTLsongSheetLayout.h"
#import "LTLsongSheetCell.h"
#import "LTLConditionalTag.h"

@interface LTLMusicTable ()<UICollectionViewDelegate,UICollectionViewDataSource>

/**
 *  歌单数组
 */
@property(nonatomic,strong)NSMutableArray *songSheetArray;


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

    if (self == [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.delegate = self;
        self.dataSource = self;
        ///注册 cell
        [self registerNib:[UINib nibWithNibName:@"LTLsongSheetCell" bundle:nil] forCellWithReuseIdentifier:cellID];
//        ///注册 cell
//        [self registerNib:[UINib nibWithNibName:@"LTLConditionalTag" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID];
        [self DataAcquisition];
    }
    return self;
}

//Items数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   
    NSLog(@"LTL%ld",self.songSheetArray.count);
    return self.songSheetArray.count;
    //    return 100;
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
    
    [LTLNetworkRequest AlbumsListID:17 tag_name:@"音乐台" Page:1 dimension:LTLDimensionNewest dadt:^(NSArray<XMAlbum *> * _Nullable modelArray, XMErrorModel * _Nullable error) {
        
        [self.songSheetArray addObjectsFromArray:modelArray];
        [self reloadData];
    }];
    
}


@end
