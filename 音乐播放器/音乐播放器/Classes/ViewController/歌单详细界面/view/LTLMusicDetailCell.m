//
//  LTLMusicDetailCell.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/30.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLMusicDetailCell.h"

@interface LTLMusicDetailCell ()
/** 音乐封面图 */
@property(nonatomic,strong) UIImageView *coverIV;
/** 题目标签 */
@property (nonatomic,strong) UILabel *titleLb;
/** 添加时间标签 */
@property(nonatomic,strong) UILabel *updateTimeLb;
/** 音乐来源标签 */
@property(nonatomic,strong) UILabel *sourceLb;
/** 播放次数标签 */
@property(nonatomic,strong) UILabel *playCountLb;
/** 喜欢次数标签 */
@property(nonatomic,strong) UILabel *favorCountLb;
/** 评论次数标签 */
@property(nonatomic,strong) UILabel *commentCountLb;
/** 时长标签 */
@property(nonatomic,strong) UILabel *durationLb;
/** 下载按钮 */
@property(nonatomic,strong) UIButton *downloadBtn;

@end

@implementation LTLMusicDetailCell
#pragma mark - 控件懒加载
/** 音乐封面图 */
- (UIImageView *)coverIV {
    if(_coverIV == nil) {
        _coverIV = [[UIImageView alloc] init];
        ///添加到contentView
        [self.contentView addSubview:_coverIV];
        [_coverIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(50, 50));
            make.centerY.mas_equalTo(0);
            make.left.mas_equalTo(10);
        }];
        //开启圆形
        _coverIV.layer.cornerRadius=50/2;
        //内容和子视图剪到视图的边界
        _coverIV.clipsToBounds = YES;
        //添加播放标识
        UIImageView *playIV=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"find_album_play"]];
        [_coverIV addSubview:playIV];
        [playIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(25, 25));
            make.center.mas_equalTo(0);
        }];
    }
    return _coverIV;
}
/** 歌名 */
- (UILabel *)titleLb {
    if(_titleLb == nil) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.coverIV.mas_right).mas_equalTo(10);
            make.top.mas_equalTo(10);
            make.width.width.mas_equalTo(200);
        }];
        _titleLb.numberOfLines = 0;
    }
    return _titleLb;
}
/** 添加时间标签 */
- (UILabel *)updateTimeLb {
    if(_updateTimeLb == nil) {
        _updateTimeLb = [[UILabel alloc] init];
        [self.contentView addSubview:_updateTimeLb];
        //字体大小
        _updateTimeLb.font=[UIFont systemFontOfSize:12];
        //颜色
        _updateTimeLb.textColor=[UIColor lightGrayColor];
        [_updateTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(20);
            make.right.equalTo(self.mas_right).offset(-10);
            make.width.mas_equalTo(90);
        }];
        //对其方式
        _updateTimeLb.textAlignment=NSTextAlignmentRight;
    }
    return _updateTimeLb;
}
/** 音乐来源标签 */
- (UILabel *)sourceLb {
    if(_sourceLb == nil) {
        _sourceLb = [[UILabel alloc] init];
        [self.contentView addSubview:_sourceLb];
        [_sourceLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leftMargin.mas_equalTo(self.titleLb.mas_leftMargin);
            make.top.mas_equalTo(self.titleLb.mas_bottom).mas_equalTo(4);
            make.rightMargin.mas_equalTo(self.titleLb.mas_rightMargin);
        }];
        //字体大小
        _sourceLb.font=[UIFont systemFontOfSize:12];
        //颜色
        _sourceLb.textColor=[UIColor lightGrayColor];
    }
    return _sourceLb;
}
/** 播放次数标签 */
- (UILabel *)playCountLb {
    if(_playCountLb == nil) {
        _playCountLb = [[UILabel alloc] init];
        [self.contentView addSubview:_playCountLb];
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sound_play"]];
        [self.contentView addSubview:imageView];
        ////位置
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(10, 10));
            make.leftMargin.mas_equalTo(self.sourceLb.mas_leftMargin);
            make.bottom.mas_equalTo(-10);
            make.top.mas_equalTo(self.sourceLb.mas_bottom).mas_equalTo(8);
        }];
        //位置
        [_playCountLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(imageView);
            make.left.mas_equalTo(imageView.mas_right).mas_equalTo(3);
        }];
        //颜色
        _playCountLb.textColor=[UIColor lightGrayColor];
        //字体大小
        _playCountLb.font=[UIFont systemFontOfSize:10];
    }
    return _playCountLb;
}
/** 喜欢次数标签 */
- (UILabel *)favorCountLb {
    if(_favorCountLb == nil) {
        _favorCountLb = [[UILabel alloc] init];
        [self.contentView addSubview:_favorCountLb];
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sound_likes_n"]];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.playCountLb);
            make.left.mas_equalTo(self.playCountLb.mas_right).mas_equalTo(7);
            make.size.mas_equalTo(CGSizeMake(10, 10));
        }];
        _favorCountLb.textColor=[UIColor lightGrayColor];
        _favorCountLb.font=[UIFont systemFontOfSize:10];
        [_favorCountLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageView.mas_right).mas_equalTo(3);
            make.centerY.mas_equalTo(imageView);
        }];
    }
    return _favorCountLb;
}
/** 评论次数标签 */
- (UILabel *)commentCountLb {
    if(_commentCountLb == nil) {
        _commentCountLb = [[UILabel alloc] init];
        [self.contentView addSubview:_commentCountLb];
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sound_comments"]];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(10, 10));
            make.left.mas_equalTo(self.favorCountLb.mas_right).mas_equalTo(7);
            make.centerY.mas_equalTo(self.favorCountLb);
        }];
        [_commentCountLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(imageView);
            make.left.mas_equalTo(imageView.mas_right).mas_equalTo(3);
        }];
        _commentCountLb.textColor=[UIColor lightGrayColor];
        _commentCountLb.font=[UIFont systemFontOfSize:10];
    }
    return _commentCountLb;
}
/** 时长标签 */
- (UILabel *)durationLb {
    if(_durationLb == nil) {
        _durationLb = [[UILabel alloc] init];
        [self.contentView addSubview:_durationLb];
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sound_duration"]];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.commentCountLb.mas_right).mas_equalTo(7);
            make.centerY.mas_equalTo(self.commentCountLb);
            make.size.mas_equalTo(CGSizeMake(10, 10));
        }];
        [_durationLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(imageView.mas_right).mas_equalTo(3);
            make.centerY.mas_equalTo(imageView);
        }];
        _durationLb.font=[UIFont systemFontOfSize:10];
        _durationLb.textColor=[UIColor lightGrayColor];
    }
    return _durationLb;
}
/** 下载按钮 */
- (UIButton *)downloadBtn {
    if(_downloadBtn == nil) {
        _downloadBtn = [[UIButton alloc]init];
        _downloadBtn.backgroundColor = [UIColor blueColor];
        [_downloadBtn setBackgroundImage:[UIImage imageNamed:@"cell_download"] forState:UIControlStateNormal];
        [self.contentView addSubview:_downloadBtn];
        [_downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.mas_equalTo(-5);
            make.size.mas_equalTo(CGSizeMake(25, 25));
        }];
    }
    return _downloadBtn;
}
#pragma mark - cell 初始化
//cell 初始化
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //为了触发下载按钮的懒加载
        self.downloadBtn.hidden = NO;
//        self.contentView.backgroundColor = [UIColor blueColor];
        //设置cell被选中后的背景色
        UIView *view=[UIView new];
        view.backgroundColor=s_RGBColor(243, 255, 254);
        self.selectedBackgroundView=view;
        //分割线距离左侧空间
        self.separatorInset=UIEdgeInsetsMake(0, 76, 0, 0);
    }
    return self;
}
#pragma mark - 数据处理
///数据处理
-(void)setTrackData:(XMTrack *)TrackData
{
    _TrackData = TrackData;
    NSURL *url = [NSURL URLWithString:_TrackData.coverUrlMiddle];
    [self.coverIV sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"LTL"]];
    self.titleLb.text = _TrackData.trackTitle;
    self.sourceLb.text = _TrackData.announcer.nickname;
    self.playCountLb.text = _TrackData.PlayNumber;
    self.updateTimeLb.text = _TrackData.AddTime;
    self.favorCountLb.text = [NSString stringWithFormat:@"%ld",_TrackData.favoriteCount];
    self.commentCountLb.text = [NSString stringWithFormat:@"%ld",_TrackData.commentCount];
    self.durationLb.text = _TrackData.playTime;
    
}

@end
