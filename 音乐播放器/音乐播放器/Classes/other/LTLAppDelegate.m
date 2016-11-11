//
//  AppDelegate.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/14.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLAppDelegate.h"
#import "LTLloginSet.h"
#import "LTLSearchController.h"
#import "LTLMainController.h"
//#import "MMDrawerController.h"
//#import "MMExampleDrawerVisualStateManager.h"

@interface LTLAppDelegate ()<XMReqDelegate>
@property (nonatomic,strong) MMDrawerController * drawerController;
@property (nonatomic,strong) LTLMainController *mainVC;
@end

@implementation LTLAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 在App启动后开启远程控制事件, 接收来自锁屏界面和上拉菜单的控制
//    [application beginReceivingRemoteControlEvents];
    ///注册喜马拉雅
    [self RegisteredHimalaya];
    ///主视图
    UIStoryboard *Storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController *mianController = [Storyboard instantiateInitialViewController];
    self.mainVC = (LTLMainController *) mianController.topViewController;
    ///右滑视图
    LTLloginSet *log = [[LTLloginSet alloc]initWithNibName:@"LTLloginSet" bundle:nil];
    
//    LTLSearchController *Search = [[LTLSearchController alloc]initWithNibName:@"LTLSearchController" bundle:nil];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:Search];
    ///////////////////////////////////////////
    ///第三方滑动菜单动画框架
    self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:mianController leftDrawerViewController:log];
//    [self.drawerController setCenterViewController:mianController withCloseAnimation:NO completion:nil];
//    self.drawerController.leftDrawerViewController =log;
//    self.drawerController = [[MMDrawerController alloc]initWithCenterViewController:mianController leftDrawerViewController:log rightDrawerViewController:nav];
//    阴影
    self.drawerController.showsShadow = YES;
    //
    self.drawerController.maximumLeftDrawerWidth = LTL_WindowW*4/5;
    self.drawerController.maximumRightDrawerWidth = LTL_WindowW;
    //4、设置打开/关闭抽屉的手势
//    self.drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.drawerController.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
    //////设置抽屉的视觉状态
    [self.drawerController
     setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
         MMDrawerControllerDrawerVisualStateBlock block;
         block = [[MMExampleDrawerVisualStateManager sharedManager]
                  drawerVisualStateBlockForDrawerSide:drawerSide];
         if(block){
             block(drawerController, drawerSide, percentVisible);
         }
     }];
    ///动画类型
    [[MMExampleDrawerVisualStateManager sharedManager]
     setLeftDrawerAnimationType:MMDrawerAnimationTypeSlideAndScale];
    [[MMExampleDrawerVisualStateManager sharedManager]
     setRightDrawerAnimationType:MMDrawerAnimationTypeSwingingDoor];
    ///////////////////////////////////////////
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ///设置根控制器
    self.window.rootViewController = self.drawerController;
//     self.window.rootViewController = mianController;
    ///显示窗口
    [self.window makeKeyAndVisible];
    
    ///////////////////////////////
    UIImage *image = [UIImage imageNamed:@"Stars"];
    ///window的layer层添加内容
    self.window.layer.contents = (id) image.CGImage;    // 如果需要背景透明加上下面这句
    self.window.layer.backgroundColor = [UIColor clearColor].CGColor;
    return YES;
}

-(void)RegisteredHimalaya
{
//    [[XMReqMgr sharedInstance]registerXMReqInfoWithKey:appkey appSecret:appsecret];
//    [XMReqMgr sharedInstance].delegate = self;
#if DEBUG
    [[XMReqMgr sharedInstance] registerXMReqInfoWithKey:appkey appSecret:appsecret] ;
#else
    [[XMReqMgr sharedInstance] registerXMReqInfoWithKey:appkey appSecret:appsecret] ;
#endif
    [XMReqMgr sharedInstance].delegate = self;
}


-(void)didXMInitReqFail:(XMErrorModel *)respModel{
    NSLog(@"注册失败 %@", respModel);
}
-(void)didXMInitReqOK:(BOOL)result
{
    NSLog(@"注册成功 %d" , result);
    if (result) {
        [self.mainVC DataAcquisition];
    }
}
// 接收到内存警告就会调用
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    //    DDActionLog;
    
    // 1.停止当前下载
    [[SDWebImageManager sharedManager] cancelAll];
    
    // 2.清空内存缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    ///喜马拉雅要求在App要终止前调用下面一句话
    [[XMReqMgr sharedInstance] closeXMReqMgr];
    // 在App要终止前结束接收远程控制事件, 也可以在需要终止时调用该方法终止
//    [application endReceivingRemoteControlEvents];
}


@end
