//
//  ChartsCollectionViewCell.h
//  HappyTV
//
//  Created by allenariel on 15/5/7.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartsCollectionViewCell : UICollectionViewCell
+(NSString *)myIdentify;
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UIButton *mainNameBtn;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *name1Label;
@property (weak, nonatomic) IBOutlet UILabel *name2Label;
@property (weak, nonatomic) IBOutlet UILabel *name3Label;
@property (weak, nonatomic) IBOutlet UILabel *name4Label;
@property (weak, nonatomic) IBOutlet UILabel *name5Label;

@end
