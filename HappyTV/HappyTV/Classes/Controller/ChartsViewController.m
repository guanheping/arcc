//
//  ChartsViewController.m
//  HappyTV
//
//  Created by allenariel on 15/4/30.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "ChartsViewController.h"
#import "ChartsCollectionViewCell.h"
#import "DetailModel.h"
#import "LCTapGesture.h"
#import "EachChartsViewController.h"
#import "Detail1ViewController.h"
//#import "Detail2ViewController.h"

@interface ChartsViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    NSDictionary *rootDict;

}
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSMutableArray *allData;

@end

@implementation ChartsViewController
-(NSMutableArray *)allData
{
    if (_allData==nil) {
        _allData=[NSMutableArray array];
    }
    return _allData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self startDownloadData];
}
-(UICollectionView *)collectionView
{
    CGSize mysize=[UIScreen mainScreen].bounds.size;
    if (_collectionView==nil) {
        
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        
        //创建一屏的视图大小
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, mysize.width, mysize.height-120) collectionViewLayout:layout];
        
        [_collectionView registerNib:[UINib nibWithNibName:@"ChartsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:[ChartsCollectionViewCell myIdentify]];
        
        _collectionView. delegate = self ;
        _collectionView. dataSource = self ;
        _collectionView.backgroundColor=[UIColor colorWithRed:228/255.0 green:228/255.0 blue:234/255.0 alpha:1];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}
-(void)startDownloadData
{
    [SVProgressHUD showWithStatus:@"正在加载中"];
    NSString *urlString=CHARTS_URL;
    NSLog(@"%@",urlString);
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        for (NSString  *str in dict[@"data"]) {
            
            NSMutableDictionary *muDic=[NSMutableDictionary dictionary];
            [muDic setValue:str forKey:@"m_rank"];
            [muDic setValue:dict[@"data"][str][@"rankname"] forKey:@"rankname"];
            [muDic setValue:dict[@"data"][str][@"vt"] forKey:@"vt"];
            
            NSMutableArray *muArr=[NSMutableArray array];
            for (NSDictionary *d in dict[@"data"][str][@"data"]) {
                DetailModel *model=[[DetailModel alloc]init];
                [model setValuesForKeysWithDictionary:d];
                [muArr addObject:model];
            }
            [muDic setValue:muArr forKey:@"alldata"];

            [self.allData addObject:muDic];
        }
        
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
    NSDictionary *dic=self.allData[indexPath.row];
    
    ChartsCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:[ChartsCollectionViewCell myIdentify] forIndexPath:indexPath];
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:[self.allData[indexPath.row][@"alldata"][0] pic]]];
    cell.mainLabel.text=dic[@"rankname"];
    LCTapGesture *tap=[[LCTapGesture alloc]initWithTarget:self action:@selector(mainTapClick:)];
    tap.age=(int)indexPath.row;
    [cell.mainLabel addGestureRecognizer:tap];
    
    //图片
    LCTapGesture *tap0=[[LCTapGesture alloc]initWithTarget:self action:@selector(tap2Click:)];
    tap0.age=(int)indexPath.row;
    [cell.iconImageView addGestureRecognizer:tap0];

    //1
    cell.name1Label.text=[NSString stringWithFormat:@"1.%@",[dic[@"alldata"][0] name]];
    LCTapGesture *tap1=[[LCTapGesture alloc]initWithTarget:self action:@selector(tap2Click:)];
    tap1.age=(int)indexPath.row;
    tap1.moreage=0;
    [cell.name1Label addGestureRecognizer:tap1];
    //2
    cell.name2Label.text=[NSString stringWithFormat:@"2.%@",[dic[@"alldata"][1] name]];
    LCTapGesture *tap2=[[LCTapGesture alloc]initWithTarget:self action:@selector(tap2Click:)];
    tap2.age=(int)indexPath.row;
    tap2.moreage=1;
    [cell.name2Label addGestureRecognizer:tap2];
    //3
    cell.name3Label.text=[NSString stringWithFormat:@"3.%@",[dic[@"alldata"][2] name]];
    LCTapGesture *tap3=[[LCTapGesture alloc]initWithTarget:self action:@selector(tap2Click:)];
    tap3.age=(int)indexPath.row;
    tap3.moreage=2;
    [cell.name3Label addGestureRecognizer:tap3];
    //4
    cell.name4Label.text=[NSString stringWithFormat:@"4.%@",[dic[@"alldata"][3] name]];
    LCTapGesture *tap4=[[LCTapGesture alloc]initWithTarget:self action:@selector(tap2Click:)];
    tap4.age=(int)indexPath.row;
    tap4.moreage=3;
    [cell.name4Label addGestureRecognizer:tap4];
    //5
    cell.name5Label.text=[NSString stringWithFormat:@"5.%@",[dic[@"alldata"][4] name]];
    LCTapGesture *tap5=[[LCTapGesture alloc]initWithTarget:self action:@selector(tap2Click:)];
    tap5.age=(int)indexPath.row;
    tap5.moreage=4;
    [cell.name5Label addGestureRecognizer:tap5];
    
    return cell;
    
}

//定义每个UICollectionView 的大小
- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath
{
    return CGSizeMakeEx(150,400);
}

//定义每个UICollectionView 的边距
-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section

{
    return UIEdgeInsetsMake (0, 0 , 5 , 0);
}

-(void)mainTapClick:(LCTapGesture *)tap
{
    NSLog(@"%@",self.allData[tap.age][@"m_rank"]);
    EachChartsViewController *ecvc=[[EachChartsViewController alloc]init];
    ecvc.m_rank=self.allData[tap.age][@"m_rank"];
    [self.navigationController pushViewController:ecvc animated:YES];
    
}
-(void)tap2Click:(LCTapGesture *)tap
{
    DetailModel *model=self.allData[tap.age][@"alldata"][tap.moreage];
    NSString *vt;
    if ([model.vt intValue]==1)//电影
        vt=@"2";
    else if ([model.vt intValue]==2)//电视
        vt=@"1";
    else if ([model.vt intValue]==11)//综艺
        vt=@"4";
    else if ([model.vt intValue]==5)//动漫
        vt=@"3";
    Detail1ViewController *dvc=[[Detail1ViewController alloc]init];
    dvc.aid=model.aid;
    dvc.vt=vt;
    [self.navigationController pushViewController:dvc animated:YES];
}
@end
