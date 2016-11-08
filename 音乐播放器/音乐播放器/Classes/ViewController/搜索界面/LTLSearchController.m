//
//  LTLSearchController.m
//  音乐播放器
//
//  Created by Apple_Lzzy46 on 16/10/28.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLSearchController.h"

@interface LTLSearchController ()

@end

@implementation LTLSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置导航栏
    [self setNav];
    
    
}
#pragma mark - 获取数据
-(void)shuJu
{
//    __weak typeof(self) sself = self;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@10 forKey:@"top"];

    [[XMReqMgr sharedInstance] requestXMData:XMReqType_SearchHotWords params:params withCompletionHander:^(id result, XMErrorModel *error) {
        
        [result enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            XMHotword *model = [[XMHotword alloc]initWithDictionary:obj] ;
            
            NSLog(@"%@",model.searchWord);
        }];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self shuJu];
}

-(void)viewWillLayoutSubviews
{
    

}

#pragma mark - 设置导航栏
-(void)setNav
{
    //返回按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navigationbar_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    UITextField * txet = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 450, 35)];
    //    UITextField * txet = [[UITextField alloc]init];
    
    txet.background = [UIImage imageNamed:@"common_button_white_disable"];
    
    txet.placeholder = @"请输入搜索关键字";
    
    self.navigationItem.titleView = txet;
    
    UIImageView *imager = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tabbar_discover"]];
    
    txet.leftView = imager;
    txet.leftViewMode = UITextFieldViewModeAlways;
    
}

-(void)back
{
    //返回主界面
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
