//
//  SearchTableViewCell.m
//  HappyTV
//
//  Created by allenariel on 15/5/10.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "SearchTableViewCell.h"

@implementation SearchTableViewCell

+(CGFloat)myHeight
{
    return 100;
}

+(NSString *)myIdentify
{
    return @"searchcell";
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [[NSBundle mainBundle]loadNibNamed:@"SearchTableViewCell" owner:self options:nil][0];
}
@end
