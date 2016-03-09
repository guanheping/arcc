//
//  CollectViewController.m
//  HappyTV
//
//  Created by allenariel on 15/5/7.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "CollectViewController.h"
#import "MoreDetailModel.h"
#import "Detail1ViewController.h"
#import "Search2TableViewCell.h"

@interface CollectViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataArray;
}
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation CollectViewController

- (void)viewDidLoad {
    self.title=self.nameTitle;
    [super viewDidLoad];
    NSArray *arr=[[MyDatabaseQueue shareInstance] getAllDataWithRecordType:self.type];
    _dataArray=[NSMutableArray arrayWithArray:arr];
    [self createTableView];
}

-(void)createTableView
{
    _tableView=[[UITableView alloc]init];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.frame=CGRectMakeEx(0, 0, 320, 538);
    [self.view addSubview:_tableView];
    [self setExtraCellLineHidden:_tableView];
}
- (void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}
#pragma mark - tableview的数据源方法

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.type==RecordTypeHis) {
        return _dataArray.count+1;
    }
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type==RecordTypeHis) {
        if (indexPath.row==_dataArray.count) {
            Search2TableViewCell *cell=[[Search2TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[Search2TableViewCell myIdentify]];
            return cell;
        }
    }
    NSString *ID=@"abc";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    MoreDetailModel *model=_dataArray[indexPath.row];
    cell.textLabel.text=model.name;
    cell.detailTextLabel.text=model.categoryname;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type==RecordTypeHis) {
        if (indexPath.row==_dataArray.count) {
            return 30;
        }
    }

    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.type==RecordTypeHis) {
        if (indexPath.row==_dataArray.count) {
            [[MyDatabaseQueue shareInstance]deleteAllModelrecordType:RecordTypeHis];
            [_dataArray removeAllObjects];
            [self.tableView reloadData];
            return;
        }
    }
    MoreDetailModel *mo=_dataArray[indexPath.row];
    
    Detail1ViewController *dvc=[[Detail1ViewController alloc]init];
    dvc.aid=mo.aid;
    dvc.vt=[NSString stringWithFormat:@"%d",[mo.vt intValue]];
    [self.navigationController pushViewController:dvc animated:YES];

    }

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    MoreDetailModel *model=_dataArray[indexPath.row];
    [[MyDatabaseQueue shareInstance]deleteModel:model recordType:self.type];
    [_dataArray removeObject:model];
    [tableView reloadData];
}

@end
