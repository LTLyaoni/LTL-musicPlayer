//
//  LTLSearchController.m
//  音乐播放器
//
//  Created by LiTaiLiang on 16/11/27.
//  Copyright © 2016年 LiTaiLiang. All rights reserved.
//

#import "LTLSearchController.h"
#import "LTLsearchResultController.h"

@interface LTLSearchController ()<PYSearchViewControllerDelegate>

@property(nonatomic,strong) LTLsearchResultController *searchResult;

@end

@implementation LTLSearchController
///懒加载
-(LTLsearchResultController *)searchResult
{
    if (!_searchResult) {
        
        _searchResult = [[LTLsearchResultController alloc]init];;
        
        
    }
    return _searchResult;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    /** 显示搜索结果模式（默认为自定义：PYSearchResultShowModeDefault） */
    self.searchResultShowMode = PYSearchResultShowModeEmbed;
    ///** 搜索结果控制器 */
    ///转弱指针
    self.searchResultController = self.searchResult;
    //代理
    self.delegate = self;
    
    [self DataAcquisition];
}
///即将显示
-(void)viewWillAppear:(BOOL)animated
{
    self.searchResultShowMode = PYSearchResultShowModeEmbed;
    self.searchBar.placeholder = @"搜索音乐及电台和声音...";
    [super viewWillAppear:animated];
}
#pragma mark - 数据
///数据
-(void)DataAcquisition
{

    [LTLNetworkRequest SearchHotWordsdadt:^(NSArray<NSString *> * _Nullable modelArray, XMErrorModel * _Nullable error) {
        //        search.borderColor = [LTLThemeManager sharedManager].themeColor;
        self.hotSearches = modelArray;
        self.hotSearchStyle = PYHotSearchStyleARCBorderTag;
    }];

}
/** 搜索框文本变化时，显示的搜索建议通过searchViewController的searchSuggestions赋值即可 */
- (void)searchViewController:(PYSearchViewController *)searchViewController  searchTextDidChange:(UISearchBar *)seachBar searchText:(NSString *)searchText
{
    
    [LTLNetworkRequest SearchSuggestWords:searchText dadt:^(XMErrorModel * _Nullable error) {
        
    }];
}
///** 点击取消时调用 */
//- (void)didClickCancel:(PYSearchViewController *)searchViewController
//{
//
//    LTLLog(@"点击取消");
//}
/** 点击(开始)搜索时调用 */
- (void)searchViewController:(PYSearchViewController *)searchViewController didSearchWithsearchBar:(UISearchBar *)searchBar searchText:(NSString *)searchText
{
    //赋值
    self.searchResult.searchText = searchText;
    
    
}

@end
