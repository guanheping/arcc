//
//  Search2TableViewCell.m
//  HappyTV
//
//  Created by allenariel on 15/5/10.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "Search2TableViewCell.h"

@implementation Search2TableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(NSString *)myIdentify
{
    return @"search2cell";
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [[NSBundle mainBundle]loadNibNamed:@"Search2TableViewCell" owner:self options:nil][0];
}
@end
