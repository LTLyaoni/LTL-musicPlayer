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
+(void)CategoryBanner:( nullable void (^)(NSArray <XMBanner*> * _Nullable modelArray , XMErrorModel * _Nullable error))LTL
{
//    NSLog(@"获取分类推荐的焦点图列表数据");
    NSMutableArray *array = [NSMutableArray array];
//    /** 获取分类推荐的焦点图列表 */
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    ///app的渠道号（对应渠道焦点图配置），默认值为“and-f5”
////    [params setObject:@2 forKey:@"channel"];
//    ///app版本号，默认值为“4.3.2.2”
//    [params setObject:@2 forKey:@"app_version"];
//    ///控制焦点图图片大小参数，scale=2为iphone适配类型，scale=3为iphone6适配机型；机型为android时的一般设置scale=2。默认值为“2”
////    [params setObject:@3 forKey:@"image_scale"];
//    ///分类ID
//    [params setObject:@2 forKey:@"category_id"];
//    ///内容类型：暂时仅专辑(album)
//    [params setObject:@"album" forKey:@"content_type"];
    
    NSDictionary *params2 = @{@"app_version" : @2 , @"category_id" : @2 ,@"content_type" : @"album"  };
    
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_CategoryBanner params:params2 withCompletionHander:^(id result, XMErrorModel *error)
    {
//        NSLog(@"LTL%@",result);
        ///数据转模型
        if(!error)
        { [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                XMBanner * model = [[XMBanner alloc]initWithDictionary:obj];
                [array addObject:model];
            }];
        }
        else
        {
            NSLog(@"获取分类推荐的焦点图列表数据Error: error_no:%ld, error_code:%@, error_desc:%@",(long)error.error_no, error.error_code, error.error_desc);
        }
        if (LTL) {
            
            LTL([array copy],error);
        }
        
    }];
}
#pragma mark - 获取分类元数据
+(void)CategoriesList:( void(^)(NSArray<XMMetadata *> *array))LTL
{
//    //分类元数据
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    //分类id
//    [params setObject:@2 forKey:@"category_id"];

    NSDictionary *params = @{@"category_id" : @2 };
    
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_MetadataList params:params withCompletionHander:^(id result, XMErrorModel *error) {
        NSLog(@"LTL %@",result);
        if(!error)
        {
            NSMutableArray *lingShi = [NSMutableArray array];
            
            [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                XMMetadata *model = [[XMMetadata alloc]initWithDictionary:obj];
                
                [lingShi addObject:model];
                
            }];
            if (LTL) {
                
                LTL([lingShi copy]);
            }
            
        }
        else
            NSLog(@"Error: error_no:%ld, error_code:%@, error_desc:%@",(long)error.error_no, error.error_code, error.error_desc);
    }];
}
#pragma mark - 获取分类推荐
+(void)RecommendAlbums:(nullable void (^)(NSArray <LTLRecommendAlbums *>* _Nullable modelArray) )LTL
{
    ///获取分类推荐数组
    NSMutableArray *array = [NSMutableArray array];
//    //分类元数据
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:@2 forKey:@"category_id"];
//    [params setObject:@6 forKey:@"display_count"];
    NSDictionary *params =@{@"category_id" : @2 ,@"display_count" : @6 };
    
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_CategoryRecommendAlbums params:params withCompletionHander:^(id result, XMErrorModel *error) {
        if(!error)
        {
            [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            LTLRecommendAlbums * model = [[LTLRecommendAlbums alloc]initWithDictionary:obj];
//                NSLog(@"%@",model.display_tag_name );
            [array addObject:model];
            
            }];
            if (LTL) {
                
                LTL([array copy]);
            }
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
    
//    [self TagsList];
    
//    [self CategoriesList:nil];
//    [self LTL];
}
+(void)LTL
{
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_CategoriesList params:nil withCompletionHander:^(id result, XMErrorModel *error) {
        if(!error)
//            [sself showReceivedData:result className:@"XMCategory" valuePath:nil titleNeedShow:@"categoryName"];
            NSLog(@"%@",result);
        else
            NSLog(@"%@",error.description);
        
    }];

}
#pragma mark -获取专辑或声音的标签
/** 获取专辑或声音的标签 */
+(void)TagsList:( nullable void (^)(NSArray <XMTag*> * _Nullable modelArray , XMErrorModel * _Nullable error))LTL
{
    NSMutableArray <XMTag *>* lingShi = [NSMutableArray array];
    
//    NSMutableDictionary *params2 = [NSMutableDictionary dictionary];
//    ///分类
//    [params2 setObject:@2 forKey:@"category_id"];
//    //标签类型
//    [params2 setObject:@0 forKey:@"type"];
    
    NSDictionary *params = @{@"category_id": @2 ,@"type" : @0 };
    
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_TagsList params:params withCompletionHander:^(id result, XMErrorModel *error) {
//        NSLog(@"LTL%@",result);
        if (!error)
        {
            
            [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                XMTag *model = [[XMTag alloc]initWithDictionary:obj];
                [lingShi addObject:model];
            }];
        }
        if (LTL) {
            LTL(lingShi,error);
        }
    }];
}
#pragma mark -根据分类和标签获取某个分类某个标签下的热门专辑列表/最新专辑列表/最多播放专辑列表
///根据分类和标签获取某个分类某个标签下的热门专辑列表/最新专辑列表/最多播放专辑列表
/**
 根据分类和标签获取某个分类某个标签下的热门专辑列表/最新专辑列表/最多播放专辑列表
 
 @param ID 分类 ID
 @param tag_name 专辑标签
 @param page 页数
 @param dimension 计算维度
 @param LTL 数据
 */
