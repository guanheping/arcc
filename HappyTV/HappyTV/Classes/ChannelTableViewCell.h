//
//  ChannelTableViewCell.h
//  HappyTV
//
//  Created by allenariel on 15/5/6.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelTableViewCell : UITableViewCell
+(NSString *)myIdentify;
+(CGFloat)myHeight;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *moreLabel;
@property (weak, nonatomic) IBOutlet UILabel *howLabel;

@end
