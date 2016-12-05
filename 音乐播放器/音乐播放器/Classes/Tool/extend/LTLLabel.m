//
//  LTLLabel.m
//  代码修改
//
//  Created by LiTaiLiang on 16/12/4.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLLabel.h"
#import "UIColor+Separate.h"

@interface LTLLabel ()
{
    UIFont *_font;
}
///底
@property(nonatomic,strong)UILabel *bottomLabel;
///头
@property(nonatomic,strong)UILabel *topLabel;

@end

@implementation LTLLabel

-(NSTextAlignment)textAlignment
{
    if (!_textAlignment) {
        _textAlignment = NSTextAlignmentCenter;
    }
    return _textAlignment;
}


-(UIColor *)textColor
{
    if (!_textColor) {
        _textColor = [UIColor blackColor];
    }
    return _textColor;
}

-(UIFont *)font
{
    if (!_font) {
        _font = [UIFont systemFontOfSize:18];
    }
    return _font;
}

-(void)setFont:(UIFont *)font
{
    _font = font;
    self.topLabel.font = _font;
    self.bottomLabel.font = _font;
    
//    [self.topLabel sizeToFit];
//    [self.bottomLabel sizeToFit];
    [self layoutSubviews];
}

-(UILabel *)bottomLabel
{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]init];
        _bottomLabel.text = self.text;
        _bottomLabel.font = self.font;
        _bottomLabel.textColor = self.textColor;
        _bottomLabel.shadowColor = self.shadowColor;
        _bottomLabel.shadowOffset = self.shadowOffset;
        _bottomLabel.textAlignment = self.textAlignment;
        _bottomLabel.lineBreakMode = self.lineBreakMode;
        _bottomLabel.numberOfLines = self.numberOfLines;
        _bottomLabel.adjustsFontSizeToFitWidth = self.adjustsFontSizeToFitWidth;
        _bottomLabel.baselineAdjustment = self.baselineAdjustment;
        _bottomLabel.minimumScaleFactor = self.minimumScaleFactor;
        _bottomLabel.allowsDefaultTighteningForTruncation = self.allowsDefaultTighteningForTruncation;
        _bottomLabel.preferredMaxLayoutWidth = self.preferredMaxLayoutWidth;
        _bottomLabel.userInteractionEnabled = YES;
        
//        [self.layer insertSublayer:_bottomLabel.layer atIndex:0];
        [self insertSubview:_bottomLabel atIndex:0];
 
    }
    return _bottomLabel;
}

-(UILabel *)topLabel
{
    if (!_topLabel) {
        _topLabel = [[UILabel alloc]init];
        _topLabel.text = self.text;
        _topLabel.font = self.font;
        _topLabel.textColor = self.textColor;
        _topLabel.shadowColor = self.shadowColor;
        _topLabel.shadowOffset = self.shadowOffset;
        _topLabel.textAlignment = self.textAlignment;
        _topLabel.lineBreakMode = self.lineBreakMode;
        _topLabel.highlightedTextColor = self.highlightedTextColor;
        _topLabel.highlighted = YES ;
        _topLabel.numberOfLines = self.numberOfLines;
        _topLabel.adjustsFontSizeToFitWidth = self.adjustsFontSizeToFitWidth;
        _topLabel.baselineAdjustment = self.baselineAdjustment;
        _topLabel.minimumScaleFactor = self.minimumScaleFactor;
        _topLabel.allowsDefaultTighteningForTruncation = self.allowsDefaultTighteningForTruncation;
        _topLabel.preferredMaxLayoutWidth = self.preferredMaxLayoutWidth;
        _topLabel.userInteractionEnabled = YES;
        
//        [self.layer addSublayer:_topLabel.layer];
        [self addSubview:_topLabel];
    }
    return _topLabel;
}
-(void)setGradientDegree:(CGFloat)gradientDegree
{
    _gradientDegree = 1;
    if ((gradientDegree >= 0) &&(gradientDegree <= 1))
    {
        _gradientDegree = gradientDegree;
    }
    else if (gradientDegree < 0)
    {
        _gradientDegree = 0;
    }
    
    self.textColor = [self.textColor modifyAlpha:1-_gradientDegree];
    self.highlightedTextColor = [self.highlightedTextColor modifyAlpha:_gradientDegree];
    
    self.bottomLabel.textColor = self.textColor;
    self.topLabel.highlightedTextColor = self.highlightedTextColor;
}

-(void)layoutSubviews
{
    
    self.bottomLabel.frame = self.bounds;
    self.topLabel.frame = self.bounds;
    
    [self.topLabel sizeToFit];
    [self.bottomLabel sizeToFit];
    
    self.topLabel.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    self.bottomLabel.center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
    [super layoutSubviews];
}

@end
