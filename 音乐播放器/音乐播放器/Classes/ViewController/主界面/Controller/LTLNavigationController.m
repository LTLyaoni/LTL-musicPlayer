//
//  LTLNavigationController.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/6.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLNavigationController.h"
#import "LTLPlayControl.h"

@interface LTLNavigationController ()<LTLPlayManagerDelegate>

@property (nonatomic,strong) LTLPlayControl *PlayControl;
@end

@implementation LTLNavigationController
//添加播放控制
-(LTLPlayControl *)PlayControl
{
    if (_PlayControl == nil ) {
        _PlayControl = [LTLPlayControl viewFromXib];
        _PlayControl.width = LTL_WindowW;
        //        _PlayControl.delegate = self;
        _PlayControl.y = LTL_WindowH - _PlayControl.highly;
    }
    return _PlayControl;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加播放控制条
    [self.view addSubview:self.PlayControl];
//    [self PlayControl];
   

}
#pragma mark - 视图出入设置
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [LTLPlayManager sharedInstance].delegate = self;
    [self changeMusic];
    
}
- (void)changeMusic
{
    [self.PlayControl setData];
    self.PlayControl.musicIsPlaying = [LTLPlayManager sharedInstance].isPlay;
}


///播放时被调用，频率为1s，告知当前播放进度和播放时间
-(void)playNotifyProcess:(CGFloat)percent currentSecond:(NSString *)currentSecond
{
    self.PlayControl.playProgress.progress = percent;
}
///缓冲
-(void)playBufferProcess:(CGFloat)percent
{
    self.PlayControl.jingDu.progress = percent;
}
@end
