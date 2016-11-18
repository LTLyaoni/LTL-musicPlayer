//
//  LTLSongViewController.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/30.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLSongViewController.h"
#import "LTLAnimate.h"
// 自定义Cell
#import "LTLMusicDetailCell.h"
#import "LTLuserInfo.h"
#import "LTLMainInterface.h"
#import "LTLsongSheetCell.h"

@interface LTLSongViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate>
//歌单
@property (nonatomic,strong) UITableView *tableView;
// 升序降序标签: 默认升序
@property (nonatomic,assign) BOOL isAsc;
//歌单数据
@property (nonatomic,strong) NSMutableArray *songArray;
@end

@implementation LTLSongViewController
{   //静态属性
    CGFloat _viewY;
}
///songArray懒加载
-(NSMutableArray *)songArray
{
    if (_songArray == nil) {
        _songArray = [NSMutableArray array];
    }
    return _songArray;
}
#pragma mark - 入出 设置
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //遵守navigationController的代理协议
    self.navigationController.delegate = self;
//    self.navigationController.delegate = self;
}
#pragma mark - 自定义转场
///实现下面方法来自定义转场
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    ///判断转场类型
    if (operation == UINavigationControllerOperationPop) {
        
        CGRect rect = [self.view convertRect:self.infoView.picView.frame fromView:self.infoView.picView.superview];
        
        
        
        if (CGRectGetMidY(rect)<0)
        {
            LTLMainInterface *main = (LTLMainInterface *)toVC;
            //获取toVC中图片的位置
            LTLsongSheetCell *cell = (LTLsongSheetCell *)[main.CollectionView cellForItemAtIndexPath:self.indexPath];
            cell.icon.hidden = NO;
            return nil;
        }
        ///初始化转场动画及数据
        LTLAnimate *animate = [LTLAnimate initWithAnimateType:LTLanimate_pop andDuration:0.6F];
        //返回动画
        return (id<UIViewControllerAnimatedTransitioning>)animate;
        
    }else{
        return nil;
    }
    
}
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigation];
    //初始化头视图及添加透视图
    [self initHeaderView];
    self.navigationController.delegate = self;
    self.view.backgroundColor = [UIColor redColor];
    [self DataAcquisition];
    
}
//设置navigationController
-(void)navigation
{
//    [self.navigationController.navigationBar setTranslucent:YES];
//    //    为什么要加这个呢，shadowImage 是在ios6.0以后才可用的。但是发现5.0也可以用。不过如果你不判断有没有这个方法，
//    //    而直接去调用可能会crash，所以判断下。作用：如果你设置了上面那句话，你会发现是透明了。但是会有一个阴影在，下面的方法就是去阴影
//    if ([self.navigationController.navigationBar respondsToSelector:@selector(shadowImage)])
//    {
//        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
//    }
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
//    UIImage *image = [UIImage imageNamed:@"findsubject_mask"];
//    ///window的layer层添加内容
//    self.navigationController.navigationBar.layer.contents = (id) image.CGImage;    // 如果需要背景透明加上下面这句
//    self.navigationController.navigationBar.layer.backgroundColor = [UIColor clearColor].CGColor;
//    
//    self.navigationItem.title = self.XMAlbumModel.albumTitle;
//    
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"btn_back_n"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
}
-(void)back:(UIButton *)bu
{
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark - tableView懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        // iOS7的状态栏（status bar）不再占用单独的20px, 所以要设置往下20px
        CGRect frame = self.view.bounds;
//        frame.origin.y += 20;
        // 设置普通模式
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        //实现了一个下拉刷新的时候顶部footer的停留
        _tableView.contentInset = UIEdgeInsetsMake(LTL_WindowW*0.5, 0, 0, 0);
        
        [self.view addSubview:_tableView];
        //设置代理属性
        _tableView.dataSource = self;
        _tableView.delegate = self;
        ///在_tableView注册 cell
        [_tableView registerClass:[LTLMusicDetailCell class] forCellReuseIdentifier:@"MusicDetailCell"];
        //cell 高度
        _tableView.rowHeight = 80;
        
    }
    return _tableView;
}
//初始化头视图及添加透视图
- (void)initHeaderView{
    _infoView = [[LTLHeaderView alloc] initWithFrame:CGRectMake(0, 0, LTL_WindowW, LTL_WindowW*0.5)];
//    UIImageView *LTL = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, LTL_WindowW, LTL_WindowW*0.5)];
//    _infoView.backgroundColor = [UIColor blueColor];
//    [self.tableView addSubview:LTL];
    _infoView.XMAlbumModel = self.XMAlbumModel;
    [self.tableView addSubview:_infoView];
}
// 连带滚动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _viewY = scrollView.contentOffset.y;
    //判断tableView往下拉的时候重新设置_infoView的frame这样头视图就不会移动了
    if (_viewY < - LTL_WindowW*0.66 ){
        
        CGRect frame = _infoView.frame;
        frame.origin.y = _viewY;
        frame.size.height = -_viewY;
        
        _infoView.frame = frame;
        _infoView.visualEffectFrame = frame;
        
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

    }
}

#pragma mark - UITableView协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //从循环池中取出 cell
    LTLMusicDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicDetailCell"];
    cell.TrackData = self.songArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - 获取歌单详情
///获取数据
-(void)DataAcquisition
{
    NSMutableArray *array = [NSMutableArray array];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:@(self.XMAlbumModel.albumId) forKey:@"album_id"];
    [params setObject:@20 forKey:@"count"];
    [params setObject:@1 forKey:@"page"];
    
    [[XMReqMgr sharedInstance] requestXMData:XMReqType_AlbumsBrowse params:params withCompletionHander:^(id result, XMErrorModel *error) {
//        NSLog(@"%@",result);
        [result[@"tracks"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            XMTrack *model = [[XMTrack alloc]initWithDictionary:obj];
            model.PlayNumber = @"LTL";
            [model TimeProcessing:model.createdAt];
            [array addObject:model];
        }];
        [self.songArray addObjectsFromArray:array];
        [self.tableView reloadData];
    }];

}
////头视图为空
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return nil;
//}
#pragma mark -点击行数  实现听歌功能
// 点击行数  实现听歌功能
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    /// 当前播放信息
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    LTLuserInfo *userInfo = [[LTLuserInfo alloc]init];
    userInfo.serialNumber = indexPath.row;
    userInfo.songArray = self.songArray;
    dic[@"Play"] = userInfo;
    ///发送播放通知
     [[NSNotificationCenter defaultCenter] postNotificationName:@"LTLPlay" object:nil userInfo:[dic copy]];
}

@end