+(void)AlbumsListID:(NSInteger)ID tag_name:(NSString *)tag_name Page:(NSUInteger )page dimension: (LTLDimension)dimension dadt:( nullable void (^)(NSArray <XMAlbum *> * _Nullable modelArray , XMErrorModel * _Nullable error))LTL
{
    if (page <= 0) {
        page=1;
    }
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    ///分类ID，指定分类，为0表示热门分类
    [params setObject:@(ID) forKey:@"category_id"];
    
    [params setObject:tag_name forKey:@"tag_name"];
    ///计算维度,现支持最火(1),最新(2), 经典或播放最多(3) 做成枚举
    [params setObject:@(dimension) forKey:@"calc_dimension"];
    //每页多少条，默认20，最多不超过200
    [params setObject:@18 forKey:@"count"];
    ///返回第几页，必须大于等于1，不填默认为1
    [params setObject:@(page) forKey:@"page"];
    
     NSMutableArray *lingShi = [NSMutableArray array];
    
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_AlbumsList params:params withCompletionHander:^(id result, XMErrorModel *error) {
        
        if(!error)
        {
            [result[@"albums"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                XMAlbum *model = [[XMAlbum alloc]initWithDictionary:obj];
                model.playNumber = @"LTL";
                [model LabelProcessing:model.albumTags];
                [lingShi addObject:model];
            }];
            
        }
        else
            NSLog(@"%@   %@",error.description,result);
        
        if (LTL) {
            
            LTL([lingShi copy],error);
        }
    }];

}


#pragma mark - 获取猜你喜欢
/**
 猜你喜欢
 
 @param LTL 数据
 */
+(void)AlbumsGuessLikeDadt:( nullable void (^)(NSArray <XMAlbum *> * _Nullable modelArray , XMErrorModel * _Nullable error))LTL
{
    NSMutableArray *lingShi = [NSMutableArray array];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:@18 forKey:@"like_count"];
    
    NSDictionary *params = @{@"like_count" : @18 };
    
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_AlbumsGuessLike params:params withCompletionHander:^(id result, XMErrorModel *error) {
        
        if(!error)
        {
            [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                XMAlbum *model = [[XMAlbum alloc]initWithDictionary:obj];
                model.playNumber = @"LTL";
                [model LabelProcessing:model.albumTags];
                [lingShi addObject:model];
            }];
        }
        else
            NSLog(@"%@   %@",error.description,result);
        
        if (LTL) {
            
            LTL([lingShi copy],error);
        }

    }];

}

/**
 专辑详情

 @param ID 专辑 ID
 @param page  页
 @param LTL 数据
 */
+(void)AlbumsBrowseID:(NSInteger)ID page:(NSUInteger)page Dadt:( nullable void (^)(NSArray <XMTrack *> * _Nullable modelArray , XMErrorModel * _Nullable error))LTL
{
    
    NSMutableArray <XMTrack *> *lingShi = [NSMutableArray array];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(ID) forKey:@"album_id"];
    [params setObject:@20 forKey:@"count"];
    [params setObject:@(page) forKey:@"page"];
    
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_AlbumsBrowse params:params withCompletionHander:^(id result, XMErrorModel *error) {
        if (!error)
        {
            [result[@"tracks"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                XMTrack *model = [[XMTrack alloc]initWithDictionary:obj];
                model.playNumber = @"LTL";
                [model TimeProcessing:model.createdAt];
                [lingShi addObject:model];
            }];
        }
        if (LTL) {
            LTL(lingShi,error);
        }
    }];


}


