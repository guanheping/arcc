//
//  ChannelTableViewCell.m
//  HappyTV
//
//  Created by allenariel on 15/5/6.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "ChannelTableViewCell.h"

@implementation ChannelTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(NSString *)myIdentify
{
    return @"channelcell";
}
+(CGFloat)myHeight
{
    return 90.0;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
 
    return [[NSBundle mainBundle]loadNibNamed:@"ChannelTableViewCell" owner:self options:nil][0];
}
@end
