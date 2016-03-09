//
//  EachChartsViewController.m
//  HappyTV
//
//  Created by allenariel on 15/5/7.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "EachChartsViewController.h"
#import "DetailModel.h"
#import "MoreListCollectionViewCell.h"
#import "UIScrollView+JHRefresh.h"
#import "Detail1ViewController.h"
//#import "Detail2ViewController.h"
#import "SVProgressHUD.h"

@interface EachChartsViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    UICollectionViewFlowLayout *layout;
    NSDictionary *rootDict;
    int _index;
}
@property(nonatomic,strong)NSMutableArray *allData;
@property(nonatomic,strong)UICollectionView *collectionView;


@end

@implementation EachChartsViewController
-(NSMutableArray *)allData
{
    if (_allData==nil) {
        _allData=[NSMutableArray array];
    }
    return _allData;
}
-(UICollectionView *)collectionView
{
    CGSize mysize=[UIScreen mainScreen].bounds.size;
    if (_collectionView==nil) {
        
        layout=[[UICollectionViewFlowLayout alloc]init];
        
        //创建一屏的视图大小
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, mysize.width, mysize.height-90) collectionViewLayout:layout];
        [_collectionView registerNib:[UINib nibWithNibName:@"MoreListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:[MoreListCollectionViewCell myIdentify]];
        _collectionView. backgroundColor =[UIColor whiteColor];
        _collectionView. delegate = self ;
        _collectionView. dataSource = self ;
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startDownloadData];
}

-(void)startDownloadData
{
    [SVProgressHUD showWithStatus:@"正在加载中"];
    NSString *urlString=[NSString stringWithFormat:EACHCHARTS_URL,self.m_rank];
    NSLog(@"详细排行榜 URL %@",urlString);
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dcit=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        rootDict=dcit[@"data"];
        self.title=rootDict[@"rankname"];
        for (NSDictionary *dd in rootDict[@"data"]) {
            DetailModel *mode=[[DetailModel alloc]init];
            [mode setValuesForKeysWithDictionary:dd];
            [self.allData addObject:mode];
        }
        [self.collectionView reloadData];
        [_collectionView footerEndRefreshing];
        [SVProgressHUD dismissWithSuccess:@"加载成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",[error description]);
        [SVProgressHUD dismissWithError:@"加载失败"];
    }];
}

//实现代理方法

#pragma mark --UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-( NSInteger )collectionView:( UICollectionView *)collectionView numberOfItemsInSection:( NSInteger )section
{
    return self.allData.count;
}

//每个UICollectionView展示的内容
-( UICollectionViewCell *)collectionView:( UICollectionView *)collectionView cellForItemAtIndexPath:( NSIndexPath *)indexPath

{
    DetailModel *model=self.allData[indexPath.row];
    MoreListCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:[MoreListCollectionViewCell myIdentify] forIndexPath:indexPath];
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:model.pic]];
    if ([model.vt intValue]==2||[model.vt intValue]==5)
    {
        if ([model.nowepisodes isEqualToString:model.episodes]) {
            cell.howLabel.text=[NSString stringWithFormat:@"%@集全",model.nowepisodes];
        }
        else
            cell.howLabel.text=[NSString stringWithFormat:@"更新到%@集",model.nowepisodes];
    }
    else if ([model.vt intValue]==11)
        cell.howLabel.text=model.nowepisodes;
    else if ([model.vt intValue]==1)
        cell.howLabel.text=model.rating;
    cell.nameLabel.text=model.name;
    
    return cell;
}

//定义每个UICollectionView 的大小
- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath
{
    return CGSizeMakeEx(98,150);
}

//定义每个UICollectionView 的边距
-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section

{
    return UIEdgeInsetsMake (0, 2 , 5 , 2);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailModel *mo=self.allData[indexPath.row];
    NSString *vt;
    if ([mo.vt intValue]==1)//电影
        vt=@"2";
    else if ([mo.vt intValue]==2)//电视
        vt=@"1";
    else if ([mo.vt intValue]==11)//综艺
        vt=@"4";
    else if ([mo.vt intValue]==5)//动漫
        vt=@"3";

    Detail1ViewController *dvc=[[Detail1ViewController alloc]init];
    dvc.aid=mo.aid;
    dvc.vt=vt;
    [self.navigationController pushViewController:dvc animated:YES];

}


@end
