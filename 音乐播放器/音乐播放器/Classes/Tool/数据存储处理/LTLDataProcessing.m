//
//  LTLDataProcessing.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/12/9.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLDataProcessing.h"
#import "YTKKeyValueStore.h"

@interface LTLDataProcessing ()
///喜欢列表
@property(nonatomic,strong) NSString *likeList;
///历史列表
@property(nonatomic,strong) NSString *historyList;
///历史列表
@property(nonatomic,strong) NSString *lastPlayList;

@property(nonatomic,strong ) YTKKeyValueStore *store;

@end

@implementation LTLDataProcessing
//单例
+ (instancetype)sharedManager
{
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
        [self initData];
    }
    return self;
}

-(void)initData
{
    self.likeList = @"likeList";
    self.historyList= @"historyList";
    self.lastPlayList= @"lastPlayList";
    
    self.store = [[YTKKeyValueStore alloc] initDBWithName:@"LTLMusic.db"];
    
    [self.store createTableWithName:self.likeList];
    [self.store createTableWithName:self.self.historyList];
    [self.store createTableWithName:self.self.lastPlayList];
}

/**
 * ------------------------"  存入  " -----------------------
 */
//ZM_Add 存入单个模型
+ (void)putModelObject:(XMTrack *)object
{
    LTLDataProcessing *db = [LTLDataProcessing sharedManager];
    
    [db.store putModelObject:object withId:[NSString stringWithFormat:@"%ld",object.trackId]  intoTable:db.likeList];
    
}

///保存上次播放列表
//ZM_Add 存入模型数组：只用一个Id
+ (void)putModelObjectArray:(NSArray <XMTrack*> *)objectArray
{

    LTLDataProcessing *db = [LTLDataProcessing sharedManager];
    
    if ([db.store eraseTable:db.lastPlayList]) {
        
        [db.store putModelObjectArray:objectArray intoTable:db.lastPlayList];
        LTLLog(@"保存成功!");
    }
}

//////保存历史
//ZM_Add 存入单个模型
+ (void)putModelHistoryListObject:(XMTrack *)object
{

    LTLDataProcessing *db = [LTLDataProcessing sharedManager];
    
    [db.store putModelObject:object withId:[NSString stringWithFormat:@"%ld",object.trackId]  intoTable:db.historyList];

}

/**
 * ------------------------"  读取  " -----------------------
 */

//ZM_Add << 根据一个表名取出一个数组模型对象 喜欢列表
+ (NSMutableArray <XMTrack*> *)getLikeList
{
    LTLDataProcessing *db = [LTLDataProcessing sharedManager];
    
    NSMutableArray *data = [db.store getModelArrayByclassName:[XMTrack class]fromTable:db.likeList];

    
    NSEnumerator * enumerator = [data reverseObjectEnumerator];
    
    id obj = [data lastObject];;

    NSMutableArray *likeList = [NSMutableArray array];
    
    while (  obj = [enumerator nextObject])
    {
        
        [likeList addObject:obj];
    }
    
    return likeList;
}
//ZM_Add << 根据一个表名取出一个数组模型对象 历史播放
+ (NSMutableArray <XMTrack*> *)getHistoryList
{
    LTLDataProcessing *db = [LTLDataProcessing sharedManager];
    
    
    NSMutableArray *data = [db.store getModelArrayByclassName:[XMTrack class]fromTable:db.historyList];
    NSEnumerator * enumerator = [data reverseObjectEnumerator];
    
    id obj = [data lastObject];;
    
    NSMutableArray *historyList = [NSMutableArray array];
    
    while (  obj = [enumerator nextObject])
    {
        
        [historyList addObject:obj];
    }
    return historyList;
}
//ZM_Add << 根据一个表名取出一个数组模型对象  上次播放
+ (NSMutableArray <XMTrack*> *)getLastPlayList
{
    LTLDataProcessing *db = [LTLDataProcessing sharedManager];
    
    NSMutableArray *data = [db.store getModelArrayByclassName:[XMTrack class]fromTable:db.lastPlayList];
    
    return data;
}
/**
 * ------------------------"  删除  " -----------------------
 */
///删除likeList某条数据
+ (void)deleteObjectById:(XMTrack *)object
{
    LTLDataProcessing *db = [LTLDataProcessing sharedManager];
    
    [db.store deleteObjectById:[NSString stringWithFormat:@"%ld",object.trackId] fromTable:db.likeList];

}

///删除historyList某条数据
+ (void)deleteHistoryListObjectById:(XMTrack *)object
{
    LTLDataProcessing *db = [LTLDataProcessing sharedManager];
    
    [db.store deleteObjectById:[NSString stringWithFormat:@"%ld",object.trackId] fromTable:db.historyList];
}

////删除喜欢列表
+(void)deleteLikeList
{
    LTLDataProcessing *db = [LTLDataProcessing sharedManager];
    
    if ([db.store eraseTable:db.likeList]) {
        LTLLog(@"删除成功!");
    }
    
}
////删除历史列表
+(void)deleteHistoryList
{
    LTLDataProcessing *db = [LTLDataProcessing sharedManager];
    
    if ([db.store eraseTable:db.historyList]) {
        LTLLog(@"删除成功!");
    }
    
}
/**
 * ------------------------"  查询  " -----------------------
 */
///收藏
+ (BOOL)hasBeenFavoriteMusic:(XMTrack *)object
{

    LTLDataProcessing *db = [LTLDataProcessing sharedManager];
    
    XMTrack *data = [db.store getModelObjectById:[NSString stringWithFormat:@"%ld",object.trackId] className:[XMTrack class] fromTable:db.likeList];
    
    if (data) {
        return YES;
    } else {
        
        return NO;
        
    }

}

@end
