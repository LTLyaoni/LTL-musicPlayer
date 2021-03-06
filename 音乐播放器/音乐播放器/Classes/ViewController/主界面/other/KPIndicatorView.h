//
//  KPIndicatorView.h
//  Code4AppDemo
//
//  Created by kunpo on 16/3/18.
//  Copyright © 2016年 Eric Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KPIndicatorView : UIView

@property (strong, nonatomic) UIImageView *backImage;
///颜色
@property(nonatomic,weak) UIColor *colorOfMoveView;

//* 背景图片，可以为空；小点的个数，最小为12否则无效；转动速度，大于0；背景颜色；小点的背景颜色；小点的大小，0-1;运动半径，0-1*/
- (void)setIndicatorWith:(NSString *)image num:(int)num speed:(float)speed backGroundColor:(UIColor *)backColor color:(UIColor *)color moveViewSize:(float)moveViewSize moveSize:(float)moveSize;
-(void)startAnimating;
-(void)stopAnimating;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
