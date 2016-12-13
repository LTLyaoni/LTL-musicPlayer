//
//  LTLGroupHeader.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/12.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLGroupHeader.h"
#import "LTLMoreSongs.h"
#import "LTLHeadIcon.h"

@interface LTLGroupHeader ()
///组标题
@property (weak, nonatomic) IBOutlet UILabel *GroupHeader;
///图片
@property (weak, nonatomic) IBOutlet UIImageView *play;
@property (weak, nonatomic) IBOutlet UIImageView *genduo;

@property (weak, nonatomic) IBOutlet UIButton *anNiu;

@end

@implementation LTLGroupHeader


-(void)awakeFromNib
{
    [super awakeFromNib];
    
    UIImage *playImage = [LTLHeadIcon imageOfPlayWithSize:_play.bounds.size resizing:LTLHeadIconResizingBehaviorAspectFill];
    _play.image = playImage;
    
    UIImage *genDuoImage = [LTLHeadIcon imageOfMoreWithSize:_genduo.bounds.size resizing:LTLHeadIconResizingBehaviorAspectFill];
    _genduo.image = genDuoImage;
    
    [_anNiu setTitleColor:[LTLThemeManager sharedManager].themeColor forState:UIControlStateNormal];
    
}


- (IBAction)More:(UIButton *)sender {
    
    LTLMoreSongs *MoreSongs = [[LTLMoreSongs alloc]init];
    
    MoreSongs.model = _model;
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"pushView"] = MoreSongs;
    dic[@"toView"] = self;
    dic[@"isAnimate"] = 0;
    ///发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:LTLPushViewKey object:nil userInfo:[dic copy]];
}

-(void)setModel:(LTLRecommendAlbums *)model
{
    _model = model;
    
    _GroupHeader.text = _model.display_tag_name;
    
}



@end
