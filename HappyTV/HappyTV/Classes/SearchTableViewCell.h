//
//  SearchTableViewCell.h
//  HappyTV
//
//  Created by allenariel on 15/5/10.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewCell : UITableViewCell
+(NSString *)myIdentify;
+(CGFloat)myHeight;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yearLabel;
@property (weak, nonatomic) IBOutlet UILabel *whoLabel;

@end
