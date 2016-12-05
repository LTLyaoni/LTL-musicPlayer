//
//  NSString+LTLHighlightKey.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/28.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LTLHighlightKey)
///突出关键字
-(NSMutableAttributedString *)highlightKey:(NSString *)albumTitle;
@end
