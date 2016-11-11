//
//  LTLMainController.h
//  音乐播放器
//
//  Created by Apple_Lzzy46 on 16/10/26.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTLMainController : UIViewController
///歌单视图
@property (weak, nonatomic) IBOutlet UICollectionView *CollectionView;
#pragma mark - 数据
-(void)DataAcquisition;
@end
