//
//  LTLlistCell.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/12/7.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLlistCell.h"
#import "NAKPlaybackIndicatorView.h"

@interface LTLlistCell ()<SDKDownloadMgrDelegate>
///频谱
@property (weak, nonatomic) IBOutlet NAKPlaybackIndicatorView *spectrum;
///歌名
@property (weak, nonatomic) IBOutlet UILabel *songName;
///序号
@property (weak, nonatomic) IBOutlet UILabel *serialNumber;
///歌手
@property (weak, nonatomic) IBOutlet UILabel *singer;
///下载
@property (weak, nonatomic) IBOutlet UIButton *songDelete;
///下载管理
@property(nonatomic,strong) XMSDKDownloadManager *download;
@end

@implementation LTLlistCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.spectrum.color = [LTLThemeManager sharedManager].themeColor;
    [self.download getDownloadedTracks];
    
    
}

-(XMSDKDownloadManager *)download
{
    if (!_download) {
        _download = [XMSDKDownloadManager sharedSDKDownloadManager];
        
        [_download getDownloadedTracks];
        
        _download.sdkDownloadMgrDelegate = self;
    }
    return _download;
}


-(void)setTag:(NSInteger)tag
{
    [super setTag:tag];
    
    self.serialNumber.text = [NSString stringWithFormat:@"%ld",tag+1];
}

-(void)setData:(XMTrack *)data
{
    _data = data;
    self.songName.text = _data.trackTitle;
    self.singer.text = _data.announcer.nickname;
    
    
    TrackDownloadStatus *statu = [self.download getSingleTrackDownloadStatus:_data.trackId];
    if (statu) {
        [self.songDelete setTitle:@"已下载" forState:UIControlStateNormal];
        self.songDelete.enabled = NO;
    }
    

}
-(void)setState:(NAKPlaybackIndicatorViewState)state
{
    _state = state;
    self.serialNumber.hidden = state;
    self.spectrum.state = state;

}

- (IBAction)download:(UIButton *)sender
{
    int downloadState = [self.download downloadSingleTrack:self.data immediately:YES];
    
    LTLLog(@"%d",downloadState);
    
}
/**
 *   下载进度更新时被调用
 */
- (void)XMTrack:(XMTrack *)track updateDownloadedPercent:(double)downloadedPercent
{
    if (track.trackId == self.data.trackId) {
        
        LTLLog(@"LTL %f",downloadedPercent);
        
    }
    
}

/**
 *   下载完成时被调用
 */
- (void)XMTrackDownloadDidFinished:(XMTrack *)track
{
    if (track.trackId == self.data.trackId) {
        
        LTLLog(@"下载完成");
    }
    
}


@end
