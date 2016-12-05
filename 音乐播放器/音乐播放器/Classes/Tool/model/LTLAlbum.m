//
//	LTLAlbum.m
//
//	Create by LiTaiLiang on 27/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "LTLAlbum.h"

NSString *const kLTLAlbumAlbumTitle = @"album_title";
NSString *const kLTLAlbumCategoryName = @"category_name";
NSString *const kLTLAlbumCoverUrlSmall = @"cover_url_small";
NSString *const kLTLAlbumHighlightAlbumTitle = @"highlight_album_title";
NSString *const kLTLAlbumIdField = @"id";

@interface LTLAlbum ()
@end
@implementation LTLAlbum




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kLTLAlbumAlbumTitle] isKindOfClass:[NSNull class]]){
		self.albumTitle = dictionary[kLTLAlbumAlbumTitle];
	}	
	if(![dictionary[kLTLAlbumCategoryName] isKindOfClass:[NSNull class]]){
		self.categoryName = dictionary[kLTLAlbumCategoryName];
	}	
	if(![dictionary[kLTLAlbumCoverUrlSmall] isKindOfClass:[NSNull class]]){
		self.coverUrlSmall = dictionary[kLTLAlbumCoverUrlSmall];
	}	
	if(![dictionary[kLTLAlbumHighlightAlbumTitle] isKindOfClass:[NSNull class]]){
		self.highlightAlbumTitle = dictionary[kLTLAlbumHighlightAlbumTitle];
	}	
	if(![dictionary[kLTLAlbumIdField] isKindOfClass:[NSNull class]]){
		self.idField = [dictionary[kLTLAlbumIdField] integerValue];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.albumTitle != nil){
		dictionary[kLTLAlbumAlbumTitle] = self.albumTitle;
	}
	if(self.categoryName != nil){
		dictionary[kLTLAlbumCategoryName] = self.categoryName;
	}
	if(self.coverUrlSmall != nil){
		dictionary[kLTLAlbumCoverUrlSmall] = self.coverUrlSmall;
	}
	if(self.highlightAlbumTitle != nil){
		dictionary[kLTLAlbumHighlightAlbumTitle] = self.highlightAlbumTitle;
	}
	dictionary[kLTLAlbumIdField] = @(self.idField);
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
	if(self.albumTitle != nil){
		[aCoder encodeObject:self.albumTitle forKey:kLTLAlbumAlbumTitle];
	}
	if(self.categoryName != nil){
		[aCoder encodeObject:self.categoryName forKey:kLTLAlbumCategoryName];
	}
	if(self.coverUrlSmall != nil){
		[aCoder encodeObject:self.coverUrlSmall forKey:kLTLAlbumCoverUrlSmall];
	}
	if(self.highlightAlbumTitle != nil){
		[aCoder encodeObject:self.highlightAlbumTitle forKey:kLTLAlbumHighlightAlbumTitle];
	}
	[aCoder encodeObject:@(self.idField) forKey:kLTLAlbumIdField];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.albumTitle = [aDecoder decodeObjectForKey:kLTLAlbumAlbumTitle];
	self.categoryName = [aDecoder decodeObjectForKey:kLTLAlbumCategoryName];
	self.coverUrlSmall = [aDecoder decodeObjectForKey:kLTLAlbumCoverUrlSmall];
	self.highlightAlbumTitle = [aDecoder decodeObjectForKey:kLTLAlbumHighlightAlbumTitle];
	self.idField = [[aDecoder decodeObjectForKey:kLTLAlbumIdField] integerValue];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	LTLAlbum *copy = [LTLAlbum new];

	copy.albumTitle = [self.albumTitle copy];
	copy.categoryName = [self.categoryName copy];
	copy.coverUrlSmall = [self.coverUrlSmall copy];
	copy.highlightAlbumTitle = [self.highlightAlbumTitle copy];
	copy.idField = self.idField;

	return copy;
}

-(void)setHighlightAlbumTitle:(NSString *)highlightAlbumTitle
{
    _highlightAlbumTitle = highlightAlbumTitle;
    if (highlightAlbumTitle != nil )
    {
        self.AttributedHighlightAlbumTitle = [highlightAlbumTitle highlightKey:self.albumTitle];
    }
}

@end
