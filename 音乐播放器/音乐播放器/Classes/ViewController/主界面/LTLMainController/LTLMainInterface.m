//
//  LTLMainInterface.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/18.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLMainInterface.h"
#import "LTLAnimate.h"
#import "LTLsongSheet.h"
#import "LTLAllTheSong.h"

@interface LTLMainInterface ()<UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,LTLsongSheetDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
///定时器
@property(nonatomic,strong) NSTimer * timer;
///头视图
@property (weak, nonatomic) IBOutlet UIView *headerView;
///高度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeight;
///离顶部距离约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopDistance;
//视图组
@property (nonatomic, strong) NSMutableArray            *contentViews;
///偏移
@property (nonatomic, assign) CGFloat            pianyi;
///距离
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *Distance;


@end

@implementation LTLMainInterface
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    
    LTLAllTheSong *TheSong = [LTLAllTheSong initLTLAllTheSong];
    [self addView:TheSong tag:0];
    
    LTLsongSheet *songSheet = [LTLsongSheet initSongSheet];
    songSheet.LTLDelegate = self;
    [self addView:songSheet tag:1];
    
    
}
-(void)initUI
{
    //控件数组
    _contentViews =[NSMutableArray array];
    //分页效果
    _collectView.pagingEnabled = YES;
    //关闭水平滚动指示器
    _collectView.showsHorizontalScrollIndicator = NO;
    //点击Status Bar不能返回顶部。
    _collectView.scrollsToTop                   = NO;
    //弹簧
    _collectView.bounces = NO;
    //头视图高度
    _headerViewHeight.constant = 230;
    //关闭自动调整滚动视图
    self.automaticallyAdjustsScrollViewInsets = NO;
}
//添加视图
-(void)addView:(UIScrollView *)ScrollView tag:(NSInteger)tag
{
    
    ScrollView.tag = tag;
    [ScrollView addObserver:self forKeyPath:@"contentOffset" options:
     NSKeyValueObservingOptionNew context:nil];
    ScrollView.contentInset = UIEdgeInsetsMake(_headerViewHeight.constant, 0, 100, 0);
    [_contentViews insertObject:ScrollView atIndex:tag];

}

//组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//Items数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.contentViews.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //从循环池取出 cell
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainItem" forIndexPath:indexPath];
    /// 删除cell的contentView的所有子控件
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    cell.backgroundColor = [UIColor redColor];
    ///取出相应视图设置frame并添加到cell的contentView上
    UIScrollView *v = _contentViews[indexPath.row];
    v.frame = cell.bounds;
    [cell.contentView addSubview:v];
    
    return cell;
}

//监听相应视图的滑动属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    ///取出可见 cell下标
    NSArray<NSIndexPath *> *indexPath = [_collectView indexPathsForVisibleItems];
    //监听的视图
    UIScrollView *v  = (UIScrollView *)object;
    //遍历cell下标数组
    [indexPath enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //如果监听到的视图不在可见 cell 范围内则不处理,在可见范围内就处理
        if (v.tag == obj.row) {
            //key为监听的的属性
            if ([keyPath isEqualToString:@"contentOffset"])
            {
                ///取出偏移量
                _pianyi =  v.contentOffset.y;
                //计算头视图要偏移的量
                CGFloat ltl = - _pianyi - _headerViewHeight.constant;
                //如果大于0则置零也就是不下滑
                if (ltl > 0) {
                    ltl = 0;
                }
                //偏移量不能小于一定的数值,也就是不能无限上滑
                else if (ltl < -_Distance.constant)
                {
                    ltl = -_Distance.constant;
                    _pianyi = _Distance.constant - _headerViewHeight.constant;
                }
                //移动头视图
                _TopDistance.constant =ltl;
                
            }
        }
    }];
    
}
///处理即将显示的Cell,将偏移量移动到头视图下面
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIScrollView *v = [cell.contentView.subviews lastObject];
    
    if (_pianyi) {
        
        v.contentOffset = CGPointMake(0, _pianyi);
    }
}
//在控制器销毁时
-(void)dealloc
{   //遍历视图数组 移除监听对象
    [_contentViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeObserver:self forKeyPath:@"contentOffset"];
        
    }];
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
#pragma mark - 点击歌单
-(void)LTLsongSheet:(LTLsongSheet *)song VC:(LTLSongViewController *)SongViewController
{
    self.CollectionView = song;
    [self.navigationController pushViewController:SongViewController animated:YES];
}

#pragma mark - 即将显示
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    ///自定义转场需要遵守navigationController的代理协议
    self.navigationController.delegate = self;
}
#pragma mark - 导航栏左按钮点击事件
- (IBAction)left:(UIButton *)sender
{
    ///弹出菜单
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
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

@end
