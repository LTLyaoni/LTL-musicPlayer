//
//  LTLAllTheSong.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/18.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLAllTheSong.h"
#import "LTLsongSheetLayout.h"
#import "LTLsongSheetCell.h"
#import "LTLConditionalTag.h"

@interface LTLAllTheSong ()<UICollectionViewDelegate,UICollectionViewDataSource>

/**
 *  歌单数组
 */
@property(nonatomic,strong)NSMutableArray *songSheetArray;


@end
//cell重用标识符
static NSString *cellID = @"colleCell";
//重用标识符
static NSString *HeaderID = @"SongHeaderView";

@implementation LTLAllTheSong
#pragma mark - 初始化
+(LTLAllTheSong *)initLTLAllTheSong
{
    LTLsongSheetLayout *Layout =[[LTLsongSheetLayout alloc]init];
    
    Layout.headerReferenceSize = CGSizeMake(100, 100);
    
    LTLAllTheSong *allTheSong = [[LTLAllTheSong alloc]initWithFrame:CGRectZero collectionViewLayout:Layout];
    
    allTheSong.backgroundColor = [UIColor whiteColor];
    
    return allTheSong;
}
//初始化
-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{

    if (self == [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.delegate = self;
        self.dataSource = self;
        ///注册 cell
        [self registerNib:[UINib nibWithNibName:@"LTLsongSheetCell" bundle:nil] forCellWithReuseIdentifier:cellID];
        ///注册 cell
        [self registerNib:[UINib nibWithNibName:@"LTLConditionalTag" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderID];
        
    }
    return self;
}

//Items数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   
    
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
    LTLRecommendAlbums *Recommend = self.songSheetArray[indexPath.section];
    XMAlbum *model = Recommend.albums[indexPath.row];
    //赋值模型数据
    cell.model = model;
    
    return cell;
}
//设置头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    ///从循环池从取出 cellheadView
    LTLConditionalTag *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HeaderID forIndexPath:indexPath];
    headView.tag = indexPath.section;
    return headView;

}


@end
