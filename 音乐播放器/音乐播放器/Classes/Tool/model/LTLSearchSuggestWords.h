//
//	LTLSearchSuggestWords.h
//
//	Create by LiTaiLiang on 27/11/2016
//	Copyright © 2016. All rights reserved.
//

//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "LTLAlbum.h"
#import "LTLKeyword.h"

@interface LTLSearchSuggestWords : NSObject

@property (nonatomic, assign) NSInteger albumTotalCount;
@property (nonatomic, strong) NSArray * albums;
@property (nonatomic, assign) NSInteger keywordTotalCount;
@property (nonatomic, strong) NSArray * keywords;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
