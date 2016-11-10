//
//  LTLMainPlayController.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/3.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLMainPlayController.h"
#import "MusicSlider.h"

@interface LTLMainPlayController ()<UIGestureRecognizerDelegate,LTLPlayManagerDelegate>
/*背景*/
@property (weak, nonatomic) IBOutlet UIImageView *backgroudImageView;

@property (weak, nonatomic) IBOutlet UIView *backgroudView;

/*最上行*/
///歌单名
@property (weak, nonatomic) IBOutlet UILabel *musicTitleLabel;
///菜单按钮
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

/*中心图片*/
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *albumImageLeftConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *albumImageRightConstraint;

/*收藏行*/
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
///歌名
@property (weak, nonatomic) IBOutlet UILabel *musicNameLabel;
///歌手
@property (weak, nonatomic) IBOutlet UILabel *singerLabel;

/*进度条*/
//播放时间
@property (weak, nonatomic) IBOutlet UILabel *beginTimeLabel;
///歌长
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
///进度条
@property (weak, nonatomic) IBOutlet MusicSlider *musicSlider;

/*最下行按钮*/
///播放模式
@property (weak, nonatomic) IBOutlet UIButton *musicCycleButton;
///下一首
@property (weak, nonatomic) IBOutlet UIButton *previousMusicButton;
///播放
@property (weak, nonatomic) IBOutlet UIButton *musicToggleButton;
///下一首
@property (weak, nonatomic) IBOutlet UIButton *nextMusicButton;
///更多
@property (weak, nonatomic) IBOutlet UIButton *otherButton;
///播放器
@property (nonatomic,strong) LTLPlayManager *player;
///为musicSlider添加点击
@property (nonatomic,strong) UITapGestureRecognizer *tapGesture;
///音乐变化
@property (nonatomic) BOOL musicIsChange;
///是否播放
@property (nonatomic) BOOL musicIsPlaying;
///模式
@property (nonatomic) LTLPlayerCycle  cycle;
///加载进度条
@property (weak, nonatomic) IBOutlet UIProgressView *progressBar;

@end

@implementation LTLMainPlayController

-(LTLPlayManager *)player
{
    if (_player == nil) {
        _player = [LTLPlayManager sharedInstance];
        _player.delegate = self;
    }
    return _player;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    ///////////设置模式图片
    _cycle = self.player.playerCycle;
    [self setTouchCycle];
    //////////设置播放按钮
    self.musicIsPlaying = _player.isPlay;
    _progressBar.progress = _player.playBuffer;
    _musicSlider.value = _player.playPercent;
    [self setData];
    _musicIsChange = YES;
    _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapGesture:)];
    _tapGesture.delegate = self;
    [_musicSlider addGestureRecognizer:_tapGesture];
}
#pragma mark - FYPlayManagerDelegate
///每次下一首的时候将会调用
-(void)changeMusic
{
    self.musicIsPlaying = _player.isPlay;
    [self setData];
}
///播放时被调用，频率为1s，告知当前播放进度和播放时间
-(void)playNotifyProcess:(CGFloat)percent currentSecond:(NSString *)currentSecond
{
    if (_musicIsChange) {
        _musicSlider.value = percent;
    }
    _beginTimeLabel.text = currentSecond;
}
///缓冲
-(void)playBufferProcess:(CGFloat)percent
{
    self.progressBar.progress = percent;
}
#pragma mark - 设置数据
-(void)setData
{
    XMTrack *Track = self.player.tracksVM;
    NSURL *url = [NSURL URLWithString:Track.coverUrlMiddle];
    [self.albumImageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"9"]];
    [self.backgroudImageView sd_setImageWithURL:url];
    self.musicNameLabel.text = Track.trackTitle;
    self.singerLabel.text = Track.announcer.nickname;
    self.endTimeLabel.text = Track.playTime;
}
#pragma mark - 点击事件
- (void)setMusicIsPlaying:(BOOL)musicIsPlaying {
    _musicIsPlaying = musicIsPlaying;
    if (_musicIsPlaying) {
        [_musicToggleButton setImage:[UIImage imageNamed:@"big_pause_button"] forState:UIControlStateNormal];
        
    } else {
        [_musicToggleButton setImage:[UIImage imageNamed:@"big_play_button"] forState:UIControlStateNormal];
    }
}
/** 播放按钮 */
- (IBAction)didTouchMusicToggleButton:(UIButton *)sender {
    NSLog(@"播放或暂停");
    NSLog(@"%d",_player.isPlay);
    if (_player.status ==  AVPlayerStatusReadyToPlay) {
        
        [_player pauseMusic];
        
        self.musicIsPlaying = _player.isPlay;
        
    }else{
        NSLog(@"当前没有音乐") ;
    }
}
///上一首
- (IBAction)playPreviousMusic:(UIButton *)sender {
    if (_player.status ==  AVPlayerStatusReadyToPlay) {
        [_player previousMusic];
        self.musicIsPlaying = _player.isPlay;
        
    }else{
         NSLog(@"等待加载音乐");
    }
    
}
///下一首
- (IBAction)playNextMusic:(UIButton *)sender {
    if (_player.status ==  AVPlayerStatusReadyToPlay) {
        
        [_player nextMusic];
        
        self.musicIsPlaying = _player.isPlay;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"setPausePlayView" object:nil userInfo:nil];
        
    }else{
//        [self showMiddleHint:@"等待加载音乐"];
        NSLog(@"等待加载音乐");
    }
   
}

