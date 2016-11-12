//
//  LTLRecommendAlbums.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/12.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTLRecommendAlbums : NSObject
///有更多的
@property (nonatomic,assign) NSInteger has_more;
///名称
@property (nonatomic,strong) NSString *display_tag_name;
///歌单
@property (nonatomic,strong) NSArray *albums;
///分类
@property (nonatomic,assign) NSInteger category_id;
///类型
@property (nonatomic,strong) NSString *tag_name;


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end
