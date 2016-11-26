//
//  LTLMoreSongsCell.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/23.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLMoreSongsCell.h"

@interface LTLMoreSongsCell ()
//头像
@property (weak, nonatomic) IBOutlet UIImageView *icon;
//专辑名
@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *xiaingqing;
/** 播放次数标签 */
@property (weak, nonatomic) IBOutlet UILabel *playCountLb;
//专辑歌数
@property (weak, nonatomic) IBOutlet UILabel *songNum;


@end

@implementation LTLMoreSongsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //设置cell被选中后的背景色
    UIView *view=[UIView new];
    view.backgroundColor=LTL_RGBColor(243, 255, 254);
    self.selectedBackgroundView=view;
    //分割线距离左侧空间
    self.separatorInset=UIEdgeInsetsMake(0, 76, 0, 0);
}

-(void)setModel:(XMAlbum *)model
{
    _model = model;

    NSURL *url = [NSURL URLWithString:_model.coverUrlLarge];
    [_icon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"LTL"]];
    
    _name.text = _model.albumTitle;
    _xiaingqing.text = _model.albumIntro;
    _playCountLb.text = _model.PlayNumber;
    _songNum.text = [NSString stringWithFormat:@"%ld集",_model.includeTrackCount];
}

@end
