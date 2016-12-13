//
//  LTLPlayManager.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/5.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "XMTrack.h"

@protocol LTLPlayManagerDelegate <NSObject>

@optional
///每次下一首的时候将会调用
- (void)changeMusic;
///播放时被调用，频率为1s，告知当前播放进度和播放时间
- (void)playNotifyProcess:(CGFloat)percent currentSecond:(NSString *)currentSecond;
///缓冲
-(void)playBufferProcess:(CGFloat)percent;
/////播放发生变化时调用
//-(void)playChange;

@end

@interface LTLPlayManager : NSObject

//播放状态
typedef NS_ENUM(NSInteger, LTLPlayerCycle) {
    theSong = 1,   //单曲循环
    nextSong = 2,  //顺序循环
    isRandom = 3   //随机循环
};
//播放状态
typedef NS_ENUM(NSInteger, itemModel) {
    historyItem = 0,   //历史项目
    favoritelItem = 1  //最爱的项目
};
@property (nonatomic, weak) id<LTLPlayManagerDelegate> delegate;


///是否正在播放
@property (nonatomic ,readonly, getter = isPlay ) BOOL play;
///当前正在播放的
@property (nonatomic,strong,readonly) XMTrack *tracksVM;
///喜欢列表
@property (nonatomic, strong,readonly) NSMutableArray *favoriteMusic;
///历史列表
@property (nonatomic, strong,readonly) NSMutableArray *historyMusic;
///正在播放列表
@property (nonatomic, strong,readonly)  NSMutableArray *playlist;
///当前播放下标
@property (nonatomic,assign,readonly) NSInteger indexPathRow;
///播放进度
@property (nonatomic,assign,readonly) CGFloat playPercent;
///缓冲进度
@property (nonatomic,assign,readonly) CGFloat playBuffer;

@property (nonatomic,assign,readonly,getter=isLocalVideo) BOOL localVideo; //是否播放本地文件
/**AVPlayerStatusUnknown,     ////影音播放器状态未知
	AVPlayerStatusReadyToPlay,////影音播放器状态准备
	AVPlayerStatusFailed      ////影音播放器状态失败
 */
@property (nonatomic, assign) AVPlayerStatus status;
///播放模式
@property (nonatomic,assign) LTLPlayerCycle  playerCycle;
/** 初始化 */
+ (instancetype)sharedInstance;
/** 清空属性 */
//- (void)releasePlayer;

/** 装载专辑 */
- (void)playWithModel:(XMTrack *)tracks playlist:(NSArray *)playlist;
///播放或暂停音乐
- (void)pauseMusic;
///上一首
- (void)previousMusic;
///下一首
- (void)nextMusic;
///切换模式
- (void)nextCycle:(LTLPlayerCycle)cycle;
/**
 * 设置播放器从特定的时间播放
 */
- (void)seekToTime:(CGFloat)percent;
///播放第几首
- (void)setNumberOfPlay:(NSUInteger)number;
///删除某一首
- (void)removeSong:(NSUInteger)number;
///删除历史列表
- (void)delAllHistoryMusic;
///删除喜欢列表
- (void)delAllFavoriteMusic;
///是否收藏
- (BOOL)hasBeenFavoriteMusic;
///收藏
- (void)delFavoriteMusic;
///取消收藏
- (void)setFavoriteMusic;

- (void)stopMusic;

///交换歌曲位置
- (void)songExchangeAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2;
/** 数据查询 */
- (UIImage *)playCoverImage;



-(void)iPhoneSysctlbyname;
/** 保存 */
//- (BOOL)saveChanges;

#pragma mark - 音效
//播放音效
- (void)playSound:(NSString *)filename;
- (void)disposeSound:(NSString *)filename;

@end
