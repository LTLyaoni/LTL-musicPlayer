//
//  LTLMainInterfaceFlowLayout.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/18.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLMainInterfaceFlowLayout.h"

@implementation LTLMainInterfaceFlowLayout
//布局属性
-(void)prepareLayout
{
    [super prepareLayout];
    //item大小
    self.itemSize = self.collectionView.bounds.size;
    //行列间距
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    ///滑动方向
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    ///分页效果
    self.collectionView.pagingEnabled = YES;
    //关闭水平指示器
    self.collectionView.showsHorizontalScrollIndicator = NO;
    ///关闭弹簧效果
    self.collectionView.bounces = NO;
}
@end
