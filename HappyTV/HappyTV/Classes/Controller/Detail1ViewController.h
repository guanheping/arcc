//
//  Detail1ViewController.h
//  HappyTV
//
//  Created by allenariel on 15/5/3.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootTwoViewController.h"

#import "StarView.h"
@interface Detail1ViewController : RootTwoViewController

@property(nonatomic,strong)NSString *aid;
@property(nonatomic,strong)NSString *vt;
@property (weak, nonatomic) IBOutlet UIScrollView *scrolView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;
@property (weak, nonatomic) IBOutlet StarView *starView;
@property (weak, nonatomic) IBOutlet UILabel *whereLabel;
@property (weak, nonatomic) IBOutlet UILabel *whenLabel;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UIView *backView;


@property (weak, nonatomic) IBOutlet UIView *allBoFangView;
@property (weak, nonatomic) IBOutlet UIImageView *boFangImageView;
@property (weak, nonatomic) IBOutlet UILabel *boFangLabel;

- (IBAction)playClick:(id)sender;

@end
