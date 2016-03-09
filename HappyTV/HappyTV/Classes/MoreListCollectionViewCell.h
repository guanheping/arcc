//
//  MoreListCollectionViewCell.h
//  HappyTV
//
//  Created by allenariel on 15/5/6.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreListCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *howLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
+(NSString *)myIdentify;
+(CGFloat)myHeight;

@end
