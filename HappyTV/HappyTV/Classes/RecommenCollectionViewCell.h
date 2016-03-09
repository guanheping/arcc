//
//  RecommenCollectionViewCell.h
//  HappyTV
//
//  Created by allenariel on 15/5/1.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecommenCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *howLable;
@property (weak, nonatomic) IBOutlet UILabel *moreLabel;
+(NSString *)myIdentify;
@end
