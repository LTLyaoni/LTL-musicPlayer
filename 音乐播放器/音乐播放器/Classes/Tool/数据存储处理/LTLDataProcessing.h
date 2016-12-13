//
//  LTLDataProcessing.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/12/9.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTLDataProcessing : NSObject

//单例
+ (instancetype)sharedManager;

/**
 * ------------------------"  存入  " -----------------------
 */
//ZM_Add 存入单个模型
+ (void)putModelObject:(XMTrack *)object;

///保存上次播放列表
//ZM_Add 存入模型数组：只用一个Id
+ (void)putModelObjectArray:(NSArray <XMTrack*> *)objectArray;
//////保存历史
//ZM_Add 存入单个模型
+ (void)putModelHistoryListObject:(XMTrack *)object;
/**
 * ------------------------"  读取  " -----------------------
 */

//ZM_Add << 根据一个表名取出一个数组模型对象
+ (NSMutableArray <XMTrack*> *)getLastPlayList;
//ZM_Add << 根据一个表名取出一个数组模型对象
+ (NSMutableArray <XMTrack*> *)getHistoryList;

+ (NSMutableArray <XMTrack*> *)getLikeList;
/**
 * ------------------------"  删除  " -----------------------
 */
///删除某条数据
+ (void)deleteObjectById:(XMTrack *)object;
///删除historyList某条数据
+ (void)deleteHistoryListObjectById:(XMTrack *)object;
/**
 * ------------------------"  查询  " -----------------------
 */
///收藏
+ (BOOL)hasBeenFavoriteMusic:(XMTrack *)object;
////删除喜欢列表
+(void)deleteLikeList;
////删除历史列表
+(void)deleteHistoryList;
@end
