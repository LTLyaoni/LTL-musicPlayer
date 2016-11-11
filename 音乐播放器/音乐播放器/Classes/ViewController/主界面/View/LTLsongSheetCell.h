//
//  LTLsongSheetCell.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/30.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTLsongSheetCell : UICollectionViewCell
///数据模型
@property (nonatomic , weak ) XMAlbum *model ;
///图片
@property (weak, nonatomic) IBOutlet UIImageView *icon;

@end
