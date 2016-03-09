//
//  ChannelViewController.m
//  HappyTV
//
//  Created by allenariel on 15/4/30.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "ChannelViewController.h"
#import "ChannelTableViewCell.h"
#import "MoreListViewController.h"

@interface ChannelViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSArray *_rootArray;
}
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation ChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self startDownloadData];
}
-(void)createTableView
{
    _tableView=[[UITableView alloc]init];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.frame=self.view.bounds;
    _tableView.bounces=NO;
    [self.view addSubview:_tableView];
    
}
#pragma mark - tableview的数据源方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _rootArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChannelTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[ChannelTableViewCell myIdentify]];
    if (cell==nil) {
        cell=[[ChannelTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ChannelTableViewCell myIdentify]];
    }
    NSDictionary *dict=_rootArray[indexPath.row];
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:dict[@"pic"]]];
    cell.nameLabel.text=dict[@"name"];
    cell.nameLabel.font=[UIFont boldSystemFontOfSize:18];
    cell.moreLabel.text=[NSString stringWithFormat:@"(%d)",[dict[@"total"] intValue]];
    cell.howLabel.text=dict[@"subname"];
   
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ChannelTableViewCell myHeight];
}

-(void)startDownloadData
{
    [SVProgressHUD showWithStatus:@"正在加载中"];
    NSString *urlString=[NSString stringWithFormat:CHANNEL_URL];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        _rootArray=dict[@"data"];
        [_tableView reloadData];
        [SVProgressHUD dismissWithSuccess:@"加载成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",[error description]);
        [SVProgressHUD dismissWithError:@"加载失败"];

    }];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreListViewController *mvc=[[MoreListViewController alloc]init];
    mvc.vt=_rootArray[indexPath.row][@"vt"];
    mvc.areaid=@"all";
    mvc.categoryid=@"all";
    [self.navigationController pushViewController:mvc animated:YES];
}

@end
