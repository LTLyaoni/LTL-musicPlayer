//
//  NSString+LTLHighlightKey.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/28.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "NSString+LTLHighlightKey.h"

@implementation NSString (LTLHighlightKey)

-(NSMutableAttributedString *)highlightKey:(NSString *)albumTitle
{
    // NSRegularExpression类里面调用表达的方法需要传递一个NSError的参数。下面定义一个
    NSError *error;
    // http+:[^\\s]* 这个表达式是检测一个网址的。(?<=title\>).*(?=</title)截取html文章中的<title></title>中内文字的正则表达式
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern: @"(?<=<em>).*(?=</em>)" options: 0 error:&error];
    
    NSTextCheckingResult *firstMatch=[regex firstMatchInString:self options: 0 range:NSMakeRange( 0 , [self length])];
    
    NSRange resultRange = [firstMatch rangeAtIndex: 0 ];

    // 从highlightAlbumTitle当中截取关键字
    NSString *result=[NSString stringWithFormat:@"%@",[self substringWithRange:resultRange]];
    
    NSRange range = [albumTitle rangeOfString:result ];
    
//    if (range.location != NSNotFound)
//    {
//    
//        
//    }
    if (albumTitle) {
        
        //创建带有属性的字符串
        NSMutableAttributedString *attributeTitle =[[NSMutableAttributedString alloc]initWithString:albumTitle];
        
        //    //获取 prefix字串Range
        //    NSRange prefixRange =[self rangeOfString:prefix];
        // NSLog(@"",prefixRange.location,)
        [attributeTitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:range];
        
        [attributeTitle addAttribute:NSForegroundColorAttributeName value:[LTLThemeManager sharedManager].themeColor range:range];
        return attributeTitle;
    }
    else
    {
        return nil;
        
    }
}

@end