#pragma mark - 获取歌单
+(void)MetadataAlbumsPage:(NSInteger )page dimension: (LTLDimension)dimension dadt:( nullable void (^)(NSArray <XMAlbum *> * _Nullable modelArray , XMErrorModel * _Nullable error))LTL
{
//    NSLog(@"获取歌单");
    if (page <= 0) {
        page=1;
    }
    NSMutableArray <XMAlbum *>*lingShi = [NSMutableArray array];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    ///分类ID，指定分类，为0表示热门分类
//    [params setObject:@2 forKey:@"category_id"];
//    //每页多少条，默认20，最多不超过200
////    [params setObject:@20 forKey:@"count"];
//    [params setObject:@18 forKey:@"count"];
//    ///计算维度,现支持最火(1),最新(2), 经典或播放最多(3) 做成枚举
//    [params setObject:@(dimension) forKey:@"calc_dimension"];
//    ///返回第几页，必须大于等于1，不填默认为1
//    [params setObject:@(page) forKey:@"page"];
//    ///元数据组合   比如现在想取已完本的穿越类有声小说，我们先从XMReqType_MetadataList接口得到穿越对应的元数据的attr_key、attr_value分别为97、”穿越”，然后拿到已完本对应的元数据的attr_key、attr_value分别为131、”2”，最后就可以按照本接口参数要求构造请求拿到数据
//    [params setObject:@"8:歌单" forKey:@"metadata_attributes"];
    
    
    NSDictionary *params = @{@"category_id" : @2 ,@"count" : @18 ,@"calc_dimension" : @(dimension) ,@"page" : @(page) };
    
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_MetadataAlbums params:params withCompletionHander:^(id result, XMErrorModel *error) {
        if(!error)
        {
            NSLog(@"%@",result[@"albums"]);
            [result[@"albums"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                XMAlbum *model = [[XMAlbum alloc]initWithDictionary:obj];
                [lingShi addObject:model];
            }];
        }
        else
        {
            NSLog(@" 获取歌单Error: error_no:%ld, error_code:%@, error_desc:%@",(long)error.error_no, error.error_code, error.error_desc);
        }
        if (LTL) {
            
            LTL([lingShi copy],error);
        }
        
    }];
}

/**
 搜索热词

 @param LTL 数据
 */
+(void)SearchHotWordsdadt:( nullable void (^)(NSArray <NSString *> * _Nullable modelArray , XMErrorModel * _Nullable error))LTL
{
    NSDictionary *params = @{@"top" :@10 };
    NSMutableArray<NSString *> *lingshi = [NSMutableArray array];
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_SearchHotWords params:params withCompletionHander:^(id result, XMErrorModel *error) {
//        [sself showReceivedData:result className:@"XMHotword" valuePath:@"" titleNeedShow:@"searchWord"];
        if (!error) {
            [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
                XMHotword *model = [[XMHotword alloc]initWithDictionary:obj];
                [lingshi addObject:model.searchWord];
            }];
        }
        if (LTL) {
            LTL([lingshi copy],error);
        }
        
    }];
}

/**
 搜索关键词

 @param searchText 关键词
 @param LTL 数据
 */
+(void)SearchSuggestWords:(NSString *)searchText dadt:( nullable void (^)( XMErrorModel * _Nullable error))LTL
{
    NSDictionary *params = @{@"q":searchText};
    
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_SearchSuggestWords params:params withCompletionHander:^(id result, XMErrorModel *error) {
        
        if (!error) {
            
            LTLSearchSuggestWords *model = [[LTLSearchSuggestWords alloc]initWithDictionary:result];
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            
            dic[@"SearchSuggestWords"] = model;
            
            ///发送通知
            [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchSuggestWords" object:nil userInfo:[dic copy]];
        }
        
        if (LTL) {
            LTL(error);
        }
    }];
}
+(void)searchtype:(NSUInteger)type keyWord : (NSString *)keyWord page:(NSUInteger)page dimension: (NSUInteger )dimension dadt:( nullable void (^)( NSArray <XMAlbum*>* albumArray , NSArray <XMTrack*>* trackArray , XMErrorModel *error ))LTL
{

    NSMutableArray *lingShi = [NSMutableArray array];
    
    NSDictionary *params = @{@"category_id" : @2 ,@"count" : @20 ,@"q" : keyWord , @"calc_dimension" : @(dimension) };
    
    if (!type) {
        
        [[XMReqMgr sharedInstance] requestXMData:XMReqType_SearchAlbums params:params withCompletionHander:^(id result, XMErrorModel *error) {
            
            if (!error)
            {
                
                [result[@"albums"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    XMAlbum *model = [[XMAlbum alloc]initWithDictionary:obj];
                    model.playNumber = @"LTL";
                    [model LabelProcessing:model.albumTags];

                    [lingShi addObject:model];
                    
                }];

                if (LTL) {
                    
                    LTL([lingShi copy] ,nil,error);
                }
                
            }
        }];
        
    } else {
        
        [[XMReqMgr sharedInstance] requestXMData:XMReqType_SearchTracks params:params withCompletionHander:^(id result, XMErrorModel *error)
         {

             if (!error) {
                 
//                 LTLLog(@"%@",result[@"tracks"]);
                 
                 [result[@"tracks"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                     
                     XMTrack *model = [[XMTrack alloc]initWithDictionary:obj];
                     
                     model.playNumber = @"LTL";
                     
                     [model TimeProcessing:model.createdAt];
                     
//                     LTLLog(@"%@",model.PlayNumber);
  
                     [lingShi addObject:model];
                 }];
                 
             }
             if (LTL) {
                 LTL(nil ,[lingShi copy],error);
             }
             
        }];
        
        
    }
    

}


@end
