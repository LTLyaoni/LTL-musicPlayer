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
//播放时被调用，频率为1s，告知当前播放进度和播放时间
- (void)playNotifyProcess:(CGFloat)percent currentSecond:(NSString *)currentSecond;

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
@property (nonatomic, strong,readonly)  NSArray *Playlist;

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



- (void)delAllHistoryMusic;
- (void)delAllFavoriteMusic;
- (void)stopMusic;

/** 数据查询 */
- (UIImage *)playCoverImage;
/** 保存 */
//- (BOOL)saveChanges;

#pragma mark - 音效
//播放音效
- (void)playSound:(NSString *)filename;
- (void)disposeSound:(NSString *)filename;

@end
