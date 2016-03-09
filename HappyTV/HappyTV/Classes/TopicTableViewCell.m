//
//  TopicTableViewCell.m
//  HappyTV
//
//  Created by allenariel on 15/5/7.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "TopicTableViewCell.h"

@implementation TopicTableViewCell


+(NSString *)myIdentify
{
    return @"topiccell";
}
+(CGFloat)myHeight
{
    return 120.0;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [[NSBundle mainBundle]loadNibNamed:@"TopicTableViewCell" owner:self options:nil][0];
}
@end
