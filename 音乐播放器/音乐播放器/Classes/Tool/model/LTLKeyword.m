//
//	LTLKeyword.m
//
//	Create by LiTaiLiang on 27/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "LTLKeyword.h"

NSString *const kLTLKeywordHighlightKeyword = @"highlight_keyword";
NSString *const kLTLKeywordIdField = @"id";
NSString *const kLTLKeywordKeyword = @"keyword";

@interface LTLKeyword ()
@end
@implementation LTLKeyword




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kLTLKeywordHighlightKeyword] isKindOfClass:[NSNull class]]){
		self.highlightKeyword = dictionary[kLTLKeywordHighlightKeyword];
	}	
	if(![dictionary[kLTLKeywordIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kLTLKeywordIdField] integerValue];
	}

	if(![dictionary[kLTLKeywordKeyword] isKindOfClass:[NSNull class]]){
		self.keyword = dictionary[kLTLKeywordKeyword];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.highlightKeyword != nil){
		dictionary[kLTLKeywordHighlightKeyword] = self.highlightKeyword;
	}
	dictionary[kLTLKeywordIdField] = @(self.idField);
	if(self.keyword != nil){
		dictionary[kLTLKeywordKeyword] = self.keyword;
	}
	return dictionary;

}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.highlightKeyword != nil){
		[aCoder encodeObject:self.highlightKeyword forKey:kLTLKeywordHighlightKeyword];
	}
	[aCoder encodeObject:@(self.idField) forKey:kLTLKeywordIdField];	if(self.keyword != nil){
		[aCoder encodeObject:self.keyword forKey:kLTLKeywordKeyword];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.highlightKeyword = [aDecoder decodeObjectForKey:kLTLKeywordHighlightKeyword];
	self.idField = [[aDecoder decodeObjectForKey:kLTLKeywordIdField] integerValue];
	self.keyword = [aDecoder decodeObjectForKey:kLTLKeywordKeyword];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	LTLKeyword *copy = [LTLKeyword new];

	copy.highlightKeyword = [self.highlightKeyword copy];
	copy.idField = self.idField;
	copy.keyword = [self.keyword copy];

	return copy;
}

//-(void)setHighlightKeyword:(NSString *)highlightKeyword
//{
//    _highlightKeyword = highlightKeyword;
//    if (highlightKeyword != nil )
//    {
//        self.AttributedHighlightAlbumTitle = [highlightKeyword highlightKey:self.keyword];
//    }
//}

-(void)setKeyword:(NSString *)keyword
{
    _keyword = keyword;
    if (keyword != nil )
    {
        self.AttributedHighlightAlbumTitle = [self.highlightKeyword highlightKey:keyword];
    }
}

@end
