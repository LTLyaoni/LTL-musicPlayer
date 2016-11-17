//
//  LTLConstants.h
//  music
//
//  Created by LiTaiLiang on 16/10/30.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#ifndef Constants_h
#define Constants_h
//喜马拉雅请求数据使用的appkey 与appsecret
#define appkey @"5415528c4b30960349a59e3284f5dec5"
#define appsecret @"60b7510c6c55926ef1fde37a5d1473a0"
// NavigationBar高度
#define LTL_NavigationBar_HEIGHT 44

// 自定义Cell高,
#define LTL_BigCellHight 120

// 自定义方形按钮宽
#define LTL_Rect (kWindowW - 40)/3

#pragma mark - 设备信息
#define LTL_IOS_VERSION    [[[UIDevice currentDevice] systemVersion] floatValue]
#define LTL_DEVICE_MODEL   [[UIDevice currentDevice] model]
#define LTL_IS_IPAD        ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
#define LTL_APP_NAME            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]
#define LTL_APP_VERSION         [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define LTL_APP_SUB_VERSION     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define LTL_UDeviceIdentifier   [[UIDevice currentDevice] uniqueDeviceIdentifier]
/** 当前系统语言*/
#define LTL_CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

#pragma mark - ios版本判断
#define LTL_IOS5_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"5.0"] != NSOrderedAscending )
#define LTL_IOS6_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define LTL_IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define LTL_IOS8_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )

#pragma mark - 设备类型
#define LTL_isPhone4     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define LTL_isPhone5     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define LTL_isPhone6     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define LTL_isPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define LTL_isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define LTL_isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

#pragma mark - 颜色
//#define s_COLOR_RGB(r,g,b)     [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0]
//#define s_COLOR_RGBA(r,g,b,a)  [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define LTL_RGBColor(R,G,B)        [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define LTL_RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define LTL_COLOR_HEX(hexValue) [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 green:((float)((hexValue & 0xFF00) >> 8))/255.0 blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]
#define LTLrandomColor  [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]


#pragma mark - 定义字体大小
#define LTL_FONT_TITLE(X)     [UIFont systemFontSize:X]
#define LTL_FONT_CONTENT(X)   [UIFont systemFontSize:X]

#pragma mark - 屏幕相关
#define LTL_WindowH   [UIScreen mainScreen].bounds.size.height //应用程序的屏幕高度
#define LTL_WindowW    [UIScreen mainScreen].bounds.size.width  //应用程序的屏幕宽度

// AppDelegate
#define LTL_AppDelegate ((AppDelegate*)([UIApplication sharedApplication].delegate))

// Storyboard通过名字获取
#define LTL_Storyboard(StoryboardName)     [UIStoryboard storyboardWithName:StoryboardName bundle:nil]

#pragma mark - GCD
#define LTL_BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define LTL_MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

// 移除iOS7之后，cell默认左侧的分割线边距
#define LTL_RemoveCellSeparator \
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{\
cell.separatorInset = UIEdgeInsetsZero;\
cell.layoutMargins = UIEdgeInsetsZero; \
cell.preservesSuperviewLayoutMargins = NO; \
}\

// Docment文件夹目录
#pragma mark - Docment文件夹目录
#define LTL_DocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

#endif /* Constants_h */
