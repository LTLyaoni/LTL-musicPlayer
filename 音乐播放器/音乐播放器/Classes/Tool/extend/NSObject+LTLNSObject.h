//
//  NSObject+LTLNSObject.h
//  音乐播放器
//
//  Created by LiTaiLiang on 16/12/13.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LTLNSObject)
/* 获取对象的所有属性和属性内容 */
- (NSDictionary *)getAllPropertiesAndVaules;
/* 获取对象的所有属性 */
- (NSArray *)getAllProperties;
/* 获取对象的所有方法 */
-(void)getAllMethods;
@end
