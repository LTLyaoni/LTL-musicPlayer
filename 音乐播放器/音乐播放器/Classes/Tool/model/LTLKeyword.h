//
//	LTLKeyword.h
//
//	Create by LiTaiLiang on 27/11/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface LTLKeyword : NSObject

@property (nonatomic, strong) NSString * highlightKeyword;

@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, strong) NSString * keyword;
//创建带有属性的字符串
@property (nonatomic, strong) NSMutableAttributedString *AttributedHighlightAlbumTitle;


-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
