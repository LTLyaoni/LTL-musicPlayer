//
//  LTLNavigationController.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/6.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLNavigationController.h"
#import "LTLPlayControl.h"

@interface LTLNavigationController ()<LTLPlayManagerDelegate>

@property (nonatomic,strong) LTLPlayControl *PlayControl;
@end

@implementation LTLNavigationController
//添加播放控制
-(LTLPlayControl *)PlayControl
{
    if (_PlayControl == nil ) {
        _PlayControl = [LTLPlayControl viewFromXib];
        //        _PlayControl.delegate = self;
        _PlayControl.y = LTL_WindowH - _PlayControl.highly;
    }
    return _PlayControl;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //添加播放控制条
    [self.view addSubview:self.PlayControl];
//    [self PlayControl];

}
#pragma mark - 视图出入设置
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [LTLPlayManager sharedInstance].delegate = self;
    
}
- (void)changeMusic
{
    [self.PlayControl setData];
}


@end
