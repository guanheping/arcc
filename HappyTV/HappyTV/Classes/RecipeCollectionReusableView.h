//
//  RecipeCollectionReusableView.h
//  HappyTV
//
//  Created by allenariel on 15/5/1.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeCollectionReusableView : UICollectionReusableView
+(NSString *)myIdentify;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;
- (IBAction)moreBtnClick:(id)sender;
@property(nonatomic,copy)void(^myBlock)(void);

@end
