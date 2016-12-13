//
//  LTLNetworkRequest.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/29.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTLNetworkEnum.h"
@class XMErrorModel;
@class LTLRecommendAlbums;
@class XMMetadata;
@class XMBanner;
@class XMAlbum;
@class XMTag;
@class XMTrack;
/////数据返回函数块
//typedef void (^LTL)(NSMutableArray * _Nullable modelArray , XMErrorModel   * _Nullable error);

@interface LTLNetworkRequest : NSObject

@property(nonatomic,strong,readonly)NSArray<XMMetadata *>* _Nullable dataArray;
/**
 获取分类推荐的焦点图列表数据

 @param LTL 数据详情
 */
+(void)CategoryBanner:( nullable void (^)(NSArray <XMBanner*> * _Nullable modelArray , XMErrorModel * _Nullable error))LTL;

/**
 获取歌单
 
 @param page 请求的页数
 @param dimension 维度
 @param LTL 数据返回
 */
+(void)MetadataAlbumsPage:(NSInteger )page dimension: (LTLDimension)dimension dadt:( nullable void (^)(NSArray <XMAlbum *> * _Nullable modelArray , XMErrorModel * _Nullable error))LTL;
#pragma mark - 获取分类推荐
/**
 获取分类推荐

 @param LTL 模型数组
 */
+(void)RecommendAlbums:(nullable void (^)(NSArray <LTLRecommendAlbums *>* _Nullable modelArray) )LTL;
///根据分类和标签获取某个分类某个标签下的热门专辑列表/最新专辑列表/最多播放专辑列表
/**
 根据分类和标签获取某个分类某个标签下的热门专辑列表/最新专辑列表/最多播放专辑列表

 @param ID 分类 ID
 @param tag_name 专辑标签
 @param page 页数
 @param dimension 计算维度
 @param LTL 数据
 */
+(void)AlbumsListID:(NSInteger)ID tag_name:( nonnull NSString *)tag_name Page:(NSUInteger )page dimension: (LTLDimension)dimension dadt:( nullable void (^)(NSArray <XMAlbum *> * _Nullable modelArray , XMErrorModel * _Nullable error))LTL;
#pragma mark -获取专辑或声音的标签
/** 获取专辑或声音的标签 */
+(void)TagsList:( nullable void (^)(NSArray <XMTag*> * _Nullable modelArray , XMErrorModel * _Nullable error))LTL;

/**
 猜你喜欢

 @param LTL 数据
 */
+(void)AlbumsGuessLikePage:(NSUInteger)page  Dadt:( nullable void (^)(NSArray <XMAlbum *> * _Nullable modelArray , XMErrorModel * _Nullable error))LTL;
/**
 专辑详情
 
 @param ID 专辑 ID
 @param page  页
 @param LTL 数据
 */
+(void)AlbumsBrowseID:(NSInteger)ID page:(NSUInteger)page Dadt:( nullable void (^)(NSArray <XMTrack *> * _Nullable modelArray , XMErrorModel * _Nullable error))LTL;
/**
 搜索热词
 
 @param LTL 数据
 */
+(void)SearchHotWordsdadt:( nullable void (^)(NSArray <NSString *> * _Nullable modelArray , XMErrorModel * _Nullable error))LTL;
/**
 搜索关键词
 
 @param searchText 关键词
 @param LTL 数据
 */
+(void)SearchSuggestWords:(nonnull NSString *)searchText dadt:( nullable void (^)( XMErrorModel * _Nullable error))LTL;

+(void)searchtype:(NSUInteger)type keyWord : (nonnull NSString *)keyWord page:(NSUInteger)page dimension: (NSUInteger )dimension dadt:( nullable void (^)(  NSArray <XMAlbum*>* _Nullable  albumArray , NSArray <XMTrack*>* _Nullable trackArray , XMErrorModel * _Nullable error ))LTL;

@end
