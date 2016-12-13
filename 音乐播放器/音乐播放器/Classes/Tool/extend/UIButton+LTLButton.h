//
//  UIButton+LTLButton.h
//  代码修改
//
//  Created by LiTaiLiang on 16/12/4.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTLLabel.h"
@interface UIButton (LTLButton)
///渐变程度  0~1 之间
@property (nonatomic,assign) CGFloat gradientDegree;
///渐变文本
@property(nonatomic,strong,readonly) LTLLabel* LTLlabel;
///是否进行渐变文本
@property (nonatomic,assign , getter=isGradient) BOOL gradient;

@property (nonatomic,weak) UIFont *gradientFont;

///是否进行高亮渐变文本
@property (nonatomic,assign , getter=isHighlightedText) BOOL highlightedText;

@end
