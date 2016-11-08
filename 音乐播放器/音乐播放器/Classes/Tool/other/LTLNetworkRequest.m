//
//  LTLNetworkRequest.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/29.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLNetworkRequest.h"

@implementation LTLNetworkRequest



#pragma mark - 获取分类推荐的焦点图列表数据
+(void)CategoryBanner:( LTL )LTL
{
//    NSLog(@"获取分类推荐的焦点图列表数据");
    NSMutableArray *array = [NSMutableArray array];
    /** 获取分类推荐的焦点图列表 */
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setObject:@10 forKey:@"channel"];
//    [params setObject:@10 forKey:@"app_version"];
//    [params setObject:@3 forKey:@"image_scale"];
    [params setObject:@2 forKey:@"category_id"];
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
#pragma mark - 获取分类内容
+(void)CategoriesList:( LTL )LTL
{
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_CategoriesList params:nil withCompletionHander:^(id result, XMErrorModel *error) {

        NSLog(@"%@",result);

    }];
    //分类元数据
    NSMutableDictionary *params2 = [NSMutableDictionary dictionary];
    [params2 setObject:@2 forKey:@"category_id"];
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_MetadataList params:params2 withCompletionHander:^(id result, XMErrorModel *error) {
        if(!error)
//            [sself showReceivedData:result className:@"XMMetadata" valuePath:@"metadata" titleNeedShow:@"displayName"];
            NSLog(@"%@",result);
        else
            NSLog(@"Error: error_no:%ld, error_code:%@, error_desc:%@",(long)error.error_no, error.error_code, error.error_desc);
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
    [params setObject:@2 forKey:@"category_id"];
//    [params setObject:@20 forKey:@"count"];
    [params setObject:@18 forKey:@"count"];
    [params setObject:@(dimension) forKey:@"calc_dimension"];
    [params setObject:@(page) forKey:@"page"];
    [params setObject:@"8:歌单" forKey:@"metadata_attributes"];
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_MetadataAlbums params:params withCompletionHander:^(id result, XMErrorModel *error) {
        if(!error)
        {
//            NSLog(@"%@",result[@"albums"]);
            [result[@"albums"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                XMAlbum *model = [[XMAlbum alloc]initWithDictionary:obj];
                model.PlayNumber = @"LTL";
                [model LabelProcessing:model.albumTags];
                [array addObject:model];
        }];
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
