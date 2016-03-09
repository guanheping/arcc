//
//  SearchViewController.m
//  HappyTV
//
//  Created by allenariel on 15/5/9.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "SearchViewController.h"
#import "DetailModel.h"
#import "MyDatabaseQueue.h"
#import "SearchTableViewCell.h"
#import "Search2TableViewCell.h"
#import "LCButton.h"
#import "Detail1ViewController.h"
//#import "Detail2ViewController.h"

@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UITextFieldDelegate>
{
    NSString *_tableHeadString;
    NSDictionary *_rootDict;
    NSDictionary *_rootDict2;
    BOOL _tableSymbol;
    BOOL _tableSymbol2;
    UIImageView *_btnImageView;
    UILabel *_headLable;
    UIView *_headView1;
}
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)NSMutableArray *dataArrayHis;
@property(nonatomic,strong)NSMutableArray *dataArrayNew;
@property(nonatomic,strong)NSMutableArray *selectBtnArr;

@property(nonatomic,strong)UISearchBar *searchBar;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)MyDatabaseQueue *queue;
@end

@implementation SearchViewController
-(MyDatabaseQueue *)queue
{
    if (_queue==nil) {
        _queue=[MyDatabaseQueue shareInstance];
    }
    return _queue;
}
-(NSMutableArray *)dataArrayHis
{
    if (_dataArrayHis==nil) {
        _dataArrayHis=[NSMutableArray array];
    }
    return _dataArrayHis;
}
-(NSMutableArray *)dataArray
{
    if (_dataArray==nil) {
        _dataArray=[NSMutableArray array];
    }
    return _dataArray;
}
-(NSMutableArray *)dataArrayNew
{
    if (_dataArrayNew==nil) {
    _dataArrayNew=[NSMutableArray array];
    }
    return _dataArrayNew;
}
-(NSMutableArray *)selectBtnArr
{
    if (_selectBtnArr==nil) {
        _selectBtnArr=[NSMutableArray array];
    }
    return _selectBtnArr;
}
-(UITableView *)tableView
{
    CGSize size=[UIScreen mainScreen].bounds.size;
    if (_tableView==nil) {
        _tableView=[[UITableView alloc]init];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor=[UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1];
        _tableView.frame=CGRectMake(0, 60, size.width, size.height-60);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        [self createHeadView1];
        [self setExtraCellLineHidden:_tableView];
    }
    return _tableView;
}
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
-(void)createHeadView2
{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMakeEx(0, 0, 320, 30)];
    NSArray *array=@[@"全部",@"电视剧",@"电影",@"动漫",@"综艺"];
    for (int i=0; i<5; i++) {
        LCButton *btn=[LCButton buttonWithType:UIButtonTypeCustom];
        btn.tag=510+i;
        if (i==0){
            btn.selected=YES;
            [self.selectBtnArr addObject:btn];
        }
        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(changeChannel:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
        btn.frame=CGRectMakeEx(20+i*50, 0, 50, 30);
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [view addSubview:btn];
    }
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMakeEx(0, 30, 320, 1)];
    imageView.image=[UIImage imageNamed:@"fenge1.png"];
    [view addSubview:imageView];
    self.tableView.tableHeaderView=view;
}
-(void)createHeadView1
{
    _headView1=[[UIView alloc]initWithFrame:CGRectMakeEx(0, 0, 320, 30)];
    _headLable=[[UILabel alloc]initWithFrame:CGRectMakeEx(0, 0, 200, 30)];
    _headLable.font=[UIFont systemFontOfSize:16];
    _headLable.textColor=[UIColor grayColor];
    UIImageView *imageView1=[[UIImageView alloc]initWithFrame:CGRectMakeEx(0, 30, 320, 1)];
    imageView1.image=[UIImage imageNamed:@"fenge1.png"];
    [_headView1 addSubview:imageView1];
    [_headView1 addSubview:_headLable];
    self.tableView.tableHeaderView=_headView1;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor=[UIColor whiteColor];
    _tableSymbol=NO;
    _tableSymbol2=NO;
    [self createSearch];
    [self startDownloadData];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden=NO;
}

