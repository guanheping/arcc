//
//  TopicViewController.m
//  HappyTV
//
//  Created by allenariel on 15/4/30.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "TopicViewController.h"
#import "TopicTableViewCell.h"
#import "DeTopicViewController.h"
@interface TopicViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSArray *_rootArray;
}
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation TopicViewController

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
    _tableView.frame=CGRectMakeEx(0, 0, 320, 500);
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
    TopicTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[TopicTableViewCell myIdentify]];
    if (cell==nil) {
        cell=[[TopicTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[TopicTableViewCell myIdentify]];
    }
    NSDictionary *dict=_rootArray[indexPath.row];
    
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:dict[@"pic"]]];
    cell.nameLabel.text=dict[@"name"];
    cell.nameLabel.font=[UIFont boldSystemFontOfSize:16];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [TopicTableViewCell myHeight];
}

-(void)startDownloadData
{
    [SVProgressHUD showWithStatus:@"正在加载中"];
    NSString *urlString=[NSString stringWithFormat:TOPIC_URL];
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
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"点击重新加载", nil];
        
        [alertView show];
    }];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [self startDownloadData];
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DeTopicViewController *dvc=[[DeTopicViewController alloc]init];
    
    dvc.themeid=_rootArray[indexPath.row][@"themeid"];
    
    [self.navigationController pushViewController:dvc animated:YES];
    
    
}

@end
