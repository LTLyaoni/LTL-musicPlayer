//
//  LTLSongViewController.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/10/30.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLSongViewController.h"
//动画
#import "LTLAnimate.h"
// 自定义Cell
#import "LTLMusicDetailCell.h"
///
#import "LTLuserInfo.h"
//播放模型
#import "LTLMainInterface.h"
//
#import "LTLsongSheetCell.h"
//矢量箭头
#import "LTLReturnArrow.h"

//#import <UShareUI/UMSocialUIManager.h>
#import <UMSocialCore/UMSocialManager.h>
#import <UMSocialCore/UMSocialMessageObject.h>

#import "LTLshare.h"

#define pianYi 165+LTL_WindowW /10

@interface LTLSongViewController ()<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,LTLHeaderViewDelegate>
//歌单
@property (nonatomic,strong) UITableView *tableView;
// 升序降序标签: 默认升序
@property (nonatomic,assign) BOOL isAsc;
//歌单数据
@property (nonatomic,strong) NSMutableArray <XMTrack *> *songArray;
//页
@property(nonatomic,assign)NSUInteger page;
///NavigationControllerbackView
@property (nonatomic, strong) UIView *backView;
//毛玻璃
@property (nonatomic,strong) UIView *effectView;

@property(nonatomic,strong) UILabel *albumTitle;

@end

@implementation LTLSongViewController
{   //静态属性
    CGFloat _viewY;
    BOOL _LTL;
}
///songArray懒加载
-(NSMutableArray<XMTrack *> *)songArray
{
    if (_songArray == nil) {
        _songArray = [NSMutableArray array];
    }
    return _songArray;
}

-(UILabel *)albumTitle
{
    if (!_albumTitle) {
        _albumTitle = [[UILabel alloc]init];
        _albumTitle.textAlignment = NSTextAlignmentCenter;
//        _albumTitle.backgroundColor = [UIColor redColor];
    }
    return _albumTitle;
}