-(void)createSearch
{
    CGSize size=[UIScreen mainScreen].bounds.size;
    if (_searchBar==nil) {
        _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 20, size.width, 40)];
        [self.view addSubview:_searchBar];
        _searchBar.delegate=self;
        _searchBar.showsCancelButton=YES;
    }
}

#pragma mark - 第一次下载数据 显示热门搜索
-(void)startDownloadData
{
    NSString *urlString=[NSString stringWithFormat:SEARCH_URL];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _rootDict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array=_rootDict[@"data"][@"data"];
        _tableHeadString=_rootDict[@"data"][@"recname"];
        
        for (NSDictionary *dd in array) {
            DetailModel *model=[[DetailModel alloc]init];
            [model setValuesForKeysWithDictionary:dd];
            [self.dataArray addObject:model];
        }
        _tableView=self.tableView;
        _headLable.text=[NSString stringWithFormat:@"   • %@",_tableHeadString];

        [self.tableView reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",[error description]);
    }];
}


#pragma mark - tableview的数据源方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_tableSymbol) {
        return self.dataArrayNew.count;//搜索
    }
    else if(_tableSymbol2)
    {
        return self.dataArrayHis.count+1;//历史
    }
    else
        return self.dataArray.count;//最新加载
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (_tableSymbol) {
        SearchTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:[SearchTableViewCell myIdentify]];
        if (cell==nil) {
            cell=[[SearchTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[SearchTableViewCell myIdentify]];
        }
        DetailModel *model=self.dataArrayNew[indexPath.row];
        [cell.iconImageView setImageWithURL:[NSURL URLWithString:model.poster]];
        cell.nameLabel.text=model.name;
        cell.yearLabel.text=[NSString stringWithFormat:@"年代:%@",model.releasedate];
        cell.backgroundColor=[UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1];
        if ([model.vt intValue]==4){
            if ([model.starringname isEqualToString:@""]) {
                cell.whoLabel.text=[NSString stringWithFormat:@"主持人:暂无"];
            }
            else
            {
                cell.whoLabel.text=[NSString stringWithFormat:@"主持人:%@",model.starringname];
            }
        }
        else{
            if ([model.starringname isEqualToString:@""]) {
                cell.whoLabel.text=[NSString stringWithFormat:@"主演:暂无"];
            }
            else
                cell.whoLabel.text=[NSString stringWithFormat:@"主演:%@",model.starringname];
        }
        return cell;
    }
    else if(_tableSymbol2)
    {
        if (indexPath.row==self.dataArrayHis.count) {
            Search2TableViewCell *cell=[[Search2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[Search2TableViewCell myIdentify]];
            return cell;
        }
        NSString *ID=@"abc";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        DetailModel *model=self.dataArrayHis[indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:16];
        cell.textLabel.textColor=[UIColor grayColor];
        cell.textLabel.text=model.name;
        cell.backgroundColor=[UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1];
        return cell;
    }
    else
    {
        NSString *ID=@"abc";
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
        if (cell==nil) {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        DetailModel *model=self.dataArray[indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:16];
        cell.textLabel.textColor=[UIColor grayColor];
        cell.textLabel.text=model.name;
        cell.backgroundColor=[UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1];
        return cell;

    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tableSymbol) {
        return 100;
    }
    return 30;
}


//点击tableView的cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_tableSymbol) {
        DetailModel *model=self.dataArrayNew[indexPath.row];

        
        Detail1ViewController *dvc=[[Detail1ViewController alloc]init];
        dvc.aid=model.aid;
        dvc.vt=model.vt;
        
        [self.navigationController pushViewController:dvc animated:YES];

    }
    else if(_tableSymbol2)
    {
        if (indexPath.row==self.dataArrayHis.count) {
            [self.queue deleteAlltext];
            [self.dataArrayHis removeAllObjects];
            [self.tableView reloadData];
            return;
        }
        DetailModel *model=self.dataArrayHis[indexPath.row];
        self.searchBar.text=model.name;
        [self downloadSearchResultWith:(NSString *)self.searchBar.text];
    }
    else
    {
        DetailModel *model=self.dataArray[indexPath.row];
        self.searchBar.text=model.name;
        [self downloadSearchResultWith:(NSString *)self.searchBar.text];
    }
}

//点击取消按钮
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.navigationController  popViewControllerAnimated:YES];
}

//搜索按钮
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self downloadSearchResultWith:self.searchBar.text];
}

