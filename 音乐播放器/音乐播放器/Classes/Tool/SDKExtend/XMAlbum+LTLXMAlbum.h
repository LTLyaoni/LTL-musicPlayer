//
//  XMAlbum+LTLXMAlbum.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/30.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "XMAlbum.h"

@interface XMAlbum (LTLXMAlbum)
///播放次数
@property(nonatomic,strong)NSString *playNumber;
///标签数组
@property(nonatomic,strong)NSArray *musicLabel;
///处理标签
-(void)LabelProcessing:(NSString *)albumTags;
@end
