//
//  MyDataBase.h
//  3_29数据库FMDB
//
//  Created by allen on 15-3-31.
//  Copyright (c) 2015年 明烙华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@class MoreDetailModel;
@interface MyDataBase : NSObject
{
    FMDatabase *_db;
    
}
+(id)shareInstance;

-(void)addDataCell:(MoreDetailModel *)model;
-(void)deleteDataCell:(MoreDetailModel *)model;

-(NSArray *)getAllDataCell;


@end