//searchbar 改变
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    self.tableView.tableHeaderView=_headView1;
    _tableSymbol=NO;
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    if (searchBar.text.length==0) {
        _headLable.text=[NSString stringWithFormat:@"   • %@",@"搜索历史"];
        NSArray *array=[self.queue getAlltext];//数据库获取的历史
        [self.dataArrayHis removeAllObjects];
        for (NSString *str in array) {
            DetailModel *model=[[DetailModel alloc]init];
            model.name=str;
            [self.dataArrayHis addObject:model];
        }
        [self.tableView reloadData];
    }
    else
    {
        _headLable.text=[NSString stringWithFormat:@"   • %@",@"搜索提示"];
        [self.dataArrayHis removeAllObjects];
        NSString *ss=[searchBar.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self downloadTishiWithStr:ss];
    }

}

//searchbar 刚开始处于编辑状态
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    _tableSymbol2=YES; //显示历史 或者 提示
    _headLable.text=[NSString stringWithFormat:@"   • %@",@"搜索历史"];
    NSArray *array=[self.queue getAlltext];
    [self.dataArrayHis removeAllObjects];
    for (NSString *str in array) {
        DetailModel *model=[[DetailModel alloc]init];
        model.name=str;
        [self.dataArrayHis addObject:model];
    }
    [self.tableView reloadData];
}

#pragma mark - 下载搜索提示
//下载搜索提示
-(void)downloadTishiWithStr:(NSString *)str
{
    NSString *urlString=[NSString stringWithFormat:SEATAG_URL,str];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSArray *array=dict[@"dataList"];
        for (NSDictionary *dd in array) {
            DetailModel *model=[[DetailModel alloc]init];
            [model setValuesForKeysWithDictionary:dd];
            [self.dataArrayHis addObject:model];
        }
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",[error description]);
    }];
}

#pragma mark - 点击搜索触发
//点击搜索触发
-(void)downloadSearchResultWith:(NSString *)seachtext
{
    [self createHeadView2];//重新创建headView
    [self.view endEditing:YES];
    if ([self.queue isExistsWithtext:seachtext]) {
        [self.queue deletetext:seachtext];
        [self.queue addtext:seachtext];
    }
    else
        [self.queue addtext:seachtext];
    
    NSString *ss=[seachtext stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlString=[NSString stringWithFormat:SEACLICK_URL,ss];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dci=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [self.dataArrayNew removeAllObjects];
        NSArray *array=dci[@"data"];
        for (NSDictionary *dd in array) {
            DetailModel *model=[[DetailModel alloc]init];
            [model setValuesForKeysWithDictionary:dd];
            [self.dataArrayNew addObject:model];
        }
        _tableSymbol=YES;
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",[error description]);
    }];
}

//按钮触发改变频道
-(void)changeChannel:(LCButton *)btn
{
    
    if (btn.selected) {
        return;
    }
    else{
        LCButton *bb=self.selectBtnArr[0];
        bb.selected=NO;
        btn.selected=YES;
        [self.selectBtnArr setArray:@[btn]];
        NSString *vt;
        if (btn.tag==510)
        {
            [self downloadSearchResultWith:self.searchBar.text];
        }
        else if (btn.tag==511)//电视剧
        {
            vt=@"1";
        }
        else if (btn.tag==512)//电影
        {
            vt=@"2";
        }
        else if (btn.tag==513)//动漫
        {
            vt=@"3";
        }
        else if (btn.tag==514)//综艺
        {
            vt=@"4";
        }
        [self downloadSearchChange:self.searchBar.text andVT:vt];
    }
}

#pragma mark - 频道选择触发
-(void)downloadSearchChange:(NSString *)str andVT:(NSString *)vt
{
    NSString *ss=[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *urlString=[NSString stringWithFormat:SEACHANGE_URL,ss,vt];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        [self.dataArrayNew removeAllObjects];
        NSArray *array=dict[@"data"];
        for (NSDictionary *dd in array) {
            DetailModel *model=[[DetailModel alloc]init];
            [model setValuesForKeysWithDictionary:dd];
            [self.dataArrayNew addObject:model];
        }
        _tableSymbol=YES;
        self.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",[error description]);
    }];

}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    
}
@end
