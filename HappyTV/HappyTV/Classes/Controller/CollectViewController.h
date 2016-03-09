//
//  CollectViewController.h
//  HappyTV
//
//  Created by allenariel on 15/5/7.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "RootTwoViewController.h"
#import "MyDatabaseQueue.h"

@interface CollectViewController : RootTwoViewController
@property(nonatomic,assign)RecordType type;
@property(nonatomic,copy)NSString *nameTitle;

@end
