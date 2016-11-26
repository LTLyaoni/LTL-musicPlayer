//
//  LTLCategoryTableCell.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/21.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//


#import "LTLCategoryTableCell.h"

@interface LTLCategoryTableCell ()

@property (nonatomic,strong) UIImageView *arrow;
@property (strong, nonatomic) UIVisualEffectView *visualEffectView;
@property (nonatomic, strong) UILongPressGestureRecognizer *pressRecognizer;

@property (nonatomic,strong) NSMutableArray <NSDictionary *> *categoryArray;
/**  标题 */
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) UILabel *titleLb;

@end

@implementation LTLCategoryTableCell
-(NSMutableArray<NSDictionary *> *)categoryArray
{
    if (!_categoryArray) {
        
        NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"categoryData" ofType:@"plist"];
        _categoryArray = [[NSMutableArray alloc]initWithContentsOfFile:plistPath];
    }
    return _categoryArray;
}
#pragma mark - 初始化
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 分割线缩短
        self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return self;
}
#pragma mark - 懒加载
-(UILabel *)titleLb
{
    if (!_titleLb) {
        //标题
        _titleLb = [[UILabel alloc] init];
        //titleLabel.font = [UIFont systemFontOfSize:30];
        _titleLb.font = [UIFont fontWithName:@"AmericanTypewriter" size:30];
        _titleLb.text = _title;
        [self.arrow addSubview:_titleLb];
        [_titleLb mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.arrow.mas_left).offset(12);
            make.bottom.equalTo(self.arrow.mas_bottom).offset(-12);
            make.width.mas_equalTo(180);
        }];
    }
    return _titleLb;
}

- (UIImageView *)arrow
{
    if (!_arrow) {
        _arrow = [[UIImageView alloc] init];
        [self.contentView addSubview:_arrow];
        [_arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top);
            make.left.equalTo(self.mas_left);
//            make.bottom.equalTo(self.mas_bottom);
            make.right.equalTo(self.mas_right);
            make.height.mas_equalTo(self.width *2/5);
        }];
        
        //下背景图片
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:@"album_album_mask"];
        [_arrow addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.arrow.mas_top);
            make.left.equalTo(self.arrow.mas_left);
            make.bottom.equalTo(self.arrow.mas_bottom);
            make.right.equalTo(self.arrow.mas_right);
        }];
        
        /* 长按手势来形成按钮效果 */
        self.pressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        //最短长按时间
        self.pressRecognizer.minimumPressDuration = 0.2;
        //代理
        self.pressRecognizer.delegate = self;
        /**  默认为YES,这种情况下当手势识别器识别到touch之后，会发送touchesCancelled给hit-testview以取消hit-test view对touch的响应，这个时候只有手势识别器响应touch。
            当设置成NO时，手势识别器识别到touch之后不会发送touchesCancelled给hit-test，这个时候手势识别器和hit-test view均响应touch。
         */
        self.pressRecognizer.cancelsTouchesInView = NO;
        
        [self addGestureRecognizer:self.pressRecognizer];
    }
    return _arrow;
}
///返回yes，同时允许两个手势识别。
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    
    return YES;
}
///手势方法
-(void)longPress:(UITapGestureRecognizer *)sender{
    
    if (sender.state == UIGestureRecognizerStateBegan){

        if(![_visualEffectView isDescendantOfView:self]) {
            UIVisualEffect *blurEffect;
            blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
            _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
//            _visualEffectView.frame = CGRectMake(0, 0, LTL_WindowW, LTL_WindowW*0.4);
            [self.contentView addSubview:_visualEffectView];
            [_visualEffectView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.arrow.mas_top);
                make.left.equalTo(self.arrow.mas_left);
                make.bottom.equalTo(self.arrow.mas_bottom);
                make.right.equalTo(self.arrow.mas_right);
            }];
            //标题
            UILabel *titleLabel = [[UILabel alloc] init];
            titleLabel.font = [UIFont fontWithName:@"AmericanTypewriter" size:36];
            titleLabel.text = _title;
            [titleLabel sizeToFit];
            titleLabel.textColor = [UIColor whiteColor];
            [_visualEffectView addSubview:titleLabel];
            [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(_visualEffectView.mas_left).offset(12);
                make.bottom.equalTo(_visualEffectView.mas_bottom).offset(-12);
                make.width.mas_equalTo(180);
//                make.height.mas_equalTo(36);
            }];

        }
    }else if (sender.state == UIGestureRecognizerStateEnded){
        [_visualEffectView removeFromSuperview];
    }
    
}

-(void)setSongTag:(XMTag *)songTag
{
    _songTag = songTag;
    [self.categoryArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([_songTag.tagName isEqualToString:obj[@"title"]])
        {
            self.arrow.image = [UIImage imageNamed:obj[@"image"]];
            *stop = YES;
        }
        else
        {
            self.arrow.image = [UIImage imageNamed:@"music_dan"];
            
        }
    }];
    self.title = _songTag.tagName;
    self.titleLb.text = _songTag.tagName;
    [self.titleLb setTextColor:[UIColor whiteColor]];
    
    self.backgroundColor = [UIColor whiteColor];

}
@end
