//
//  MyDataBase.m
//  3_29数据库FMDB
//
//  Created by allen on 15-3-31.
//  Copyright (c) 2015年 明烙华. All rights reserved.
//

#import "MyDataBase.h"
#import "MoreDetailModel.h"

static MyDataBase *single;

@implementation MyDataBase
+(id)shareInstance
{
    if (single==nil) {
        single=[[MyDataBase alloc]init];
    }
    return single;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        //1、设置数据库名称
        NSString *dataPath=[NSHomeDirectory() stringByAppendingString:@"/Documents/qfstu_1314.db"];
        //2、创建数据库对象
        _db=[FMDatabase databaseWithPath:dataPath];
        //3、打开数据库
        BOOL ret =[_db open];
        if (ret==NO) {
            NSLog(@"打开失败");
        }
        NSLog(@"数据库路径%@",dataPath);
        //4、创建一张表
        NSString *sql=@"CREATE TABLE if not exists QFStu (ID integer primary key autoincrement ,aid varchar(128),name varchar(128));";

        if(![_db executeUpdate:sql])
        {
            NSLog(@"创建表失败");
        }
    }
    return self;
}


-(void)addDataCell:(MoreDetailModel *)model
{
    NSLog(@"%@ %@",model.aid,model.name);
    if(![_db executeUpdate:@"insert into QFStu(aid,name) values(?,?);",model.aid,model.name])
    {
        NSLog(@"添加失败");
    }
}

-(void)deleteDataCell:(MoreDetailModel *)model
{
    [_db executeUpdate:@"delete from QFNew where aid=?",model.aid];
}

-(NSArray *)getAllDataCell
{
    NSMutableArray *arr=[NSMutableArray array];
    FMResultSet *set= [_db executeQuery:@"select *from QFStu"];
    while ([set next]) {
        NSString *name=[set stringForColumn:@"name"];
        NSString *aid=[set stringForColumn:@"aid"];
        
        MoreDetailModel *cell=[[MoreDetailModel alloc]init];
        cell.aid=aid;
        cell.name=name;
        [arr addObject:cell];
    }
    return arr;
}

@end
