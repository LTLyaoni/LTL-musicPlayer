//
//  XMTrack+LTLXMTrack.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/1.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "XMTrack+LTLXMTrack.h"

@implementation XMTrack (LTLXMTrack)
static char AddStringKey;//类似于一个中转站,参考
static char AddTimeKey;
static char AddplayTimeKey;
///时间处理方法
-(void)TimeProcessing:(double)time
{
    // 创建歌曲时间戳
    NSTimeInterval createTime = time/1000;
    NSDate *timeDate= [NSDate dateWithTimeIntervalSince1970:createTime];
    self.addTime = [timeDate dateTime];
    
    self.playTime = @"LTL";
}

#pragma mark - 时间处理
-(void)setAddTime:(NSString *)addTime
{
    if (addTime != self.addTime) {
        
        objc_setAssociatedObject(self, &AddTimeKey, addTime, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}
-(NSString *)addTime
{
    return objc_getAssociatedObject(self, &AddTimeKey);
}
#pragma mark - 播放次数处理
-(void)setPlayNumber:(NSString *)playNumber
{
    if (self.playCount >= 10000.0) {
        
        CGFloat constPlay = self.playCount/10000.0;
        
        playNumber = [NSString stringWithFormat:@"%.1f万次",constPlay];
        
    } else {
        
        playNumber = [NSString stringWithFormat:@"%ld次",self.playCount];
    }
    
    if (playNumber != self.playNumber) {
        
        objc_setAssociatedObject(self, &AddStringKey, playNumber, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
}
-(NSString *)playNumber
{
    return objc_getAssociatedObject(self, &AddStringKey);
}
#pragma mark - 播放时长处理
-(void)setPlayTime:(NSString *)playTime
{
    NSTimeInterval duration = self.duration;
    // 分
    NSInteger minutes = duration/60;
    // 秒
    NSInteger seconds = (NSInteger)duration%60;
    playTime = [NSString stringWithFormat:@"%02ld:%02ld",(long)minutes,(long)seconds];
    
    if (playTime != self.playTime) {
        
        objc_setAssociatedObject(self, &AddplayTimeKey, playTime, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
}
-(NSString *)playTime
{
    return objc_getAssociatedObject(self, &AddplayTimeKey);
}
@end
