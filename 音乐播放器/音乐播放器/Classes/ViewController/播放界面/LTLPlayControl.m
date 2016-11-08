//
//  LTLPlayControl.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/4.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLPlayControl.h"
#import "LTLMainPlayController.h"
#import "LTLuserInfo.h"


@interface LTLPlayControl ()<CAAnimationDelegate>

///歌手名
@property (weak, nonatomic) IBOutlet UILabel *SingerName;
///歌名
@property (weak, nonatomic) IBOutlet UILabel *songName;
///初始圆形
@property (strong ,nonatomic) UIBezierPath *bezierPath;
//最终圆形
@property (strong ,nonatomic) UIBezierPath *finalPath;
///播放器
@property (nonatomic,strong) LTLPlayManager *player;
///是否播放
@property (nonatomic) BOOL musicIsPlaying;
///播放按钮
@property (weak, nonatomic) IBOutlet UIButton *musicToggleButton;


@end

@implementation LTLPlayControl

-(LTLPlayManager *)player
{
    if (_player == nil) {
        _player = [LTLPlayManager sharedInstance];
    }
    return _player;
}

#pragma mark - 初始化
-(void)awakeFromNib
{
    [super awakeFromNib];
//    //初始化播放器
//    self.player = [XMSDKPlayer sharedPlayer];
//    self.player.trackPlayDelegate = self;
    //设置图片圆形
    self.songImage.layer.cornerRadius = self.songImage.width/2;
    ///接受通知
    [self receiveNotification];
    self.musicIsPlaying = _player.isPlay;
}
#pragma mark - 点击
- (void)setMusicIsPlaying:(BOOL)musicIsPlaying {
    _musicIsPlaying = musicIsPlaying;
    if (_musicIsPlaying) {
        [_musicToggleButton setImage:[UIImage imageNamed:@"big_pause_button"] forState:UIControlStateNormal];
        
    } else {
        [_musicToggleButton setImage:[UIImage imageNamed:@"big_play_button"] forState:UIControlStateNormal];
    }
}
///上一首
- (IBAction)LastOne:(UIButton *)sender {
    NSLog(@"上一首");
    if (_player.status ==  AVPlayerStatusReadyToPlay) {
        [_player previousMusic];
        self.musicIsPlaying = _player.isPlay;
        
    }else{
        NSLog(@"等待加载音乐");
    }
}
///播放或暂停
- (IBAction)play:(UIButton *)sender {
    NSLog(@"播放或暂停");
    if (_player.status ==  AVPlayerStatusReadyToPlay) {
        
        [_player pauseMusic];
        self.musicIsPlaying = _player.isPlay;
        
    }else{
        NSLog(@"当前没有音乐") ;
    }
    
}
///下一首
- (IBAction)nextHead:(UIButton *)sender {
    NSLog(@"下一首");
    if (_player.status ==  AVPlayerStatusReadyToPlay) {
        
        [_player nextMusic];
        self.musicIsPlaying = _player.isPlay;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"setPausePlayView" object:nil userInfo:nil];
        
    }else{
        //        [self showMiddleHint:@"等待加载音乐"];
        NSLog(@"等待加载音乐");
    }
}
#pragma mark - 接受播放等通知
///接受播放等通知
-(void)receiveNotification
{
    // 开启一个通知接受,开始播放
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playNotification:) name:@"LTLPlay" object:nil];
}
-(void)playNotification:(NSNotification *)notification
{
    LTLuserInfo *userInfo = notification.userInfo[@"Play"];
    
//    ///点击的歌
    XMTrack *TrackData = userInfo.songArray[userInfo.serialNumber];

    [self.player playWithModel:TrackData playlist:userInfo.songArray];
    
    self.musicIsPlaying = _player.isPlay;
}


-(void)LTL
{
    //初始圆形的范围
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:self.songImage.frame];
    
    CGPoint extremePoint = CGPointMake(self.center.x, self.center.y);
    //圆形半径
    float radius = sqrtf(extremePoint.x * extremePoint.x + extremePoint.y * extremePoint.y);
    //最终圆形的范围
    UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.songImage.frame, -radius, -radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.path = finalPath.CGPath;
    self.layer.mask = maskLayer;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.fromValue = (__bridge id _Nullable)(bezierPath.CGPath);
    animation.toValue = (__bridge id _Nullable)(finalPath.CGPath);
    animation.duration = 2;
    animation.delegate = self;
    [maskLayer addAnimation:animation forKey:@"path"];

}
///点击视图
- (IBAction)PlayControlClick:(UIButton *)sender {
//    NSLog(@"点击播放控制条");
//    if ([self.delegate respondsToSelector:@selector(disPlayController:)]) {
//        [self.delegate disPlayController:self];
//    }
    LTLMainPlayController *MainPlay = [[LTLMainPlayController alloc]initWithNibName:@"LTLMainPlayController" bundle:nil];
    ///解决 Presenting view controllers on detached view controllers is discouraged 警告
    UIWindow *win = [UIApplication sharedApplication].keyWindow;

    [win.rootViewController presentViewController:MainPlay animated:YES completion:nil];
}
#pragma mark - 设置数据
-(void)setData
{
    XMTrack *Track = [self.player currentTrack];
    NSURL *url = [NSURL URLWithString:Track.coverUrlMiddle];
    [self.songImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"9"]];
    self.songName.text = Track.trackTitle;
    self.SingerName.text = Track.announcer.nickname;
}

-(void)dealloc
{
    /// 关闭消息中心
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"LTLPlayControl销毁");
}
@end