-(UIView *)backView
{
    if (!_backView) {
        
        _backView = [[UIView alloc]initWithFrame: CGRectMake(0, 0, LTL_WindowW, 64)];
        _backView.backgroundColor = [UIColor clearColor];
        
        UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        //毛玻璃
        UIVisualEffectView *VisualEffect = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        VisualEffect.frame = _backView.bounds;
        
        _effectView = [[UIView alloc]initWithFrame:_backView.bounds];
        //bar 背景图片
        UIImageView *imag = [[UIImageView alloc]initWithFrame:_effectView.bounds];
        //图片
        NSURL *url = [NSURL URLWithString:_XMAlbumModel.coverUrlLarge];
        [imag sd_setImageWithURL:url];
        imag.contentMode = UIViewContentModeScaleAspectFill;
        imag.clipsToBounds = YES;
        
        [_effectView addSubview:imag];
        [_effectView addSubview:VisualEffect];

        [_backView insertSubview:_effectView aboveSubview:_backView];
        ///返回按钮
        UIButton *leftBtn = [[UIButton alloc]init];
        
        UIImage *leftBtnImage = [LTLReturnArrow imageOfArtboardWithSize:CGSizeMake(30, 30) resizing:LTLReturnArrowResizingBehaviorAspectFit];
        
        [leftBtn setImage:leftBtnImage forState:UIControlStateNormal];
        [leftBtn setTitle:@"返回" forState:UIControlStateNormal];

        [leftBtn setTitleColor:[LTLThemeManager sharedManager].themeColor forState:UIControlStateNormal];
        
        [leftBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        [_backView addSubview:leftBtn];
        
        [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(_backView.mas_left).offset(10);
            make.bottom.equalTo(_backView.mas_bottom).offset(-5);
            make.size.mas_equalTo(CGSizeMake(70, 30));
            
        }];
        ///分享
        UIButton *rightBtn = [[UIButton alloc]init];
        
        UIImage *rightBtnImage = [LTLshare imageOfArtboardWithSize:CGSizeMake(30, 30) resizing:LTLshareResizingBehaviorAspectFit];
        
        [rightBtn setImage:rightBtnImage forState:UIControlStateNormal];

        [rightBtn addTarget:self action:@selector(shareSong) forControlEvents:UIControlEventTouchUpInside];
        
        [_backView addSubview:rightBtn];
        
        [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(_backView.mas_right).offset(-15);
            make.bottom.equalTo(_backView.mas_bottom).offset(-5);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            
        }];
        ///屏蔽分享功能
        rightBtn.hidden = YES;
        
        [_backView addSubview:self.albumTitle];
        
        [self.albumTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(rightBtn.mas_left).offset(-15);
            make.left.equalTo(leftBtn.mas_right).offset(15);
//            make.bottom.equalTo(_backView.mas_bottom).offset(-2);
            make.centerY.equalTo(rightBtn.mas_centerY);
//            make.size.mas_equalTo(CGSizeMake(30, 30));
            
        }];
        
        _effectView.alpha = 0;

    }
    return _backView;
}
//返回
-(void)back:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)shareSong
{
//    __weak typeof(self) weakSelf = self;
//    //显示分享面板
//    [UMSocialUIManager showShareMenuViewInView:nil sharePlatformSelectionBlock:^(UMSocialShareSelectionView *shareSelectionView, NSIndexPath *indexPath, UMSocialPlatformType platformType) {
//        // 根据platformType调用相关平台进行分享
//        
//    }];
    
//    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
//        
//        
//        
//    } ];

    NSString *text = @"社会化组件U-Share将各大社交平台接入您的应用，快速武装App。";
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    messageObject.text = text;
    
    [[UMSocialManager defaultManager] shareToPlatform:UMSocialPlatformType_Sina messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        NSString *message = nil;
        if (!error) {
            message = [NSString stringWithFormat:@"分享成功"];
        } else {
            message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
            
        }
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"share"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
    
}


#pragma mark - 初始化
- (void)viewDidLoad
{
    [super viewDidLoad];
    _LTL = YES;
    _page = 0;
    [self navigation];
    //初始化头视图及添加透视图
    [self initHeaderView];
    self.navigationController.delegate = self;
    self.view.backgroundColor = [UIColor redColor];
//    [self DataAcquisition];
    [self.view insertSubview:self.backView aboveSubview:self.tableView];
  
    
}
//设置navigationController
-(void)navigation
{
    self.navigationController.fd_prefersNavigationBarHidden = YES;
 
}

#pragma mark - tableView懒加载
- (UITableView *)tableView {
    if (!_tableView) {
        
        CGRect frame = self.view.bounds;
        // 设置普通模式
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        //实现了一个下拉刷新的时候顶部footer的停留
        _tableView.contentInset = UIEdgeInsetsMake(pianYi, 0, 60, 0);
        
        
        [self.view addSubview:_tableView];
        //设置代理属性
        _tableView.dataSource = self;
        _tableView.delegate = self;
        ///在_tableView注册 cell
        [_tableView registerClass:[LTLMusicDetailCell class] forCellReuseIdentifier:@"MusicDetailCell"];
        //cell 高度
        _tableView.rowHeight = 80;
        
        _tableView.LTLrefreshHeader = [LTLTimeLineRefreshHeader refreshHeaderWithCenter:CGPointMake(LTL_WindowW*4/5, 0) iamge:nil refreshing:^{
            _page = 0;
            [self DataAcquisition];
        }];
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [self DataAcquisition];
        }];
        
    }
    return _tableView;
}
//初始化头视图及添加透视图
- (void)initHeaderView
{
    _infoView = [[LTLHeaderView alloc] initWithFrame:CGRectMake(0, 0, LTL_WindowW, pianYi)];
    _infoView.delegate = self;
    _infoView.XMAlbumModel = self.XMAlbumModel;
    
    [self.tableView addSubview:_infoView];
//    [self.view insertSubview:_infoView aboveSubview:self.tableView];
}