///播放模式
- (IBAction)didTouchCycle:( UIButton *)sender {
    if (_cycle < isRandom) {
        _cycle++;
    }else{
        _cycle = theSong ;
    }
    [_player nextCycle:_cycle];
    [self setTouchCycle];
}
///设置播放模式按钮图片
-(void)setTouchCycle
{

    switch (_cycle) {
        case  theSong:
            [_musicCycleButton setImage:[UIImage imageNamed:@"loop_single_icon"] forState:UIControlStateNormal];
//            [self showMiddleHint:@"单曲循环"];
            break;
        case nextSong:
            [_musicCycleButton setImage:[UIImage imageNamed:@"loop_all_icon"] forState:UIControlStateNormal];
//            [self showMiddleHint:@"顺序循环"];
            break;
        case isRandom:
            [_musicCycleButton setImage:[UIImage imageNamed:@"shuffle_icon"] forState:UIControlStateNormal];
//            [self showMiddleHint:@"随机循环"];
            break;

    }

}
- (IBAction)idiTouchFavorite:(id)sender {
    
    [_favoriteButton startDuangAnimation];
   
}
/** 更多按钮 */
- (IBAction)didTouchMoreButton:(id)sender {

}


- (IBAction)closePlay:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//拖动条
- (IBAction)changeMusicTime:(MusicSlider *)sender {
    _musicIsChange = NO;
    _tapGesture.enabled = NO;
    NSLog(@"1");
}
- (IBAction)setMusicTime:(MusicSlider *)sender {
    _tapGesture.enabled = YES;
    _musicIsChange = YES;
    NSLog(@"2");
    [_player seekToTime:sender.value];

}
- (void)actionTapGesture:(UITapGestureRecognizer *)sender {
    CGPoint touchPoint = [sender locationInView:_musicSlider];
    //求百分比
    CGFloat value = (_musicSlider.maximumValue - _musicSlider.minimumValue) * (touchPoint.x / _musicSlider.frame.size.width );
    //设置
    [_musicSlider setValue:value animated:YES];

    [_player seekToTime:value];
}
#pragma mark - 视图出入设置
//即将消失,取消代理
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.player .delegate = nil;
}

-(void)dealloc
{
    NSLog(@"LTLMainPlayController销毁");
}


@end
