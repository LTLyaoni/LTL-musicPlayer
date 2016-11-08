//
//  LTLDescView.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/30.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLDescView.h"

@implementation DescView

- (instancetype)init {
    if (self = [super init]) {
        self.jianTou.hidden = NO;
//        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

- (UILabel *)descLb {
    if (!_descLb) {
        _descLb = [UILabel new];
        [self addSubview:_descLb];
        [_descLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.top.equalTo(self.mas_top);
            // 适配最大宽度, 不然4S适配会超出屏幕
            make.width.mas_lessThanOrEqualTo(LTL_WindowW/2);
        }];
        _descLb.numberOfLines = 3;
        _descLb.textColor = [UIColor blackColor];
        _descLb.font = [UIFont systemFontOfSize:13];
    }
    return _descLb;
}

- (UIImageView *)jianTou {
    if (!_jianTou) {
        _jianTou = [UIImageView new];
        [self addSubview:_jianTou];
        [_jianTou mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.descLb.mas_right);
            make.centerY.mas_equalTo(self.descLb);
            make.size.mas_equalTo(CGSizeMake(10, 15));
        }];
        _jianTou.image = [UIImage imageNamed:@"findcell_arrow"];
    }
    return _jianTou;
}

@end