-(void)setXMAlbumModel:(XMAlbum *)XMAlbumModel
{
    _XMAlbumModel = XMAlbumModel;
    
    self.albumTitle.text = _XMAlbumModel.albumTitle;

}


// 连带滚动方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  
    _viewY = scrollView.contentOffset.y;
    
    CGFloat alpha = (-_viewY - 64) / (pianYi + 20) ;

    self.effectView.alpha =0.8 - alpha;
  
    //判断tableView往下拉的时候重新设置_infoView的frame这样头视图就不会移动了
    if (_viewY < - pianYi ){
        
        CGRect frame = _infoView.frame;
        frame.origin.y = _viewY;
        frame.size.height = fabs(_viewY);
        _infoView.frame = frame;
    }
}

#pragma mark - UITableView协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.songArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //从循环池中取出 cell
    LTLMusicDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MusicDetailCell"];
    cell.trackData = self.songArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - 获取歌单详情
///获取数据
-(void)DataAcquisition
{
    self.page++;
    
    NSInteger albumId =  self.XMAlbumModel.albumId ;
    
    [LTLNetworkRequest AlbumsBrowseID:albumId page:_page Dadt:^(NSArray<XMTrack *> * _Nullable modelArray, XMErrorModel * _Nullable error) {
        
        if (modelArray.count)
        {
            if (self.page == 1) {
                [self.songArray removeAllObjects];
            }
            [self.songArray addObjectsFromArray:modelArray];
            
            [self.tableView reloadData];
            //结束刷新状态
            [self.tableView.LTLrefreshHeader endRefreshing];
            [self.tableView.mj_footer endRefreshing];

        } else {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            [self.tableView.LTLrefreshHeader endRefreshing];
            self.page--;
        }
        
    }];
   
}
////头视图为空
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return nil;
//}
#pragma mark -点击行数  实现听歌功能
// 点击行数  实现听歌功能
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSRange range = NSMakeRange(indexPath.row, self.songArray.count - indexPath.row);
    NSArray *arrayL = [self.songArray subarrayWithRange:range];
    
    [self playNotification:[arrayL copy] serialNumber:0];
}

-(void)playAllSongHeaderView:(LTLHeaderView *)headerView
{
    [self playNotification:[self.songArray copy] serialNumber:0];
}

-(void)downloadAllSongHeaderView:(LTLHeaderView *)headerView
{
    
    
}



-(void)playNotification:(NSMutableArray *)arrya serialNumber:(NSUInteger)serialNumber
{
    if (arrya.count != 0 ) {
        
        /// 当前播放信息
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        LTLuserInfo *userInfo = [[LTLuserInfo alloc]init];
        userInfo.serialNumber = serialNumber;
        userInfo.songArray = [arrya copy];
        dic[@"Play"] = userInfo;
        ///发送播放通知
        [[NSNotificationCenter defaultCenter] postNotificationName:LTLPlay object:nil userInfo:[dic copy]];
    }

}


#pragma mark - 入出 设置
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //遵守navigationController的代理协议
    self.navigationController.delegate = self;
    [self.navigationController setNavigationBarHidden:YES animated:YES];//隐藏 常态时是否隐藏 动画时是否显示
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (_LTL) {
        _LTL = NO;
        [self.tableView.LTLrefreshHeader beginRefreshing];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];//隐藏 常态时是否隐藏 动画时是否显示
    
}

#pragma mark - 自定义转场
///实现下面方法来自定义转场
-(id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    
    ///判断转场类型
    if (operation == UINavigationControllerOperationPop && self.indexPath) {
        
        CGRect rect = [self.view convertRect:self.infoView.picView.frame fromView:self.infoView.picView.superview];
        
        if (CGRectGetMidY(rect)<0)
        {
            
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


@end
