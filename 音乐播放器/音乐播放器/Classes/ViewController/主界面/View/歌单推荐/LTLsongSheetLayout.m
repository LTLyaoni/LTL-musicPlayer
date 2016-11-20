//
//  LTLsongSheetLayout.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/18.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLsongSheetLayout.h"

#define jianXi  15

@implementation LTLsongSheetLayout
//初始化
-(instancetype)init
{
    if (self = [super init]) {
        
        ///设置 cell 大小
        CGFloat w = (LTL_WindowW-30-2*jianXi)/3;
        self.itemSize = CGSizeMake( w, w+30);
        //边距
        self.sectionInset = UIEdgeInsetsMake(15, 15, 9, 15);
        self.footerReferenceSize = CGSizeMake(1, 1);
    }
    return self;
}


@end
