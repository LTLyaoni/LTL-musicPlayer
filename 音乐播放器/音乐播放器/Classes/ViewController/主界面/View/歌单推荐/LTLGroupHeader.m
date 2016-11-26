//
//  LTLGroupHeader.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/12.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLGroupHeader.h"
#import "LTLMoreSongs.h"

@interface LTLGroupHeader ()
///组标题
@property (weak, nonatomic) IBOutlet UILabel *GroupHeader;

@end

@implementation LTLGroupHeader

- (IBAction)More:(UIButton *)sender {
    
    LTLMoreSongs *MoreSongs = [[LTLMoreSongs alloc]init];
    
    MoreSongs.model = _model;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"pushView"] = MoreSongs;
    dic[@"toView"] = self;
    dic[@"isAnimate"] = 0;
    ///发送播放通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pushView" object:nil userInfo:[dic copy]];
}

-(void)setModel:(LTLRecommendAlbums *)model
{
    _model = model;
    
    _GroupHeader.text = _model.display_tag_name;
    
}



@end
