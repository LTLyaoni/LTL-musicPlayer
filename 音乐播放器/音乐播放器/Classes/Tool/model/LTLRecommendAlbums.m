//
//  LTLRecommendAlbums.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/12.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLRecommendAlbums.h"


@implementation LTLRecommendAlbums
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        
        [self setValuesForKeysWithDictionary:dictionary];
        
        NSMutableArray *linagShi = [NSMutableArray array];
        
        [self.albums enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            XMAlbum *model = [[XMAlbum alloc]initWithDictionary:obj];
            model.playNumber = @"LTL";
            [model LabelProcessing:model.albumTags];
            [linagShi addObject:model];
            
        } ];
        self.albums = [linagShi copy];
    }
    return self;
}
@end
