//
//  MyDatabaseQueue.m
//  4_1数据库多线程安全
//
//  Created by allen on 15-4-1.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "MyDatabaseQueue.h"
#import "FMDatabaseQueue.h"
#import "FMDatabase.h"
#import "MoreDetailModel.h"
//#import "HistoryModel.h"

static MyDatabaseQueue *single=nil;

@implementation MyDatabaseQueue

+(id)shareInstance
{
    //多线程安全的写法
    @synchronized(self){
    if (single==nil) {
        
        single=[[MyDatabaseQueue alloc]init];
        }
    }
    return single;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *dataPath=[NSHomeDirectory() stringByAppendingString:@"/Documents/happytv.db"];
        NSLog(@"%@",dataPath);
        _dbQueue=[FMDatabaseQueue databaseQueueWithPath:dataPath];
        NSLog(@"_dbQueue %@",_dbQueue);
        
        NSString *sql=@"CREATE TABLE if not exists fav4 (ID integer primary key autoincrement ,aid varchar(128),name varchar(128),categoryname varchar(128),vt integer,recordType integer);";
        
        [_dbQueue inDatabase:^(FMDatabase *_db) {
            BOOL symbol=[_db executeUpdate:sql];
            if (symbol) {
                NSLog(@"创建表1成功");
            }
            else
                NSLog(@"创建表1失败");
            }];
        }
    NSString *sql1=@"CREATE TABLE if not exists his (ID integer primary key autoincrement ,text varchar(128));";
    [_dbQueue inDatabase:^(FMDatabase *_db) {
        BOOL symbol=[_db executeUpdate:sql1];
        if (symbol) {
            NSLog(@"创建表2成功");
        }
        else
            NSLog(@"创建表2失败");
    }];


    return self;
}

-(void)addModel:(MoreDetailModel *)model
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL symbol=[db executeUpdate:@"insert into fav2 (aid,name,categoryname,vt) values(?,?,?,?);",model.aid,model.name,model.categoryname,model.vt];
        if (symbol) {
            NSLog(@"数据添加成功");
        }
        else
            NSLog(@"数据添加失败");
    }];
}

-(void)deleteModel:(MoreDetailModel *)model
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL symbol=[db executeUpdate:@"delete from fav2 where aid=?;",model.aid];
        if (symbol) {
            NSLog(@"删除成功");
        }
        else
            NSLog(@"删除失败");
    }];
}

-(NSArray *)getAllData
{
    NSMutableArray *array=[NSMutableArray array];
    NSString *sql=@"select *from fav2";
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set=[db executeQuery:sql];
    
        while ([set next]) {
            NSString *name=[set stringForColumn:@"name"];
            NSString *aid=[set stringForColumn:@"aid"];
            NSString *categoryname=[set stringForColumn:@"categoryname"];
            int vt=[set intForColumn:@"vt"];
            
            MoreDetailModel *cell=[[MoreDetailModel alloc]init];
            cell.aid=aid;
            cell.name=name;
            cell.categoryname=categoryname;
            cell.vt=[NSNumber numberWithInt:vt];
            [array addObject:cell];
        }
    }];
    return array;
}

-(void)addtext:(NSString *)text
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL symbol=[db executeUpdate:@"insert into his (text) values(?);",text];
        if (symbol) {
            NSLog(@"数据2添加成功");
        }
        else
            NSLog(@"数据2添加失败");
    }];

}
-(void)deletetext:(NSString *)text
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL symbol=[db executeUpdate:@"delete from his where text=? ;",text];
        if (symbol) {
            NSLog(@"数据2删除成功");
        }
        else
            NSLog(@"数据2删除失败");
    }];

}
-(void)deleteAlltext
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL symbol=[db executeUpdate:@"delete from his ;"];
        if (symbol) {
            NSLog(@"数据2全部删除成功");
        }
        else
            NSLog(@"数据2全部删除失败");
    }];
}
-(NSArray *)getAlltext
{
    NSMutableArray *array=[NSMutableArray array];
    NSString *sql=@"select *from his";
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set=[db executeQuery:sql];
        
        while ([set next]) {
            NSString *text=[set stringForColumn:@"text"];
            
            [array addObject:text];
        }
    }];
    return array;
}
//=========
-(BOOL)isExistsWithtext:(NSString *)text
{
    __block  BOOL a;
    a=NO;
    NSString *sql=@"select * from his where text=?";
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set=[db executeQuery:sql,text];
        
        while ([set next]) {
            a=YES;
        }
        
    }];
    return a;
}



-(void)addModel:(MoreDetailModel *)model recordType:(RecordType)type
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL symbol=[db executeUpdate:@"insert into fav4 (aid,name,categoryname,vt,recordType) values(?,?,?,?,?);",model.aid,model.name,model.categoryname,model.vt,[NSString stringWithFormat:@"%d",type]];
        if (symbol) {
            NSLog(@"数据1添加成功");
        }
        else
            NSLog(@"数据1添加失败");
    }];
}



-(void)deleteModel:(MoreDetailModel *)model recordType:(RecordType)type
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL symbol=[db executeUpdate:@"delete from fav4 where aid=? and recordType=?;",model.aid,[NSString stringWithFormat:@"%d",type]];
        if (symbol) {
            NSLog(@"数据1删除成功");
        }
        else
            NSLog(@"数据1删除失败");
    }];
}

-(void)deleteAllModelrecordType:(RecordType)type
{
    [_dbQueue inDatabase:^(FMDatabase *db) {
        BOOL symbol=[db executeUpdate:@"delete from fav4 where recordType=?;",[NSString stringWithFormat:@"%d",type]];
        if (symbol) {
            NSLog(@"数据1全部删除成功");
        }
        else
            NSLog(@"数据1全部删除失败");
    }];

}
-(NSArray *)getAllDataWithRecordType:(RecordType)type
{
    NSMutableArray *array=[NSMutableArray array];
    NSString *sql=@"select *from fav4 where recordType=?";
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set=[db executeQuery:sql,[NSString stringWithFormat:@"%d",type]];
        
        while ([set next]) {
            NSString *name=[set stringForColumn:@"name"];
            NSString *aid=[set stringForColumn:@"aid"];
            NSString *categoryname=[set stringForColumn:@"categoryname"];
            int vt=[set intForColumn:@"vt"];
            
            MoreDetailModel *cell=[[MoreDetailModel alloc]init];
            cell.aid=aid;
            cell.name=name;
            cell.categoryname=categoryname;
            cell.vt=[NSNumber numberWithInt:vt];
            [array addObject:cell];
        }
    }];
    return array;
}
//判断是否存在
-(BOOL)isExistsWithAppMpdel:(MoreDetailModel *)model recordType:(RecordType)recordType
{
    __block  BOOL a;
    a=NO;
    NSString *sql=@"select * from fav4 where aid=? and recordType=?";
    [_dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet *set=[db executeQuery:sql,model.aid,[NSString stringWithFormat:@"%d",recordType]];
        
        while ([set next]) {
            a=YES;
        }
    }];
    return a;
}


@end
