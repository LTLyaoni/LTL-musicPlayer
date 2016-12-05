//
//  代码地址: https://github.com/iphone5solo/PYSearch
//  代码地址: http://www.code4app.com/thread-11175-1-1.html
//  Created by CoderKo1o.
//  Copyright © 2016年 iphone5solo. All rights reserved.
//

#import "PYSearchSuggestionViewController.h"
#import "PYSearchConst.h"


@interface PYSearchSuggestionViewController ()
//数据
@property(nonatomic,strong) LTLSearchSuggestWords *model;

@end
   static NSString *cellID = @"PYSearchSuggestionCellID";

@implementation PYSearchSuggestionViewController

+ (instancetype)searchSuggestionViewControllerWithDidSelectCellBlock:(PYSearchSuggestionDidSelectCellBlock)didSelectCellBlock
{
    PYSearchSuggestionViewController *searchSuggestionVC = [[PYSearchSuggestionViewController alloc] init];
    searchSuggestionVC.didSelectCellBlock = didSelectCellBlock;
    return searchSuggestionVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self receiveNotification];
    // 取消分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
}
///接受通知
-(void)receiveNotification
{
    // 开启一个通知接受
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushView:) name:@"SearchSuggestWords" object:nil];
}
-(void)pushView:(NSNotification *)notification
{
    LTLSearchSuggestWords *model = notification.userInfo[@"SearchSuggestWords"];
    self.model = model;
    [self.tableView reloadData];
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title ;
   
    if (self.model)
    {
        if (self.model.albumTotalCount != 0)
        {
            switch (section)
            {
                case 0:
                   title = @"专辑";
                    break;
                case 1:
                    title = @"相关";;
                    break;
            }
        }
        else
        {
            title = @"相关";
        }
    }
    else
    {
        title = @"搜索";
    }
    
    return title;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32;
}

- (void)setSearchSuggestions:(NSArray<NSString *> *)searchSuggestions
{
    _searchSuggestions = searchSuggestions;
        // 刷新数据
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    NSInteger section = 0;
  
    if (self.model)
    {
        if (self.model.albumTotalCount == 0) {
            section = 1;
        } else {
            section = 2;
        }
    }
    else
    {
        section = 1;
    }
    return section;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger row = 0;
    if (self.model)
    {
        if (self.model.albumTotalCount != 0)
        {
            switch (section)
            {
                case 0:
                    row = self.model.albumTotalCount;
                    break;
                case 1:
                    row = self.model.keywordTotalCount;
                    break;
            }
        }
        else
        {
            row = self.model.keywordTotalCount;
        }
    }
    else
    {
        row = self.searchSuggestions.count;
    }
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
 
    // 创建cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID ];
    
    if (!cell) {
        cell  = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
    }
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.backgroundColor = [UIColor clearColor];
    // 添加分割线
    UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PYSearch.bundle/cell-content-line"]];
    line.py_height = 0.5;
    line.alpha = 0.7;
    line.py_x = PYMargin;
    line.py_y = 43;
    line.py_width = PYScreenW;
    [cell.contentView addSubview:line];
   
    UIImage *cellImage = PYSearchSuggestionImage;
    
    if (self.model)
    {
        
        LTLKeyword *keyword;
        NSMutableAttributedString *attributedString;
        if (self.model.albumTotalCount != 0)
        {
            switch (indexPath.section)
            {
                case 0:
                {
                    line.py_x = 88;
                    
                    LTLAlbum *album = self.model.albums[indexPath.row];
                    attributedString = album.AttributedHighlightAlbumTitle;
                    cell.detailTextLabel.text = album.categoryName;
                    // 设置图片
                    NSURL *url = [NSURL URLWithString:album.coverUrlSmall];
                    [cell.imageView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"LTL"]];
                    cell.imageView.contentMode = UIViewContentModeScaleAspectFit;
                    
                    break;
                }
                case 1:
                {
                    keyword = self.model.keywords[indexPath.row];
                    attributedString = keyword.AttributedHighlightAlbumTitle;
                    // 设置图片
                    cell.imageView.image = cellImage;
                    break;
                }
            }
        }
        else
        {
            keyword = self.model.keywords[indexPath.row];
            attributedString = keyword.AttributedHighlightAlbumTitle;
            // 设置图片
            cell.imageView.image = cellImage;
        }
        
        cell.textLabel.attributedText = attributedString;
    }
    
    
//    cell.textLabel.text = self.searchSuggestions[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.didSelectCellBlock) self.didSelectCellBlock([tableView cellForRowAtIndexPath:indexPath]);
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    ///发送退出键盘通知
    [[NSNotificationCenter defaultCenter] postNotificationName:LTLExitKeyboard object:nil];
}

@end
