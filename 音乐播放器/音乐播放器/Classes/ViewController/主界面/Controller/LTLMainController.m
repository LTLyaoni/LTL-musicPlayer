//
//  LTLMainController.m
//  音乐播放器
//
//  Created by Apple_Lzzy46 on 16/10/26.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLMainController.h"
#import "LTLCarouselView.h"
#import "LTLsongSheetCell.h"
#import "LTLSongViewController.h"
#import "LTLAnimate.h"


#define jianXi  15
@interface LTLMainController ()<UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate>
/**
 *  歌单数组
 */
@property(nonatomic,strong)NSMutableArray *songSheetArray;
//头视图
@property(nonatomic,strong)LTLCarouselView *CarouseView;
//约束
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowtLayout;


@end

@implementation LTLMainController
{   //静态属性
    CGFloat _viewY;
}
//cell重用标识符
static NSString *cellID = @"colleCell";
#pragma mark - 懒加载
//懒加载
-(NSMutableArray *)songSheetArray
{
    if (_songSheetArray == nil) {
        _songSheetArray = [NSMutableArray array];
    }
    return _songSheetArray;
}
-(LTLCarouselView *)CarouseView
{
    if (_CarouseView == nil) {
        
        _CarouseView = [LTLCarouselView viewFromXib];
        _CarouseView.frame = CGRectMake(0, 0, LTL_WindowW, LTL_WindowW*0.66);
        [self.CollectionView addSubview:_CarouseView];
    }
    return _CarouseView;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.mm_drawerController setCenterViewController:centerNavCtl withFullCloseAnimation:NO completion:nil];
//    NSLog(@"LTL%@",NSStringFromCGRect(self.PlayControl.songImage.frame));
//    CGRect newFream = [self.PlayControl.songImage convertRect:self.PlayControl.songImage.bounds toView:self.navigationController.view];
//    UIButton *button = [[UIButton alloc]initWithFrame:newFream];
//    button.backgroundColor = [UIColor redColor];
//    [self.navigationController.view addSubview:button];
    //实现了一个下拉刷新的时候顶部轮播器的停留
    self.CollectionView.contentInset = UIEdgeInsetsMake(self.CarouseView.highly, 0, 0, 0);
    ///设置 cell 大小
    CGFloat w = (LTL_WindowW-30-2*jianXi)/3;
    self.flowtLayout.itemSize = CGSizeMake( w, w+30);
    ///注册 cell
    [self.CollectionView registerNib:[UINib nibWithNibName:@"LTLsongSheetCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    [self DataAcquisition];
}
// 连带滚动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _viewY = scrollView.contentOffset.y;
    //判断tableView往下拉的时候重新设置_infoView的frame这样头视图就不会移动了
    if (_viewY < - LTL_WindowW*0.66 ){
        
        _CarouseView.y = _viewY;
//        _CarouseView.highly = -_viewY;
    }
}

//设置navigationController
-(void)navigation
{
//    [self.navigationController.navigationBar setTranslucent:YES];
//    //    为什么要加这个呢，shadowImage 是在ios6.0以后才可用的。但是发现5.0也可以用。不过如果你不判断有没有这个方法，
//    //    而直接去调用可能会crash，所以判断下。作用：如果你设置了上面那句话，你会发现是透明了。但是会有一个阴影在，下面的方法就是去阴影
//    if ([self.navigationController.navigationBar respondsToSelector:@selector(shadowImage)])
//    {
//        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
//    }
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
}

//Items数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"%ld",self.songSheetArray.count);
    return self.songSheetArray.count;
//    return 100;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    //重用标识符
//    static NSString *ID = @"colleCell";
    ///从循环池从取出 cell
    LTLsongSheetCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    //取出模型数据
     XMAlbum *model = self.songSheetArray[indexPath.row];
    //赋值模型数据
    cell.model = model;
    
    return cell;
}
//设置头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //重用标识符
    static NSString *ID = @"HeaderView";
    ///从循环池从取出 cellheadView
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:ID forIndexPath:indexPath];
    headView.backgroundColor = [UIColor blueColor];
    return headView;
}
#pragma mark - 点击歌单
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSLog(@"%ld",indexPath.row);
    LTLSongViewController *song = [[LTLSongViewController alloc]init];
    
    song.XMAlbumModel = self.songSheetArray[indexPath.row];
    
    [self.navigationController pushViewController:song animated:YES];
}
#pragma mark - 数据
-(void)DataAcquisition
{
    [self.CarouseView DataAcquisition];
    [LTLNetworkRequest MetadataAlbumsPage:1 dimension:LTLDimensionTheFire dadt:^(NSMutableArray * _Nullable modelArray, XMErrorModel * _Nullable error) {
        
        [self.songSheetArray addObjectsFromArray:modelArray];
        
        [self.CollectionView reloadData];
        
    }];
}
#pragma mark - 即将显示
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ///自定义转场需要遵守navigationController的代理协议
    self.navigationController.delegate = self;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [self beginAppearanceTransition: YES animated: animated];
    
}
#pragma mark - 自定义转场
///要实现下列方法来返回转场动画
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    ///判断转场类型
    if (operation == UINavigationControllerOperationPush) {
        ///初始化动画及动画类型
        LTLAnimate *animate = [LTLAnimate initWithAnimateType:LTLanimate_push andDuration:0.6F];
       ///返回动画
        return (id<UIViewControllerAnimatedTransitioning>)animate;
        
    }else{
        return nil;
    }
    
}
#pragma mark - 导航栏左按钮点击事件
- (IBAction)left:(UIButton *)sender
{
    ///弹出菜单
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (IBAction)right:(UIButton *)sender {
    //弹出搜索界面
//    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
}

-(void)dealloc
{
    NSLog(@"LTLMainControllerx销毁");
}

#pragma mark - XMReqDelegate
@end
