//
//  MoreListViewController.m
//  HappyTV
//
//  Created by allenariel on 15/5/6.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "MoreListViewController.h"

#import "DetailModel.h"
#import "MoreListCollectionViewCell.h"
#import "UIScrollView+JHRefresh.h"
#import "JHRefreshCommonAniView.h"
#import "Detail1ViewController.h"
#import "JHRefreshAmazingAniView.h"

@interface MoreListViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    UICollectionViewFlowLayout *layout;
    NSDictionary *rootDict;
    int _index;
}
@property(nonatomic,strong)NSMutableArray *allData;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,assign)int index;

@end

@implementation MoreListViewController
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
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, mysize.width, mysize.height-20) collectionViewLayout:layout];
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
    self.index=1;
    [self startDownloadData];
    [self addRefresh];

}
-(void)addRefresh
{
    __weak typeof (self)weakSelf=self;
    
    [self.collectionView addRefreshFooterViewWithAniViewClass:[JHRefreshAmazingAniView class] beginRefresh:^{
        weakSelf.index++;
        [weakSelf startDownloadData];
    }];
}
-(void)startDownloadData
{
    [SVProgressHUD showWithStatus:@"正在加载数据中"];
    NSString *urlString=[NSString stringWithFormat:MORELIST_URL,self.areaid,_index,self.vt,self.categoryid];
    NSLog(@"MostList URL %@",urlString);
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        rootDict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        self.title=rootDict[@"channelname"];
        for (NSDictionary *dd in rootDict[@"data"]) {
            DetailModel *mode=[[DetailModel alloc]init];
            [mode setValuesForKeysWithDictionary:dd];
            [self.allData addObject:mode];
        }
        
        [self.collectionView reloadData];
        [_collectionView footerEndRefreshing];
        [SVProgressHUD dismissWithSuccess:@"加载完成"];
        
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
//===========
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
    
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:model.poster]];
    
    if ([model.vt intValue]==1||[model.vt intValue]==3||[model.vt intValue]==16)
    {
        if ([model.nowepisodes isEqualToString:model.episodes]) {
            cell.howLabel.text=[NSString stringWithFormat:@"%@集全",model.nowepisodes];
        }
        else
            cell.howLabel.text=[NSString stringWithFormat:@"更新到%@集",model.nowepisodes];
    }
    else if ([model.vt intValue]==4)
        cell.howLabel.text=model.nowepisodes;
    else if ([model.vt intValue]==2)
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
    Detail1ViewController *dvc=[[Detail1ViewController alloc]init];
    dvc.aid=mo.aid;
    dvc.vt=mo.vt;
    [self.navigationController pushViewController:dvc animated:YES];

    
}

@end
