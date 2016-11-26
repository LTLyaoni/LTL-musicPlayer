//
//  LTLHeaderView.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/30.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//
#import "LTLHeaderView.h"
#import "LTLDescView.h"
#import "LTLButtonBorder.h"
#import "LTLIconNameView.h"
@interface LTLHeaderView ()


/// 头像旁边标题(与头部视图text相等)
@property (nonatomic,strong) UILabel *smallTitle;
/// 自定义描述按钮
@property (nonatomic,strong) DescView *descView;
/// 自定义头像按钮
@property (nonatomic,strong) LTLIconNameView *nameView;

@property (strong, nonatomic) UIVisualEffectView *visualEffectView;
//播放全部
@property (nonatomic,strong) UIButton *playAll;
//播放全部
@property (nonatomic,strong) UIButton *downloadAll;

@end

@implementation LTLHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 打开用户交互
        self.userInteractionEnabled = YES;
        self.contentMode=UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
//        self.image = [UIImage imageNamed:@"bg_albumView_header"];
        //毛玻璃效果
        //(isDescendantOfView的作用)返回一个布尔值指出接收者是否是给定视图的子视图或者指向那个视图
        if(![_visualEffectView isDescendantOfView:self]) {
            UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            //毛玻璃
            _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            [self addSubview:_visualEffectView];
        }
        //打开详情图
        self.descView.hidden = NO;
        
        [self.playAll addTarget:self action:@selector(playAllSong:) forControlEvents:UIControlEventTouchUpInside];
        [self.downloadAll addTarget:self action:@selector(downloadAllSong:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
///播放全部歌曲
-(void)playAllSong:(UIButton *)btn
{
    //全部播放
    NSLog(@"播放全部歌曲");
}
///下载全部歌曲
-(void)downloadAllSong:(UIButton *)btn
{
    //下载全部歌曲
    NSLog(@"下载全部歌曲");
}
#pragma mark - 设置数据
-(void)setXMAlbumModel:(XMAlbum *)XMAlbumModel
{
    _XMAlbumModel = XMAlbumModel;
    //图片
    NSURL *url = [NSURL URLWithString:_XMAlbumModel.coverUrlLarge];
   
    //模糊背景
    [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"LTL"]];
    //设置歌单图片
    [self.picView.coverView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"LTL"]];
    ///播放次数
    [self.picView.playCountBtn setTitle:_XMAlbumModel.PlayNumber forState:UIControlStateNormal];
    ///简介
    self.descView.descLb.text = _XMAlbumModel.albumIntro;
    //名字
    self.nameView.name.text = _XMAlbumModel.announcer.nickname;
    //标签
    [self setupTagsBtnWithTagNames:_XMAlbumModel.MusicLabel];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _visualEffectView.frame = self.bounds;

}
#pragma mark - 各个控件的懒加载
//播放全部按钮
-(UIButton *)playAll
{
    if (!_playAll) {
        _playAll = [[UIButton alloc]init];
        UIImage *PlayAllImage = [LTLButtonBorder imageOfArtboard];
        
        [_playAll setBackgroundImage:PlayAllImage forState:UIControlStateNormal];
        
        [_playAll setTitle:@"播放全部" forState:UIControlStateNormal];
        
        [_playAll setTitleColor:[LTLThemeManager sharedManager].themeColor forState:UIControlStateNormal];
        _playAll.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_playAll];
        
        [_playAll mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.picView.mas_bottom).offset(5);
            make.left.equalTo(self.picView.mas_left).offset(5);
            make.size.mas_equalTo(CGSizeMake(150, 36));
        }];
    }
    return _playAll;
}
-(UIButton *)downloadAll
{
    if (!_downloadAll) {
        _downloadAll = [[UIButton alloc]init];
        UIImage *PlayAllImage = [LTLButtonBorder imageOfArtboard];
        
        [_downloadAll setBackgroundImage:PlayAllImage forState:UIControlStateNormal];
        
        [_downloadAll setTitle:@"下载全部" forState:UIControlStateNormal];
        
        [_downloadAll setTitleColor:[LTLThemeManager sharedManager].themeColor forState:UIControlStateNormal];
         _downloadAll.titleLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_downloadAll];
        
        [_downloadAll mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.picView.mas_bottom).offset(5);
            make.right.equalTo(self.mas_right).offset(-25);
            make.size.mas_equalTo(CGSizeMake(150, 36));
        }];
    }
    return _downloadAll;
}
//歌单图片
- (PicView *)picView {
    if (!_picView) {
        _picView = [[PicView alloc]initWithFrame:CGRectMake(20, 75, 100, 100)];
        [self addSubview:_picView];
    }
    return _picView;
}
//// 自定义头像按钮
- (LTLIconNameView *)nameView {
    if (!_nameView) {
        _nameView = [LTLIconNameView new];
        [self addSubview:_nameView];
        [_nameView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.topMargin.mas_equalTo(self.picView);
            make.left.mas_equalTo(self.picView.mas_right).mas_equalTo(10);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(30);
        }];
        
    }
    return _nameView;
}
/// 自定义简介描述按钮
- (DescView *)descView {
    if (!_descView) {
        _descView = [DescView new];
        [self addSubview:_descView];
        [_descView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.picView);
            make.leadingMargin.mas_equalTo(self.nameView);
            // 可能根据字体来设置
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(30);
        }];
        _descView.descLb.text = @"暂无简介";
    }
    return _descView;
}

/** 根据标签数组, 设置按钮标签 */
- (void)setupTagsBtnWithTagNames:(NSArray *)tagNames {
    // 记录最后一个视图控件
    UIView *lastView = nil;
    // 创建标签按钮
    // 首页只展示两个标签按钮 所以要判断个数
    // 记录个数, 最高展示就两个
    NSInteger maxTags = 2;
    if (tagNames.count < 2) {
        maxTags = tagNames.count;
    }
    for (NSInteger i = 0; i<maxTags; i++) {
        UIButton *tagBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:tagBtn];
        // 按钮根据按钮上文字自适应大小,NSFontAttributeName 要和按钮titleLabel的font对应
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        CGFloat length = [tagNames[i] boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:attributes context:nil].size.width;
        [tagBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.picView.mas_bottom).offset(5);
            // 文字大小
            make.size.mas_equalTo(CGSizeMake(length+20, 25));
            if (lastView) {  // 存在
                make.left.mas_equalTo(lastView.mas_right).mas_equalTo(5);
            } else {  // 刚开始创建, 按钮的位置
                make.leadingMargin.mas_equalTo(self.descView);
            }
        }];
        // 赋值标签按钮指针
        lastView = tagBtn;
        // 设置按钮的属性
        [tagBtn setTitle:tagNames[i] forState:UIControlStateNormal];
        tagBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        // 76*50 背景图
        [tagBtn setBackgroundImage:[UIImage imageNamed:@"sound_tags"] forState:UIControlStateNormal];
    }
}

@end
