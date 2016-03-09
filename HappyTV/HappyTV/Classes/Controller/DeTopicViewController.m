//
//  DeTopicViewController.m
//  HappyTV
//
//  Created by allenariel on 15/5/7.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "DeTopicViewController.h"
#import "MoreListCollectionViewCell.h"
#import "Detail2Model.h"
//#import "Detail2ViewController.h"
#import "Detail1ViewController.h"

@interface DeTopicViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    NSDictionary *rootDict;
    UICollectionViewFlowLayout *layout;
}
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *allData;


@end

@implementation DeTopicViewController

-(NSMutableArray *)allData
{
    if (_allData==nil) {
        _allData=[NSMutableArray array];
    }
    return _allData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    [self startDownloadData];
}
-(UICollectionView *)collectionView
{
    CGSize mysize=[UIScreen mainScreen].bounds.size;
    if (_collectionView==nil) {
        
        layout=[[UICollectionViewFlowLayout alloc]init];
        
        //创建一屏的视图大小
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, mysize.width, mysize.height-110) collectionViewLayout:layout];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"MoreListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:[MoreListCollectionViewCell myIdentify]];
        _collectionView.bounces=NO;
        _collectionView. delegate = self ;
        _collectionView. dataSource = self ;
        _collectionView.backgroundColor=[UIColor colorWithRed:228/255.0 green:228/255.0 blue:234/255.0 alpha:1];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

-(void)startDownloadData
{
    [SVProgressHUD showErrorWithStatus:@"正在加载中"];
    NSString *urlString=[NSString stringWithFormat:DETOPIC_URL,self.themeid];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        rootDict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dic in rootDict[@"data"]) {
            Detail2Model *model=[[Detail2Model alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            
            [self.allData addObject:model];
        }
        [self createHeadView];
        [self.collectionView reloadData];
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
-(void)createHeadView
{
    self.title=rootDict[@"name"];
    
    UIView *headView=[[UIView alloc]init];
    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMakeEx(5, 10, 37, 17)];
    imageView.image=[UIImage imageNamed:@"guide@2x.png"];
    [headView addSubview:imageView];
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMakeEx(5, 11, 310, 150)];
    label.numberOfLines=0;
    label.font=[UIFont systemFontOfSize:15];
    label.backgroundColor=[UIColor clearColor];
    label.text=[NSString stringWithFormat:@"          :%@",rootDict[@"shortdesc"]];
    [label sizeToFit];
    CGSize size=label.frame.size;
    [headView addSubview:label];

    headView.frame=CGRectMakeEx(0, -(size.height+20), 320, size.height+20);
    
    double yy= heightEx(size.height+20);
    self.collectionView.contentInset=UIEdgeInsetsMake(yy, 0, 0, 0);
    [self.collectionView addSubview:headView];
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
    Detail2Model *model=self.allData[indexPath.row];
    
    
    MoreListCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:[MoreListCollectionViewCell myIdentify] forIndexPath:indexPath];
    
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:model.poster]];
    
    if ([model.vt intValue]==1||[model.vt intValue]==3||[model.vt intValue]==16)
    {
        if ([model.nowepisodes intValue]==[model.episodes intValue]) {
            cell.howLabel.text=[NSString stringWithFormat:@"%@集全",model.nowepisodes];
        }
        else
            cell.howLabel.text=[NSString stringWithFormat:@"更新到%@集",model.nowepisodes];
    }
    else if ([model.vt intValue]==4)
        cell.howLabel.text=[NSString stringWithFormat:@"%d",[model.nowepisodes intValue]];
    else if ([model.vt intValue]==2)
        cell.howLabel.text=[NSString stringWithFormat:@"%d",[model.rating intValue]];
    
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
    Detail2Model *mo=self.allData[indexPath.row];
    Detail1ViewController *dvc=[[Detail1ViewController alloc]init];
    dvc.aid=mo.albumid;
    dvc.vt=[NSString stringWithFormat:@"%d",[mo.vt intValue]];
    [self.navigationController pushViewController:dvc animated:YES];
//    if ([mo.vt intValue]==2) {
//        Detail2ViewController *dvc2=[[Detail2ViewController alloc]init];
//        dvc2.aid=mo.albumid;
//        [self.navigationController pushViewController:dvc2 animated:YES];
//    }
//    else
//    {
//        Detail1ViewController *dvc1=[[Detail1ViewController alloc]init];
//        dvc1.aid=mo.albumid;
//        [self.navigationController pushViewController:dvc1 animated:YES];
//    }
}


@end
