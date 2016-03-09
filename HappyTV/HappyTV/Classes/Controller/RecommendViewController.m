//
//  RecommendViewController.m
//  HappyTV
//
//  Created by allenariel on 15/4/30.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "RecommendViewController.h"
#import "ZJLoopScrollView.h"
#import "DetailModel.h"
#import "RecommenCollectionViewCell.h"
#import "RecommenTwoCollectionViewCell.h"
#import "RecipeCollectionReusableView.h"
#import "UIScrollView+JHRefresh.h"
#import "JHRefreshCommonAniView.h"
#import "Detail1ViewController.h"
#import "MoreListViewController.h"
#import "GUAAlertView.h"

@interface RecommendViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
{
    UICollectionViewFlowLayout *_layout;
    BOOL _loopSymbol;
}
@property(nonatomic,strong)NSMutableArray *allLoopData;
@property(nonatomic,strong)NSMutableArray *allData;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,assign)CGSize mysize;
@end

@implementation RecommendViewController

-(CGSize)mysize
{
    if (_mysize.width==0) {
        _mysize=[UIScreen mainScreen].bounds.size;
    }
    return _mysize;
}

-(UICollectionView *)collectionView
{
    if (_collectionView==nil) {
        
        _layout=[[UICollectionViewFlowLayout alloc]init];
        _layout.headerReferenceSize=CGSizeMake(320.0f, 40.0f);
        //创建一屏的视图大小
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.mysize.width, self.mysize.height-110) collectionViewLayout:_layout];
        
        //第一种 2大视图cell
        [_collectionView registerNib:[UINib nibWithNibName:@"RecommenCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:[RecommenCollectionViewCell myIdentify]];
        
        //第二种 3小视图cell
        [_collectionView registerNib:[UINib nibWithNibName:@"RecommenTwoCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:[RecommenTwoCollectionViewCell myIdentify]];
        
        // headViewCell
        [_collectionView registerNib:[UINib nibWithNibName:@"Recipe" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[RecipeCollectionReusableView myIdentify]];
        
        _collectionView. backgroundColor =[UIColor whiteColor];
        _collectionView. delegate = self ;
        _collectionView. dataSource = self ;
        
        double yy= heightEx(150);
        _collectionView.contentInset=UIEdgeInsetsMake(yy, 0, 0, 0);
        
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

-(NSMutableArray *)allLoopData
{
    if (_allLoopData==nil) {
        _allLoopData=[NSMutableArray array];
    }
    return _allLoopData;
}

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
    _loopSymbol=NO;
    [SVProgressHUD showWithStatus:@"正在加载"];
}
-(void)addRefresh
{
    __weak typeof (self)weakSelf=self;
    
    [_collectionView addRefreshHeaderViewWithAniViewClass:[JHRefreshCommonAniView class] beginRefresh:^{
        [weakSelf startDownloadData];
        [SVProgressHUD showWithStatus:@"正在加载"];
    }];

}

-(void)startDownloadData
{
    NSString *urlString=[NSString stringWithFormat:MAIN_URL];
    NSLog(@"Recommend URL %@",urlString);
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (!_loopSymbol) {
            //创建滚动视图
            NSArray *array=dict[@"data"][@"focusdata"];
            for (NSDictionary *dd in array) {
                DetailModel *model=[[DetailModel alloc]init];
                [model setValuesForKeysWithDictionary:dd];
                [self.allLoopData addObject:model];
            }
            [self createLoopView];
            _loopSymbol=YES;
        }
        //创建
        [self.allData removeAllObjects];
        for (NSDictionary *d1 in dict[@"data"][@"recdatas"]) {
            NSMutableDictionary *app=[NSMutableDictionary dictionary];
            [app setValuesForKeysWithDictionary:d1];
            NSMutableArray *alltv=[NSMutableArray array];
            for (NSDictionary *d2 in d1[@"data"]) {
                DetailModel *model=[[DetailModel alloc]init];
                [model setValuesForKeysWithDictionary:d2];
                [alltv addObject:model];
            }
            [app setValue:alltv forKey:@"alltv"];
            [self.allData addObject:app];
        }
        //刷新数据
        [self.collectionView reloadData];
        //停止刷新动画
        [_collectionView headerEndRefreshingWithResult:JHRefreshResultSuccess];
        //停止SV动画
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
-(void)createLoopView
{
    ZJLoopScrollView *loopView=[[ZJLoopScrollView alloc]initWithFrame:CGRectMakeEx(0, -150, 320, 150)];
    loopView.pageCount=(int)self.allLoopData.count;

    for (int i=0; i<_allLoopData.count; i++) {
        DetailModel *model=_allLoopData[i];
        [loopView setImageWithUrlString:model.pic atIndex:i];
        [loopView setClickAction:^(UIImageView *imageView, int index)
        {
            __block NSDictionary *dict;
            NSString *urlString=[NSString stringWithFormat:DETAIL_URL,[self.allLoopData[index] aid]];
            AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
            manager.responseSerializer=[AFHTTPResponseSerializer serializer];
            [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

                [self comingWithaid:[self.allLoopData[index] aid] andVT:dict[@"vt"]];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"error = %@",[error description]);
            }];

            
        }];
    }
    loopView.autoScroll=YES;
    loopView.showPageControl=YES;
    
    [self.collectionView addSubview:loopView];
    [self addRefresh];
}

//===========
//实现代理方法

#pragma mark --UICollectionViewDataSource

//定义展示的Section的个数
-( NSInteger )numberOfSectionsInCollectionView:( UICollectionView *)collectionView

{
    return self.allData.count;
}

//定义展示的UICollectionViewCell的个数
-( NSInteger )collectionView:( UICollectionView *)collectionView numberOfItemsInSection:( NSInteger )section

{
    return [self.allData[section][@"alltv"] count];
}

//每个UICollectionView展示的内容
-( UICollectionViewCell *)collectionView:( UICollectionView *)collectionView cellForItemAtIndexPath:( NSIndexPath *)indexPath

{
    DetailModel *model=self.allData[indexPath.section][@"alltv"][indexPath.row];

    if (indexPath.section==1||indexPath.section==5||indexPath.section==7) {
        RecommenTwoCollectionViewCell *twocell=[collectionView dequeueReusableCellWithReuseIdentifier:[RecommenTwoCollectionViewCell myIdentify] forIndexPath:indexPath];
        [twocell.iconImageView setImageWithURL:[NSURL URLWithString:model.pic]];
        twocell.nameLabel.text=model.name;
        twocell.howLable.text=model.subname;
        return twocell;
    }
    RecommenCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[RecommenCollectionViewCell myIdentify] forIndexPath :indexPath];
    [cell.iconImageView setImageWithURL:[NSURL URLWithString:model.pich]];
    cell.nameLabel.text=model.name;
    if ([model.vt intValue]==2) {
        cell.howLable.text=model.rating;
    }
    else if ([model.vt intValue]==1||[model.vt intValue]==3||[model.vt intValue]==16)
    {
        if ([model.nowepisodes isEqualToString:model.episodes]) {
            cell.howLable.text=[NSString stringWithFormat:@"%@集全",model.nowepisodes];
        }
        else
            cell.howLable.text=[NSString stringWithFormat:@"更新到%@集",model.nowepisodes];
    }
    else if ([model.vt intValue]==4)
    {
        cell.howLable.text=model.nowepisodes;
    }
    cell.moreLabel.text=model.subname;
    
    return cell;
}

//定义每个UICollectionView 的大小
- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath
{
    if (indexPath.section==1||indexPath.section==5||indexPath.section==7) {
        return CGSizeMakeEx(98,175);
    }
    return CGSizeMakeEx(153,151);
}

//定义每个UICollectionView 的边距
-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section

{
    if (section==1||section==5||section==7) {
        return UIEdgeInsetsMake (5, 2 , 0 , 2);
    }
    return UIEdgeInsetsMake (5, 2 , 5 , 2);
}

//定义头部
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
   
    if (kind == UICollectionElementKindSectionHeader){
        
        RecipeCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[RecipeCollectionReusableView myIdentify] forIndexPath:indexPath];
        headerView.titleLabel.text=self.allData[indexPath.section][@"recname"];
        if ([self.allData[indexPath.section][@"vt"]isEqualToString:@""]) {
            headerView.moreBtn.hidden=YES;
        }
        else
            headerView.moreBtn.hidden=NO;
        [headerView setMyBlock:^{
            
            MoreListViewController *moreVC=[[MoreListViewController alloc]init];
            moreVC.areaid=self.allData[indexPath.section][@"areaid"];
            moreVC.vt=self.allData[indexPath.section][@"vt"];
            moreVC.categoryid=self.allData[indexPath.section][@"categoryid"];
            [self.navigationController pushViewController:moreVC animated:YES];
        }];
        reusableview=headerView;
    }
    return reusableview;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DetailModel *model=self.allData[indexPath.section][@"alltv"][indexPath.row];
    [self comingWithaid:model.aid andVT:model.vt];
}
//进入更加详细界面
-(void)comingWithaid:(NSString *)aid andVT:(NSString *)vt
{
    if ([aid isEqualToString:@""]) {
        GUAAlertView *v = [GUAAlertView alertViewWithTitle:@"提示"
                                                   message:@"暂无详情资源"
                                               buttonTitle:@"取消"
                                       buttonTouchedAction:^{
                                           NSLog(@"button touched");
                                       } dismissAction:^{
                                           NSLog(@"dismiss");
                                       }];
        [v show];
        return;
    }
    Detail1ViewController *dvc=[[Detail1ViewController alloc]init];
    dvc.aid=aid;
    dvc.vt=vt;
    [self.navigationController pushViewController:dvc animated:YES];
    
}
@end
