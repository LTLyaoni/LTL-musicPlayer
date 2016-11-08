//
//  LTLHeaderView.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/30.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//
#import "LTLHeaderView.h"

#import "LTLPicView.h"
#import "LTLIconNameView.h"
#import "LTLDescView.h"

@interface LTLHeaderView ()


/// 头像旁边标题(与头部视图text相等)
@property (nonatomic,strong) UILabel *smallTitle;
/// 背景图 和 方向图
@property (nonatomic,strong) PicView *picView;
/// 自定义头像按钮
@property (nonatomic,strong) IconNameView *nameView;
/// 自定义描述按钮
@property (nonatomic,strong) DescView *descView;

//@property (nonatomic,strong) UIButton *topLeftBtn;
//@property (nonatomic,strong) UIButton *topRightBtn;
@property (strong, nonatomic) UIVisualEffectView *visualEffectView;

@end

@implementation LTLHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 打开用户交互
        self.userInteractionEnabled = YES;
//        self.image = [UIImage imageNamed:@"bg_albumView_header"];
        //毛玻璃效果
        //(isDescendantOfView的作用)返回一个布尔值指出接收者是否是给定视图的子视图或者指向那个视图
        if(![_visualEffectView isDescendantOfView:self]) {
            UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            //毛玻璃
            _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
            _visualEffectView.frame = CGRectMake(0, 0, LTL_WindowW, frame.size.height+20);
            [self addSubview:_visualEffectView];
        }
        //打开详情图
        self.descView.hidden = NO;
    }
    return self;
}
#pragma mark - 设置数据
-(void)setXMAlbumModel:(XMAlbum *)XMAlbumModel
{
    _XMAlbumModel = XMAlbumModel;
    //图片
    NSURL *url = [NSURL URLWithString:_XMAlbumModel.coverUrlMiddle];
    //设置歌单图片
    [self sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"LTL"]];
    //模糊背景
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

- (void)setVisualEffectFrame:(CGRect)visualEffectFrame{

    CGFloat height = visualEffectFrame.size.height;
    _visualEffectView.frame = CGRectMake(0, 0, LTL_WindowW, height);
}

#pragma mark - 各个控件的懒加载
//歌单图片
- (PicView *)picView {
    if (!_picView) {
        _picView = [PicView new];
        [self addSubview:_picView];
        [_picView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 100));
            make.left.mas_equalTo(20);
            make.top.mas_equalTo(self.mas_top).mas_equalTo(88);
        }];
    }
    return _picView;
}
//// 自定义头像按钮
- (IconNameView *)nameView {
    if (!_nameView) {
        _nameView = [IconNameView new];
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
