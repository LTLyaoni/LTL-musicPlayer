//
//  LTLNetworkRequest.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/29.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLNetworkRequest.h"
#import "LTLRecommendAlbums.h"

@interface LTLNetworkRequest ()

@property(nonatomic,strong)NSArray<XMMetadata *>* _Nullable dataArray;

@end

@implementation LTLNetworkRequest
#pragma mark - 单例
//单例
+ (instancetype)sharedManager {
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

-(instancetype)init
{
    if (self = [super init]) {
        [LTLNetworkRequest CategoriesList:^(NSArray<XMMetadata *> *array) {
            self.dataArray = array;
        }];
    }
    return self;
}

#pragma mark - 获取分类推荐的焦点图列表数据
+(void)CategoryBanner:( LTL )LTL
{
//    NSLog(@"获取分类推荐的焦点图列表数据");
    NSMutableArray *array = [NSMutableArray array];
    /** 获取分类推荐的焦点图列表 */
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ///app的渠道号（对应渠道焦点图配置），默认值为“and-f5”
//    [params setObject:@2 forKey:@"channel"];
    ///app版本号，默认值为“4.3.2.2”
    [params setObject:@2 forKey:@"app_version"];
    ///控制焦点图图片大小参数，scale=2为iphone适配类型，scale=3为iphone6适配机型；机型为android时的一般设置scale=2。默认值为“2”
//    [params setObject:@3 forKey:@"image_scale"];
    ///分类ID
    [params setObject:@2 forKey:@"category_id"];
    ///内容类型：暂时仅专辑(album)
    [params setObject:@"album" forKey:@"content_type"];
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_CategoryBanner params:params withCompletionHander:^(id result, XMErrorModel *error) {
//        NSLog(@"LTL%@",result);
        ///数据转模型
        if(!error)
        { [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                XMBanner * model = [[XMBanner alloc]initWithDictionary:obj];
                [array addObject:model];
            }];
        }
        else
            NSLog(@"获取分类推荐的焦点图列表数据Error: error_no:%ld, error_code:%@, error_desc:%@",(long)error.error_no, error.error_code, error.error_desc);
        LTL(array,error);
    }];
}
#pragma mark - 获取分类元数据
+(void)CategoriesList:( void(^)(NSArray<XMMetadata *> *array))LTL
{
    //分类元数据
    NSMutableDictionary *params2 = [NSMutableDictionary dictionary];
    //分类id
    [params2 setObject:@2 forKey:@"category_id"];
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_MetadataList params:params2 withCompletionHander:^(id result, XMErrorModel *error) {
        if(!error)
        {
            NSMutableArray *lingShi = [NSMutableArray array];
            
            [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                XMMetadata *model = [[XMMetadata alloc]initWithDictionary:obj];
                
                [lingShi addObject:model];
                
            }];
            
            LTL([lingShi copy]);
        }
        else
            NSLog(@"Error: error_no:%ld, error_code:%@, error_desc:%@",(long)error.error_no, error.error_code, error.error_desc);
    }];
}
#pragma mark - 获取分类推荐
+(void)RecommendAlbums:(nonnull void (^)(NSArray <LTLRecommendAlbums *>* _Nullable modelArray) )LTL
{
    ///获取分类推荐数组
    NSMutableArray *array = [NSMutableArray array];
    //分类元数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@2 forKey:@"category_id"];
    [params setObject:@6 forKey:@"display_count"];
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_CategoryRecommendAlbums params:params withCompletionHander:^(id result, XMErrorModel *error) {
        if(!error)
        {
            [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LTLRecommendAlbums * model = [[LTLRecommendAlbums alloc]initWithDictionary:obj];
//                NSLog(@"%@",model.display_tag_name );
            [array addObject:model];
            
            }];
            LTL([array copy]);
        }
        else
            NSLog(@"获取分类推荐数据Error: error_no:%ld, error_code:%@, error_desc:%@",(long)error.error_no, error.error_code, error.error_desc);
        ;
    }];
//    [self CategoriesList:nil];
//    [self AlbumsGuessLike];
//    [self MetadataAlbumsPage:1 dimension:LTLDimensionTheFire dadt:^(NSMutableArray * _Nullable modelArray, XMErrorModel * _Nullable error) {
//        
//    }];
    
//    NSMutableDictionary *params2 = [NSMutableDictionary dictionary];
//    [params2 setObject:@2 forKey:@"category_id"];
//    [params2 setObject:@0 forKey:@"type"];
//    [[XMReqMgr sharedInstance] requestXMData:XMReqType_TagsList params:params2 withCompletionHander:^(id result, XMErrorModel *error) {
//        
//        NSLog(@"LTL%@",result);
//    }];
    
    
    
}

#pragma mark - 获取猜你喜欢
+(void)AlbumsGuessLike
{
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_DiscoveryRecommendAlbums params:nil withCompletionHander:^(id result, XMErrorModel *error) {
        if(!error)
//            [sself showReceivedData:result className:@"XMCategoryHumanRecommend" valuePath:nil titleNeedShow:@"categoryName"];
            NSLog(@"%@",result);
        else
            NSLog(@"%@",error.description);
    }];

}



#pragma mark - 获取歌单
+(void)MetadataAlbumsPage:(NSInteger )page dimension: (LTLDimension)dimension dadt:( LTL )LTL
{
//    NSLog(@"获取歌单");
    if (page <= 0) {
        page=1;
    }
    NSMutableArray *array = [NSMutableArray array];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ///分类ID，指定分类，为0表示热门分类
    [params setObject:@2 forKey:@"category_id"];
    //每页多少条，默认20，最多不超过200
//    [params setObject:@20 forKey:@"count"];
    [params setObject:@18 forKey:@"count"];
    ///计算维度,现支持最火(1),最新(2), 经典或播放最多(3) 做成枚举
    [params setObject:@(dimension) forKey:@"calc_dimension"];
    ///返回第几页，必须大于等于1，不填默认为1
    [params setObject:@(page) forKey:@"page"];
    ///元数据组合   比如现在想取已完本的穿越类有声小说，我们先从XMReqType_MetadataList接口得到穿越对应的元数据的attr_key、attr_value分别为97、”穿越”，然后拿到已完本对应的元数据的attr_key、attr_value分别为131、”2”，最后就可以按照本接口参数要求构造请求拿到数据
    [params setObject:@"8:歌单" forKey:@"metadata_attributes"];
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_MetadataAlbums params:params withCompletionHander:^(id result, XMErrorModel *error) {
        if(!error)
        {
            NSLog(@"%@",result[@"albums"]);
//            [result[@"albums"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                XMAlbum *model = [[XMAlbum alloc]initWithDictionary:obj];
//                model.PlayNumber = @"LTL";
//                [model LabelProcessing:model.albumTags];
//                [array addObject:model];
//            }];
            LTL(array,nil);
        }
        else
        {
            LTL(nil,error);
            NSLog(@" 获取歌单Error: error_no:%ld, error_code:%@, error_desc:%@",(long)error.error_no, error.error_code, error.error_desc);
            
        }
    }];
}

@end
