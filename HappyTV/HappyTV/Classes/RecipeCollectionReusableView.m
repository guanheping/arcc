//
//  RecipeCollectionReusableView.m
//  HappyTV
//
//  Created by allenariel on 15/5/1.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "RecipeCollectionReusableView.h"

@implementation RecipeCollectionReusableView

+(NSString *)myIdentify
{
    return @"reuseablecell";
}
- (IBAction)moreBtnClick:(id)sender {
    _myBlock();
    
}
@end
