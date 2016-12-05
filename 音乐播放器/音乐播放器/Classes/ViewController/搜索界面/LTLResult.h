//
//  LTLResult.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/30.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTLResult : UICollectionViewCell

//搜索词
@property (nonatomic,weak) NSString *searchText;

@property (nonatomic ,weak ) NSIndexPath *indexPath;
///清除数据
-(void)removeData;

@end
