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
#import "LTLMusicTable.h"
#import "LTLMusicLibrary.h"
#import "LTLCarouselView.h"
#import "LTLMagnifier.h"
#import "LTLSetMore.h"
#import "LTLSearchController.h"

@interface LTLMainInterface ()<UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,UIScrollViewDelegate,LTLCarouselViewDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectView;
///定时器
@property(nonatomic,strong) NSTimer * timer;
///头视图
@property (weak, nonatomic) IBOutlet LTLCarouselView *headerView;
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
//是否需要转场动画
@property (nonatomic,assign,getter=isAnimate)BOOL animate;
//左按钮
@property (nonatomic,strong) UIButton * leftButton;
//右按钮
@property (nonatomic,strong) UIButton * rightButton;



@end

@implementation LTLMainInterface
#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationButton];
//    self.navigationController.fd_prefersNavigationBarHidden = YES;

    _headerView.LTLDelegate = self;
    
    [self receiveNotification];
    [self initUI];
    
    LTLMusicTable *TheSong = [LTLMusicTable initLTLMusicTable];
//    TheSong.LTLDelegate = self;
    [self addView:TheSong tag:0];
    
    LTLsongSheet *songSheet = [LTLsongSheet initSongSheet];
//    songSheet.LTLDelegate = self;
    [self addView:songSheet tag:1];
    
    LTLMusicLibrary *MusicLibrary = [LTLMusicLibrary initLTLMusicLibrary];
    [self addView:MusicLibrary tag:2];
    
    
    [self didLTLCarouselView:nil tag:1];
    
}
#pragma mark - 设置控件
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
//    //头视图高度
//    _headerViewHeight.constant = 220;
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
#pragma mark - CollectionViews设置
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
    
    cell.backgroundColor = [UIColor blueColor];
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
    /// 关闭消息中心
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
#pragma mark - 自定义转场
///要实现下列方法来返回转场动画
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    ///判断转场类型
    if (operation == UINavigationControllerOperationPush && self.isAnimate  ) {
        ///初始化动画及动画类型
        LTLAnimate *animate = [LTLAnimate initWithAnimateType:LTLanimate_push andDuration:0.6F];
        ///返回动画
        return (id<UIViewControllerAnimatedTransitioning>)animate;
        
    }else{
        return nil;
    }
    
}
#pragma mark - 懒加载按钮
-(UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
       
        UIImage *leftButtonImage = [LTLSetMore imageOfArtboardWithSize:CGSizeMake(30, 30) resizing:LTLSetMoreResizingBehaviorAspectFit];
         [_leftButton setImage:leftButtonImage forState:UIControlStateNormal];
    
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_leftButton];
    
    }
    return _leftButton;
}

-(UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:_rightButton];
        UIImage *rightButtonImage = [LTLMagnifier imageOfArtboardWithSize:CGSizeMake(30, 30) resizing:LTLMagnifierResizingBehaviorAspectFit];
        [_rightButton setImage:rightButtonImage forState:UIControlStateNormal];
        
    }
    return _rightButton;
}

#pragma mark - 点击歌单
///接受通知
-(void)receiveNotification
{
    // 开启一个通知接受,开始播放
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushView:) name:LTLPushViewKey object:nil];
}
-(void)pushView:(NSNotification *)notification
{
    
    
    self.animate = (BOOL) notification.userInfo[@"isAnimate"];
    
    if (self.isAnimate) {
        self.CollectionView = notification.userInfo[@"toView"];
    }
    
    [self.navigationController pushViewController:notification.userInfo[@"pushView"] animated:YES];
    
    
}
#pragma mark - 即将显示
//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    
//    
//}

-(void)viewWillAppear:(BOOL)animated
{
    ///自定义转场需要遵守navigationController的代理协议
    self.navigationController.delegate = self;
    
    //4、设置打开/关闭抽屉的手势
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    self.mm_drawerController.closeDrawerGestureModeMask =MMCloseDrawerGestureModeAll;
    
    self.navigationItem.title = @"L音";
    [super viewWillAppear:animated];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //4、设置打开/关闭抽屉的手势
    self.mm_drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeNone;
    self.mm_drawerController.closeDrawerGestureModeMask =MMOpenDrawerGestureModeNone;
    self.title = nil;
}

-(void)didLTLCarouselView:(LTLCarouselView *)CarouselView tag:(NSUInteger)tag
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:tag inSection:0];
    
    [_collectView scrollToItemAtIndexPath:indexPath
                            atScrollPosition:UICollectionViewScrollPositionLeft
                                    animated:YES];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.headerView huangDong:scrollView.contentOffset.x];
}
#pragma mark - 导航栏左按钮点击事件
-(void)setNavigationButton
{
    [self.leftButton addTarget:self action:@selector(left:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightButton addTarget:self action:@selector(right:) forControlEvents:UIControlEventTouchUpInside];

}
- (void)left:(UIButton *)btn
{
    ///弹出菜单
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
- (void)right:(UIButton *)btn
{
    NSLog(@"search搜索");
    
    LTLSearchController *search = [[LTLSearchController alloc]init];
    self.animate = NO;
    [self.navigationController pushViewController:search animated:YES];
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
