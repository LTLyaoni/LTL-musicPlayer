//
//  NSDate+LTLNSDate.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/1.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "NSDate+LTLNSDate.h"


@implementation NSDate (LTLNSDate)

///处理时间
-(NSString *)dateTime
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //真机需要设置时区
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //一年之内
    if ([self isOneYear])
    {
        NSInteger yue = [self isOneMonth];
        //一个月之内
        if (yue == 0) {
            NSInteger tian = [self isOneDay];
            //一天之内
            if (tian == 0) {
                NSInteger Hour = [self isOneHour];
                //一个小时
                if (Hour == 0 ) {
                    
                    NSInteger Minute = [self isOneMinute];
                    //一分钟之内
                    if (Minute == 0) {
                        return @"刚刚";
                    }
                    else
                    {
                        return [NSString stringWithFormat:@"%ld分钟前",Minute];
                    }
                }
                else
                {
                    return [NSString stringWithFormat:@"%ld小时前",Hour];
                }
            }
            else
            {
                return [NSString stringWithFormat:@"%ld个天前",tian];
            }
        }
        //五个月前
        else if (yue <= 5)
        {
            return [NSString stringWithFormat:@"%ld个月前",yue];
        }
        //其他天
        else
        {
            formatter.dateFormat = @"MM-dd";
            return [formatter stringFromDate:self];
        }
    }//非今年
    else
    {
        formatter.dateFormat = @"yyyy-MM-dd";
        return [formatter stringFromDate:self];
    }
}
//计算是否一年之内
-(BOOL)isOneYear
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //真机需要设置时区
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //当前时间
    NSDate *selfDate = [NSDate date];
    //创建日历类
    NSCalendar *Calendar = [NSCalendar currentCalendar];
    //取出时间
    NSCalendarUnit timeUnit = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond  ;
    NSDateComponents *timeDate = [Calendar components:timeUnit fromDate:self];
    NSDateComponents *currentTimeDate = [Calendar components:timeUnit fromDate:selfDate];
    
    return (timeDate.year == currentTimeDate.year);
}
//计算是否一个月之内
-(NSInteger)isOneMonth
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //真机需要设置时区
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //当前时间
    NSDate *selfDate = [NSDate date];
    //创建日历类
    NSCalendar *Calendar = [NSCalendar currentCalendar];
    //取出时间
    NSCalendarUnit timeUnit = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay  | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond  ;;
    //时间差
    NSDateComponents *cha = [Calendar components:timeUnit fromDate:self toDate:selfDate options:NSCalendarWrapComponents];
    //返回月差值
    return  cha.month ;
}
//计算是否一天之内
-(NSInteger)isOneDay
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //真机需要设置时区
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //当前时间
    NSDate *selfDate = [NSDate date];
    //创建日历类
    NSCalendar *Calendar = [NSCalendar currentCalendar];
    //取出时间
    NSCalendarUnit timeUnit = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond  ;;
    //时间差
    NSDateComponents *cha = [Calendar components:timeUnit fromDate:self toDate:selfDate options:NSCalendarWrapComponents];
    //返回天差值
    return  cha.day ;
}
//计算是否一个小时之内
-(NSInteger)isOneHour
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //真机需要设置时区
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //当前时间
    NSDate *selfDate = [NSDate date];
    //创建日历类
    NSCalendar *Calendar = [NSCalendar currentCalendar];
    //取出时间
    NSCalendarUnit timeUnit = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond  ;;
    //时间差
    NSDateComponents *cha = [Calendar components:timeUnit fromDate:self toDate:selfDate options:NSCalendarWrapComponents];
    //返回月差值
    return  cha.hour ;
}
//计算是否一分钟之内
-(NSInteger)isOneMinute
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    //真机需要设置时区
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    formatter.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    //当前时间
    NSDate *selfDate = [NSDate date];
    //创建日历类
    NSCalendar *Calendar = [NSCalendar currentCalendar];
    //取出时间
    NSCalendarUnit timeUnit = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond  ;;
    //时间差
    NSDateComponents *cha = [Calendar components:timeUnit fromDate:self toDate:selfDate options:NSCalendarWrapComponents];
    //返回月差值
    return  cha.minute ;
}

@end
