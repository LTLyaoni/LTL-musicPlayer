//
//  LTLsongSheetCell.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/30.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLsongSheetCell.h"
#define jianXi  15

@interface LTLsongSheetCell ()

//图片高度
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconW;
//标题
@property (weak, nonatomic) IBOutlet UILabel *titer;

@property (weak, nonatomic) IBOutlet UILabel *playCont;
@end

@implementation LTLsongSheetCell

- (void)awakeFromNib
{
    [super awakeFromNib];
//    //图片高度
//    CGFloat h = (LTL_WindowW-30-2*jianXi)/3;
//    self.iconW.constant = h;
}

-(void)setModel:(XMAlbum *)model
{
    _model = model;
    //图片
    NSURL *url = [NSURL URLWithString:_model.coverUrlLarge];
    //设置图片
    [self.icon sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"LTL"]];
    //歌单标题
    self.titer.text = _model.albumTitle;
    //歌单播放量
    self.playCont.text = _model.playNumber;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.iconW.constant = self.width;
}

@end
