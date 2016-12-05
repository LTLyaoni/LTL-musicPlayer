//
//  LTLsearchResultController.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/29.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLsearchResultController.h"
#import "LTLCollectionViewFlowLayout.h"
#import "LTLResult.h"
#import "PYSearch.h"

#define typeHeight 25

@interface LTLsearchResultController ()<UICollectionViewDelegate,UICollectionViewDataSource>
///视图
@property(nonatomic,strong) UICollectionView *collectionView;
///初始位置
@property(nonatomic,assign) CGFloat startPosition;
///搜索类型
@property(nonatomic,assign) BOOL  searchType;
///正处于的搜索类型按钮
@property(nonatomic,weak) UIButton *btnType;
///正处于的搜索维度按钮
@property(nonatomic,weak) UIButton *btnWeiDu ;


@end

@implementation LTLsearchResultController

static NSString * const reuseIdentifier = @"searchResultCell";
static NSString * const tableViewCell = @"tableViewCell";

#pragma mark - 懒加载
///分视图
-(UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64+typeHeight*2, LTL_WindowW, LTL_WindowH - 64) collectionViewLayout:[[LTLCollectionViewFlowLayout alloc]init]];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[LTLResult class] forCellWithReuseIdentifier:reuseIdentifier];
        
        _collectionView.backgroundColor = [UIColor yellowColor];
    
        
    }
    return _collectionView;
}

#pragma mark - 初始化
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setUI];
}

-(void)setUI
{
    NSArray <NSString *> *titleArray = @[@"专辑",@"声音"];
    NSArray *titleTag = @[@10,@11];
    [self setButtonTitle:titleArray tag:titleTag X:0 Y:64 Height:typeHeight];
    
    NSArray <NSString *> *weiDu = @[@"最新",@"最多播放",@"最相关"];
    NSArray *weiDuTag = @[@20,@21,@22];
    [self setButtonTitle:weiDu tag:weiDuTag X:0 Y:64+typeHeight Height:typeHeight];

    [self.view addSubview:self.collectionView];
    
}
///创建按钮
-(void)setButtonTitle:(NSArray <NSString *> *)titleArray tag:(NSArray *)tag X:(CGFloat)X Y:(CGFloat)Y Height:(CGFloat)height
{
    CGFloat w = LTL_WindowW /titleArray.count;
    [titleArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGRect rect = CGRectMake(X, Y, w, height);

        UIView *di = [[UIView alloc]initWithFrame:CGRectMake(0, height - 1, w, 1)];
        di.backgroundColor = [UIColor redColor];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectOffset(rect, w * idx, 0)];
        
        [btn setTitle:obj forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[LTLThemeManager sharedManager].themeColor forState:UIControlStateHighlighted];
        [btn setTitleColor:[LTLThemeManager sharedManager].themeColor forState:UIControlStateSelected];
        
        btn.backgroundColor = [UIColor lightGrayColor];
        
        btn.tag = [tag[idx] doubleValue];
        
        if ([tag[idx] doubleValue] == 10) {
            btn.selected = YES;
            self.btnType = btn;
            self.searchType = NO;
        }
        else if ([tag[idx] doubleValue] == 20)
        {
            btn.selected = YES;
            self.btnWeiDu = btn;
        }
        
        [btn addTarget:self action:@selector(didSearchButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [btn addSubview:di];
        [self.view addSubview:btn];
    }];
}

-(void)didSearchButton:(UIButton *)btn
{
    
    ///行按钮
    NSUInteger sisters = btn.tag/10;
    ///第几个
    NSUInteger row = btn.tag%10;
    
    NSIndexPath *indexPath;
    
    
    if (sisters == 1) {
        self.searchType = sisters;
        
        indexPath = [NSIndexPath indexPathForItem:0 inSection:row];
        self.btnType.selected = NO;
        self.btnType = btn;
        
        UIButton *btnWeiDu = [self.view viewWithTag:20];
        self.btnWeiDu.selected = NO;
        btnWeiDu.selected = YES;
        self.btnWeiDu = btnWeiDu;
        
        
    }
    else if (sisters == 2)
    {
        indexPath = [NSIndexPath indexPathForItem:row inSection:self.searchType];
        self.btnWeiDu.selected = NO;
        self.btnWeiDu = btn;
    
    }
    
    btn.selected = YES;
    [_collectionView scrollToItemAtIndexPath:indexPath
                            atScrollPosition:UICollectionViewScrollPositionLeft
                                    animated:NO];
 
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LTLResult *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [cell removeData];
    
    return cell;
}
///处理即将显示的Cell !即将显示的时候才显示
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    LTLResult *resultcell =(LTLResult *)cell;
    resultcell.indexPath = indexPath;
    resultcell.searchText = self.searchText;
}


#pragma mark - UIScrollViewDelegate
////滑动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offsetX = ABS(scrollView.contentOffset.x - self.startPosition) ;
    
    CGFloat offset = offsetX / LTL_WindowW;
    
//    LTLLog(@"xxx %f",offset);
//    LTLLog(@"xxx %f",1-offset);
    ///中心点
    CGPoint center = scrollView.center;
    center.x += scrollView.contentOffset.x;
    //获取可见cell 的下标
    NSArray *indexPaths = [_collectionView indexPathsForVisibleItems];
    
    NSIndexPath *targetPath = nil;
    for (NSIndexPath *indexPath in indexPaths)
    {
        UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:indexPath];
        ///判断中心是否在cell 范围内
        if (CGRectContainsPoint(cell.frame, center))
        {
            ///取下标
            targetPath = indexPath;
            break;
        }
    }
    
    if (targetPath != nil)
    {
        ///更新指示
        [self upButton:targetPath];
        
    }
    [[NSNotificationCenter defaultCenter]postNotificationName:LTLExitKeyboard object:nil];
}

-(void)upButton:(NSIndexPath *)targetPath
{
    if (self.searchType != targetPath.section) {

        self.searchType = targetPath.section;
        ///行按钮
        NSUInteger tag = 10 + !(self.btnType.tag%10);
        
        UIButton *tyb = [self.view viewWithTag:tag];
        self.btnType.selected = NO;
        tyb.selected = YES;
        self.btnType = tyb;
       
    }
    ///行按钮
    NSUInteger tag = 20 + targetPath.row;
    
    UIButton *btm = [self.view viewWithTag:tag];
    
    self.btnWeiDu.selected = NO;
    btm.selected = YES;
    self.btnWeiDu = btm;
    
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.startPosition = scrollView.contentOffset.x;
//    LTLLog(@"结束 %f",scrollView.contentOffset.x);
}

#pragma mark - 处理搜索数据

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[NSNotificationCenter defaultCenter]postNotificationName:LTLExitKeyboard object:nil];
}


@end
