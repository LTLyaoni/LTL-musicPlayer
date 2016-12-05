//
//	LTLSearchSuggestWords.m
//
//	Create by LiTaiLiang on 27/11/2016
//	Copyright © 2016. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "LTLSearchSuggestWords.h"

NSString *const kLTLSearchSuggestWordsAlbumTotalCount = @"album_total_count";
NSString *const kLTLSearchSuggestWordsAlbums = @"albums";
NSString *const kLTLSearchSuggestWordsKeywordTotalCount = @"keyword_total_count";
NSString *const kLTLSearchSuggestWordsKeywords = @"keywords";

@interface LTLSearchSuggestWords ()
@end
@implementation LTLSearchSuggestWords




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kLTLSearchSuggestWordsAlbumTotalCount] isKindOfClass:[NSNull class]]){
		self.albumTotalCount = [dictionary[kLTLSearchSuggestWordsAlbumTotalCount] integerValue];
	}

	if(dictionary[kLTLSearchSuggestWordsAlbums] != nil && [dictionary[kLTLSearchSuggestWordsAlbums] isKindOfClass:[NSArray class]]){
		NSArray * albumsDictionaries = dictionary[kLTLSearchSuggestWordsAlbums];
		NSMutableArray * albumsItems = [NSMutableArray array];
		for(NSDictionary * albumsDictionary in albumsDictionaries){
			LTLAlbum * albumsItem = [[LTLAlbum alloc] initWithDictionary:albumsDictionary];
			[albumsItems addObject:albumsItem];
		}
		self.albums = albumsItems;
	}
	if(![dictionary[kLTLSearchSuggestWordsKeywordTotalCount] isKindOfClass:[NSNull class]]){
		self.keywordTotalCount = [dictionary[kLTLSearchSuggestWordsKeywordTotalCount] integerValue];
	}

	if(dictionary[kLTLSearchSuggestWordsKeywords] != nil && [dictionary[kLTLSearchSuggestWordsKeywords] isKindOfClass:[NSArray class]]){
		NSArray * keywordsDictionaries = dictionary[kLTLSearchSuggestWordsKeywords];
		NSMutableArray * keywordsItems = [NSMutableArray array];
		for(NSDictionary * keywordsDictionary in keywordsDictionaries){
			LTLKeyword * keywordsItem = [[LTLKeyword alloc] initWithDictionary:keywordsDictionary];
			[keywordsItems addObject:keywordsItem];
		}
		self.keywords = keywordsItems;
	}
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	dictionary[kLTLSearchSuggestWordsAlbumTotalCount] = @(self.albumTotalCount);
	if(self.albums != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(LTLAlbum * albumsElement in self.albums){
			[dictionaryElements addObject:[albumsElement toDictionary]];
		}
		dictionary[kLTLSearchSuggestWordsAlbums] = dictionaryElements;
	}
	dictionary[kLTLSearchSuggestWordsKeywordTotalCount] = @(self.keywordTotalCount);
	if(self.keywords != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(LTLKeyword * keywordsElement in self.keywords){
			[dictionaryElements addObject:[keywordsElement toDictionary]];
		}
		dictionary[kLTLSearchSuggestWordsKeywords] = dictionaryElements;
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
	[aCoder encodeObject:@(self.albumTotalCount) forKey:kLTLSearchSuggestWordsAlbumTotalCount];	if(self.albums != nil){
		[aCoder encodeObject:self.albums forKey:kLTLSearchSuggestWordsAlbums];
	}
	[aCoder encodeObject:@(self.keywordTotalCount) forKey:kLTLSearchSuggestWordsKeywordTotalCount];	if(self.keywords != nil){
		[aCoder encodeObject:self.keywords forKey:kLTLSearchSuggestWordsKeywords];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.albumTotalCount = [[aDecoder decodeObjectForKey:kLTLSearchSuggestWordsAlbumTotalCount] integerValue];
	self.albums = [aDecoder decodeObjectForKey:kLTLSearchSuggestWordsAlbums];
	self.keywordTotalCount = [[aDecoder decodeObjectForKey:kLTLSearchSuggestWordsKeywordTotalCount] integerValue];
	self.keywords = [aDecoder decodeObjectForKey:kLTLSearchSuggestWordsKeywords];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	LTLSearchSuggestWords *copy = [LTLSearchSuggestWords new];

	copy.albumTotalCount = self.albumTotalCount;
	copy.albums = [self.albums copy];
	copy.keywordTotalCount = self.keywordTotalCount;
	copy.keywords = [self.keywords copy];

	return copy;
}
@end