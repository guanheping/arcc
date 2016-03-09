//
//  MoreViewController.m
//  HappyTV
//
//  Created by allenariel on 15/4/30.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "MoreViewController.h"
#import "CollectViewController.h"

@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
}
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
}
-(void)createTableView
{
    _tableView=[[UITableView alloc]init];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.frame=self.view.bounds;
    _tableView.scrollEnabled=NO;
    [self.view addSubview:_tableView];
}
#pragma mark - tableview的数据源方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *ID=@"abc";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.textLabel.text=@"收藏";
    cell.imageView.image=[UIImage imageNamed:@"favorites_cell_icon@2x.png"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        CollectViewController *cvc=[[CollectViewController alloc]init];
        cvc.type=RecordTypeFav;
        cvc.nameTitle=@"收藏夹";   
        [self.navigationController pushViewController:cvc animated:YES];
    }
}
@end
