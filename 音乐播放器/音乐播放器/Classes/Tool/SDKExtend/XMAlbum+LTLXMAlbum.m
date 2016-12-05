//
//  XMAlbum+LTLXMAlbum.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/30.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "XMAlbum+LTLXMAlbum.h"
//运行时的库函数,运行时执行
#import <objc/runtime.h>

@implementation XMAlbum (LTLXMAlbum)
//

static char AddStringKey;//类似于一个中转站,参考
static char AddArrayKey;
///标签处理方法
-(void)LabelProcessing:(NSString *)albumTags
{   ///将标签转化为标签数组
    NSArray *arrya = [albumTags componentsSeparatedByString:@","];
    self.musicLabel = arrya;
}

#pragma mark - 标签处理
-(void)setMusicLabel:(NSArray *)musicLabel
{
    if (musicLabel != self.musicLabel) {
        objc_setAssociatedObject(self, &AddArrayKey, musicLabel, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }

}
-(NSArray *)musicLabel
{

    return objc_getAssociatedObject(self, &AddArrayKey);

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

@end
