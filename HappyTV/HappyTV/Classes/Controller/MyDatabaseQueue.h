//
//  MyDatabaseQueue.h
//  4_1数据库多线程安全
//
//  Created by allen on 15-4-1.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum RecordType
{
    RecordTypeFav,
    RecordTypeHis,
}RecordType;

@class FMDatabaseQueue;
@class MoreDetailModel;

@interface MyDatabaseQueue : NSObject
{
    FMDatabaseQueue *_dbQueue;
}

+(id)shareInstance;

-(void)addModel:(MoreDetailModel *)model;
-(void)deleteModel:(MoreDetailModel *)model;
-(NSArray *)getAllData;

-(void)addModel:(MoreDetailModel *)model recordType:(RecordType)type;
-(void)deleteModel:(MoreDetailModel *)model recordType:(RecordType)type;
-(void)deleteAllModelrecordType:(RecordType)type;
-(NSArray *)getAllDataWithRecordType:(RecordType)type;
-(BOOL)isExistsWithAppMpdel:(MoreDetailModel *)model recordType:(RecordType)recordType;

-(void)addtext:(NSString *)text;
-(void)deletetext:(NSString *)text;
-(void)deleteAlltext;
-(NSArray *)getAlltext;
-(BOOL)isExistsWithtext:(NSString *)text;

@end
