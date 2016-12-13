//
//  YTKKeyValueStore.h
//  Ape
//
//  Created by TangQiao on 12-11-6.
//  Copyright (c) 2012年 TangQiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YTKKeyValueItem : NSObject

@property (strong, nonatomic) NSString *itemId;
@property (strong, nonatomic) id itemObject;
@property (strong, nonatomic) NSDate *createdTime;

@end


@interface YTKKeyValueStore : NSObject

///初始化数据库名称
- (id)initDBWithName:(NSString *)dbName;

////与数据库路径初始化
- (id)initWithDBWithPath:(NSString *)dbPath;

///创建名称表
- (void)createTableWithName:(NSString *)tableName;

///是表存在
- (BOOL)isTableExists:(NSString *)tableName;

///明确表
- (void)clearTable:(NSString *)tableName;

///关闭
- (void)close;

///************************ Put&Get methods *****************************************
///添加一条数据
- (void)putObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName;
///读取一条数据
- (id)getObjectById:(NSString *)objectId fromTable:(NSString *)tableName;
///读取带储存信息的数据
- (YTKKeyValueItem *)getYTKKeyValueItemById:(NSString *)objectId fromTable:(NSString *)tableName;
///添加一条数据
- (void)putString:(NSString *)string withId:(NSString *)stringId intoTable:(NSString *)tableName;
///读取一条数据
- (NSString *)getStringById:(NSString *)stringId fromTable:(NSString *)tableName;
///添加一条数据
- (void)putNumber:(NSNumber *)number withId:(NSString *)numberId intoTable:(NSString *)tableName;
///读取
- (NSNumber *)getNumberById:(NSString *)numberId fromTable:(NSString *)tableName;
//读取所有数据
- (NSArray *)getAllItemsFromTable:(NSString *)tableName;


///删除某条数据
- (void)deleteObjectById:(NSString *)objectId fromTable:(NSString *)tableName;
///删除一组数据
- (void)deleteObjectsByIdArray:(NSArray *)objectIdArray fromTable:(NSString *)tableName;
////
- (void)deleteObjectsByIdPrefix:(NSString *)objectIdPrefix fromTable:(NSString *)tableName;


/**
 * ------------------------"  存入  " -----------------------
 */
///ZM_Add 存入单个模型
- (void)putModelObject:(id)object withId:(NSString *)objectId intoTable:(NSString *)tableName;

///ZM_Add 存入模型数组：一个Model一个Id
- (void)putModelObjectArray:(NSArray *)objectArray withIdArray:(NSArray *)objectIdArray intoTable:(NSString *)tableName;
///ZM_Add 存入模型数组：只用一个Id
- (void)putModelObjectArray:(NSArray *)objectArray intoTable:(NSString *)tableName;

/**
 * ------------------------"  取出  "-----------------------
 */
///ZM_Add 根据一个Id取出一个模型对象
- (id)getModelObjectById:(NSString *)objectId className:(Class)className fromTable:(NSString *)tableName;

///ZM_Add 根据一个表名取出一个数组模型对象
- (id)getModelArrayByclassName:(Class)className fromTable:(NSString *)tableName arrayCount:(int)arrayCount;

///ZM_Add 根据一个表名取出一个数组模型对象
- (id)getModelArrayByclassName:(Class)className fromTable:(NSString *)tableName;
///ZM_Add
- (NSArray *)getItemsFromTable:(NSString *)tableName withRange:(NSRange)range;

//ZM_Add 表是否存在
- (BOOL)isExistTableWithName:(NSString *)tableName;


/**
 *  --------------------------"  删除  "----------------------
 */
///ZM_Add  删除表
- (BOOL)deleteTable:(NSString *)tableName;

// 清除表-清数据
- (BOOL) eraseTable:(NSString *)tableName;

///ZM_Add  删除数据库
- (void)deleteDatabseWithDBName:(NSString *)DBName;

/// 获取表库的路径
- (NSString *)getDBPath;

@end








