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
#import "LTLPlayControlIcon.h"


@interface LTLPlayControl ()
///<CAAnimationDelegate>

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
///播放按钮
@property (weak, nonatomic) IBOutlet UIButton *musicToggleButton;
///NextHead
@property (weak, nonatomic) IBOutlet UIButton *NextHead;
///LastOne
@property (weak, nonatomic) IBOutlet UIButton *LastOne;

@end

@implementation LTLPlayControl

-(LTLPlayManager *)player
{
    if (_player == nil) {
        _player = [LTLPlayManager sharedInstance];
    }
    return _player;
}
//-(instancetype)initWithCoder:(NSCoder *)aDecoder
//{
//    if (self = [super initWithCoder:aDecoder]) {
//        
//        [self setButtonIamge];
//        
//    }
//    return self;
//}
-(void)setButtonIamge
{
    
    CGSize size = CGSizeMake(28, 28);
    
    UIImage *NextHeadIamge = [LTLPlayControlIcon imageOfNextHead1WithSize:size resizing:LTLPlayControlIconResizingBehaviorAspectFit];
    UIImage *LastOneIamge = [LTLPlayControlIcon imageOfLastOne1WithSize:size resizing:LTLPlayControlIconResizingBehaviorAspectFit];
    
    [_NextHead setImage:NextHeadIamge forState:UIControlStateNormal];
    [_LastOne setImage:LastOneIamge forState:UIControlStateNormal];
}

#pragma mark - 初始化
-(void)awakeFromNib
{
    [super awakeFromNib];
//    //初始化播放器
    [self setButtonIamge];
    //设置图片圆形
    self.songImage.layer.cornerRadius = self.songImage.width/2;
    ///接受通知
    [self receiveNotification];
    self.musicIsPlaying = self.player.isPlay;
    [self setData];
}
#pragma mark - 点击
- (void)setMusicIsPlaying:(BOOL)musicIsPlaying {
    _musicIsPlaying = musicIsPlaying;
    UIImage * iamge ;
    if (_musicIsPlaying)
    {
       iamge = [LTLPlayControlIcon imageOfSuspendWithSize:_musicToggleButton.frame.size resizing:LTLPlayControlIconResizingBehaviorAspectFit];
        
    } else {
       
        iamge = [LTLPlayControlIcon imageOfPlayWithSize:_musicToggleButton.frame.size resizing:LTLPlayControlIconResizingBehaviorAspectFit];
        
    }
    
    
    [_musicToggleButton setImage:iamge forState:UIControlStateNormal];
}
///上一首
- (IBAction)LastOne:(UIButton *)sender {
    LTLLog(@"上一首");
    if (_player.status ==  AVPlayerStatusReadyToPlay) {
        [_player previousMusic];
        self.musicIsPlaying = _player.isPlay;
        
    }else{
        LTLLog(@"等待加载音乐");
    }
}
///播放或暂停
- (IBAction)play:(UIButton *)sender {
    LTLLog(@"播放或暂停");
    if (_player.status ==  AVPlayerStatusReadyToPlay) {
        
        [_player pauseMusic];
        self.musicIsPlaying = _player.isPlay;
        
    }else{
        LTLLog(@"当前没有音乐") ;
    }
    
}
///下一首
- (IBAction)nextHead:(UIButton *)sender {
    LTLLog(@"下一首");
    if (_player.status ==  AVPlayerStatusReadyToPlay) {
        
        [_player nextMusic];
        self.musicIsPlaying = _player.isPlay;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"setPausePlayView" object:nil userInfo:nil];
        
    }else{
        //        [self showMiddleHint:@"等待加载音乐"];
        LTLLog(@"等待加载音乐");
    }
}
#pragma mark - 接受播放等通知
///接受播放等通知
-(void)receiveNotification
{
    // 开启一个通知接受,开始播放
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playNotification:) name:LTLPlay object:nil];
}
-(void)playNotification:(NSNotification *)notification
{
    LTLuserInfo *userInfo = notification.userInfo[@"Play"];
//    ///点击的歌
    XMTrack *TrackData = userInfo.songArray[userInfo.serialNumber];

    [self.player playWithModel:TrackData playlist:userInfo.songArray];
    
    self.musicIsPlaying = _player.isPlay;
    
    _musicToggleButton.enabled = YES;
    _NextHead.enabled = YES;
    _LastOne.enabled = YES;
}


-(void)LTL
{
//    //初始圆形的范围
//    
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:self.songImage.frame];
//    
//    CGPoint extremePoint = CGPointMake(self.center.x, self.center.y);
//    //圆形半径
//    float radius = sqrtf(extremePoint.x * extremePoint.x + extremePoint.y * extremePoint.y);
//    //最终圆形的范围
//    UIBezierPath *finalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.songImage.frame, -radius, -radius)];
//    
//    CAShapeLayer *maskLayer = [CAShapeLayer layer];
//    maskLayer.path = finalPath.CGPath;
//    self.layer.mask = maskLayer;
//    
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
//    
//    animation.fromValue = (__bridge id _Nullable)(bezierPath.CGPath);
//    animation.toValue = (__bridge id _Nullable)(finalPath.CGPath);
//    animation.duration = 2;
//    animation.delegate = self;
//    [maskLayer addAnimation:animation forKey:@"path"];

}
///点击视图
- (IBAction)PlayControlClick:(UIButton *)sender {
    
    if (self.player.playlist.count == 0) {
        [SVProgressHUD setMinimumDismissTimeInterval:1.8];
        [SVProgressHUD showErrorWithStatus:@"当前没有播放音乐!!!"];
        return;
    }
    
    
    LTLMainPlayController *MainPlay = [[LTLMainPlayController alloc]initWithNibName:@"LTLMainPlayController" bundle:nil];
    ///解决 Presenting view controllers on detached view controllers is discouraged 警告
    UIWindow *win = [UIApplication sharedApplication].keyWindow;

    [win.rootViewController presentViewController:MainPlay animated:YES completion:nil];
}
#pragma mark - 设置数据
-(void)setData
{
    XMTrack *Track = self.player.tracksVM;
    
    NSURL *url = [NSURL URLWithString:Track.coverUrlSmall];
    [self.songImage sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"9"]];
    self.songName.text = Track.trackTitle;
    self.SingerName.text = Track.announcer.nickname;
    
    if (self.player.playlist.count) {
        _musicToggleButton.enabled = YES;
        _NextHead.enabled = YES;
        _LastOne.enabled = YES;
    }
}

-(void)dealloc
{
    /// 关闭消息中心
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    LTLLog(@"LTLPlayControl销毁");
}
@end
