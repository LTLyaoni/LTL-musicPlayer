//
//  KPIndicatorView.m
//  Code4AppDemo
//
//  Created by kunpo on 16/3/18.
//  Copyright © 2016年 Eric Wang. All rights reserved.
//

#import "KPIndicatorView.h"
#import "RoundView.h"

@interface KPIndicatorView ()
///圆圈数量
@property(nonatomic,assign)CGFloat numOfMoveView;
///速度
@property(nonatomic,assign)CGFloat speed;
///大小
@property(nonatomic,assign)CGFloat moveViewSize;
///移动大小
@property(nonatomic,assign)CGFloat moveSize;
///w
@property(nonatomic,assign)CGFloat w;
///r
@property(nonatomic,assign)CGFloat r;

///视图数组
@property(nonatomic,strong) NSArray *arrayOfMoveView;
//定时器
@property (nonatomic,weak) NSTimer *animateTimer;

@end

@implementation KPIndicatorView
#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self settingDefault];
    }
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self=[super initWithCoder:aDecoder]) {
        [self settingDefault];
    }
    return self;
}

#pragma mark - 懒加载
-(UIImageView *)backImage
{
    if (!_backImage) {
        _backImage = [[UIImageView alloc]init];
        [self insertSubview:_backImage atIndex:0];
    }
    return _backImage;
}
///初始化设置默认属性
- (void)settingDefault
{
    //颜色
    _colorOfMoveView = [UIColor blueColor];
    //速度
    _speed = 0.6;
    ///数量
    _numOfMoveView = 8;
    //大小
    _moveViewSize = 1;
    
    _moveSize = 1;
    
    self.hidden = YES;
    [self initMoviews];
}


- (void)setIndicatorWith:(NSString *)image num:(int)num speed:(float)speed backGroundColor:(UIColor *)backColor color:(UIColor *)color moveViewSize:(float)moveViewSize moveSize:(float)moveSize
{
    if (image)
    {
        self.backImage.image = [UIImage imageNamed:image];
    }
    
    if (backColor) {
        self.backgroundColor = backColor;
    }
    _colorOfMoveView = [UIColor darkTextColor];
    if (color) {
        _colorOfMoveView = color;
    }
    _speed = 0.6;
    if (speed > 0) {
        _speed = speed;
    }
    _numOfMoveView = 12;
    if (num > _numOfMoveView) {
        _numOfMoveView = num;
    }
    _moveViewSize = 1;
    if ((moveViewSize > 0) &&(moveViewSize <= 1))
    {
        _moveViewSize = moveViewSize;
    }
    else if (moveSize < 0)
    {
        _moveViewSize = 0;
    }

    
    _moveSize = 1;
    if ((moveSize > 0) &&(moveSize <= 1))
    {
        _moveSize = moveSize;
    }
    else if (moveSize < 0)
    {
        _moveSize = 0;
    }
    
    
    self.hidden = YES;
    
    [self initMoviews];
}

-(void)setColorOfMoveView:(UIColor *)colorOfMoveView
{
    _colorOfMoveView = colorOfMoveView;
    
    [self initMoviews];
}

- (void)initMoviews
{
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    //半径
    float r = self.frame.size.width;
    if (r > self.frame.size.height) {
        r = self.frame.size.height;
    }
    r = r / 2.0;
    r = r * _moveSize;
    ///线性大小
    float w = r * sin(2 * M_PI / _numOfMoveView) / 2.0;
 
    r -= (w / 2.0);
    w = w * _moveViewSize;
    _r = r;
    _w = w;
    NSMutableArray *arr = [NSMutableArray new];
    
    float alpha = 1.0;
    ///添加圆圈
    for (int i = 1; i < _numOfMoveView +1; i ++)
    {
        
        w = _w * i / _numOfMoveView;
        ///大小
        CGRect rect = CGRectMake(0 ,0 , w, w);
        ///创建
        RoundView *view = [[RoundView alloc] initWithFrame:rect];

        view.radian = (M_PI * 2.0 / _numOfMoveView) * i;
        ///中心位置
        CGPoint center = CGPointMake(self.frame.size.width / 2.0 + _r * cos(view.radian),_r * sin(view.radian) + self.frame.size.height / 2.0);
        view.center = center;
        view.viewColor = _colorOfMoveView;
        view.backgroundColor = [UIColor clearColor];
        view.alpha = alpha * (_numOfMoveView -1) / _numOfMoveView;
        [self addSubview:view];
        [arr addObject:view];
    }
    _arrayOfMoveView = [arr copy];
}


-(void)startAnimating
{
    if (_animateTimer) {
        return;
    }
       _animateTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 / ( _numOfMoveView * _speed) target:self selector:@selector(next) userInfo:nil repeats:YES];
    
    self.hidden = NO;
}

-(void)stopAnimating
{
    if (_animateTimer) {
        [_animateTimer invalidate];
        _animateTimer = nil;
//        self.hidden = YES;
    }
}
///定时器方法
- (void)next
{
        for (int i = 1; i < _numOfMoveView +1; i ++)
        {
            [UIView animateWithDuration:0.1/ (_numOfMoveView * _speed) animations:^{
                
                RoundView *view = _arrayOfMoveView[i - 1];
                view.radian +=  M_PI_2 / (2.0 *_numOfMoveView);
                CGPoint center = CGPointMake(self.frame.size.width / 2.0 + _r * cos(view.radian),self.frame.size.height / 2.0 + _r * sin(view.radian));
                view.center = center;
               
            }];
        }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.backImage.frame = self.bounds;
}
@end
