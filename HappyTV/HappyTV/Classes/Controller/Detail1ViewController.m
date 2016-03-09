//
//  Detail1ViewController.m
//  HappyTV
//
//  Created by allenariel on 15/5/3.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#import "Detail1ViewController.h"
#import "MoreDetailModel.h"
#import "DetailModel.h"
#import "LCTapGesture.h"
#import "UIView+LCView.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UIView+LCView.h"
#import "UMSocial.h"
#import "MyDatabaseQueue.h"
#import "GUAAlertView.h"
#import "UIView+LCView.h"
#import "MyPlayerViewController.h"
#import "LXActivity.h"

@interface Detail1ViewController ()<UMSocialUIDelegate,UIActionSheetDelegate,LXActivityDelegate>
{
    MoreDetailModel *_model;
    CGSize _jianJieScrollSize;
    CGSize _juJiScrollSize;
    BOOL _relateSymbol;
    NSMutableArray *boFangArray;
    BOOL boFangSymbol;
    UIView *boFangView;
    UIView *_toolView;
    UIView *_juJiView;
    UIView *_jianJieView;
    UIView *_xiangGuanView;
    UIImageView *_topImageView1;
    UIImageView *_topImageView2;
    UIImageView *_topImageView3;
    UIButton *_jianJieBtn;
    UIButton *_juJiBtn;
    UIButton *_xiangGuanBtn;
    float _a;
    UIButton *_collectBtn;
    UIButton *_shareBtn;
    UIButton *_downLoadBtn;
}
@property(nonatomic,strong)MyDatabaseQueue *queue;
@property(nonatomic,strong)NSMutableArray *relateArray;//存放相关剧场的数组
@end

@implementation Detail1ViewController
-(FMDatabaseQueue *)queue
{
    return [MyDatabaseQueue shareInstance];
}

-(NSMutableArray *)relateArray
{
    if (_relateArray==nil) {
        _relateArray=[NSMutableArray array];
    }
    return _relateArray;
}

- (void)viewDidLoad {

    [super viewDidLoad];
    [self startDownloadData];
}


-(void)addHistory
{
    if ([self.queue isExistsWithAppMpdel:_model recordType:RecordTypeHis]) {
        if ([_model.name isEqualToString:@""]) {
            return;
        }
        [self.queue deleteModel:_model recordType:RecordTypeHis];
        [self.queue addModel:_model recordType:RecordTypeHis];
    }
    else
        [self.queue addModel:_model recordType:RecordTypeHis];
}

#pragma mark - 下载数据
-(void)startDownloadData
{
    [SVProgressHUD showWithStatus:@"正在加载中"];
    NSString *urlString=[NSString stringWithFormat:DETAIL_URL,self.aid];
    NSLog(@"More Detail URL %@",urlString);
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        _model=[[MoreDetailModel alloc]init];
        [_model setValuesForKeysWithDictionary:dict];
        [_model setValue:dict[@"description"] forKey:@"desc"];
        [self whereBoFang];
        [self createUI];
        [self addHistory];
        [SVProgressHUD dismissWithSuccess:@"加载成功"];
        self.backView.hidden=YES;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",[error description]);
        [SVProgressHUD dismissWithError:@"加载失败"];
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"点击重新加载", nil];
        [alertView show];
    }];
}

//加载失败，重新加载
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        [self startDownloadData];
    }
}

-(void)createUI
{
    self.title=_model.name;
    _collectBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    //判断收藏按钮状态
    if (![self.queue isExistsWithAppMpdel:_model recordType:RecordTypeFav]) {
        [_collectBtn setImage:[UIImage imageNamed:@"favor.png"] forState:UIControlStateNormal];
    }
    else
    {
        [_collectBtn setImage:[UIImage imageNamed:@"favor_click.png"] forState:UIControlStateNormal];
    }
    
    CGSize size=[UIScreen mainScreen].bounds.size;
    
    
    if (size.width==414) {
        _a=35;
    }
    else if (size.width==375)
    {
        _a=25;
    }
    else
        _a=5;
    
    //判断电影或者电视剧
    if ([self.vt intValue]==2) {
        //按钮
        _jianJieBtn=[self.scrolView addSystemButtonWithFrame:CGRectMakeEx(45, 211-_a, 70, 30) title:@"简介" action:^(UIButton *button) {
            [self jianjieClick];
        }];
        
        _xiangGuanBtn=[self.scrolView addSystemButtonWithFrame:CGRectMakeEx(205, 211-_a, 70, 30) title:@"相关" action:^(UIButton *button) {
            [self xiangguanClick];
        }];
        
        //TOPImgeView
        _topImageView1=[[UIImageView alloc]initWithFrame:CGRectMakeEx(30, 237-_a, 100, 5)];
        _topImageView1.image=[UIImage imageNamed:@"toptop2.png"];
        [self.scrolView addSubview:_topImageView1];
        _topImageView1.hidden=NO;
        _topImageView2=[[UIImageView alloc]initWithFrame:CGRectMakeEx(190, 237-_a, 100, 5)];
        _topImageView2.image=[UIImage imageNamed:@"toptop2.png"];
        [self.scrolView addSubview:_topImageView2];
        _topImageView2.hidden=YES;

    }
    else
    {
        //创建按钮
        _jianJieBtn=[self.scrolView addSystemButtonWithFrame:CGRectMakeEx(15, 211-_a, 70, 30) title:@"简介" action:^(UIButton *button) {
            [self jianjieClick];
        }];
        _juJiBtn=[self.scrolView addSystemButtonWithFrame:CGRectMakeEx(125, 211-_a, 70, 30) title:@"剧集" action:^(UIButton *button) {
            [self jujiClick];
        }];

        _xiangGuanBtn=[self.scrolView addSystemButtonWithFrame:CGRectMakeEx(235, 211-_a, 70, 30) title:@"相关" action:^(UIButton *button) {
            [self xiangguanClick];
        }];
        
        //TOPImgeView
        _topImageView1=[[UIImageView alloc]initWithFrame:CGRectMakeEx(5, 237-_a, 100, 5)];
        _topImageView1.image=[UIImage imageNamed:@"toptop2.png"];
        [self.scrolView addSubview:_topImageView1];
        _topImageView1.hidden=YES;
        _topImageView2=[[UIImageView alloc]initWithFrame:CGRectMakeEx(110, 237-_a, 100, 5)];
        _topImageView2.image=[UIImage imageNamed:@"toptop2.png"];
        [self.scrolView addSubview:_topImageView2];
        _topImageView2.hidden=NO;
        _topImageView3=[[UIImageView alloc]initWithFrame:CGRectMakeEx(215, 237-_a, 100, 5)];
        _topImageView3.image=[UIImage imageNamed:@"toptop2.png"];
        [self.scrolView addSubview:_topImageView3];
        _topImageView3.hidden=YES;
        //剧集View （vt=1 与vt=4不同）
        _juJiView=[[UIView alloc]initWithFrame:CGRectMakeEx(0, 242-_a, 320, 3000)];
        [self.scrolView addSubview:_juJiView];
        _juJiView.backgroundColor=[UIColor colorWithRed:228/255.0 green:228/255.0 blue:234/255.0 alpha:1];
        //判断是电视剧还是综艺
        if ([_model.vt intValue]==1||[_model.vt intValue]==3) {
            double x=5;
            double y=15;
            double w=55;
            double h=25;
            float lasty;
            for (int i=0; i<_model.videolist.count; i++) {
                UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                btn.backgroundColor=[UIColor whiteColor];
                [btn setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
                btn.tag=222+i;
                [btn addTarget:self action:@selector(oneJuJiClick:) forControlEvents:UIControlEventTouchUpInside];
                
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                btn.titleLabel.font=[UIFont systemFontOfSize:16];
                
                if (i%5==0&&i!=0) {
                    x=5;
                    y+=30;
                }
                btn.frame=CGRectMakeEx(x, y, w, h);
                x+=63;
                [_juJiView addSubview:btn];
            }
            lasty=_model.videolist.count *7;
            if (lasty>200.0) {
                lasty-=200;
            }
            self.scrolView.contentSize=CGSizeMake(0, lasty+500);
            _juJiScrollSize=CGSizeMake(0, lasty+500);
        }
        else if ([_model.vt intValue]==4||[_model.vt intValue]==16)
        {
            double x=5;
            double y=15;
            double w=310;
            double h=40;
            for (int i=0;i<_model.videolist.count ;i++) {
                UIView *view1=[[UIView alloc]initWithFrame:CGRectMakeEx(x, y, w, h)];
                view1.userInteractionEnabled=YES;
                LCTapGesture *tap=[[LCTapGesture alloc]initWithTarget:self action:@selector(oneJuJiTapClick:)];
                tap.age=i;
                [view1 addGestureRecognizer:tap];
                view1.backgroundColor=[UIColor whiteColor];
                [_juJiView addSubview:view1];
                y+=45;
                UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(10, 3, 300, 20)];
                label1.text=_model.videolist[i][@"releasedate"];
                label1.font=[UIFont systemFontOfSize:12];
                [view1 addSubview:label1];
                UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, 300, 20)];
                label2.text=_model.videolist[i][@"subname"];
                label2.font=[UIFont systemFontOfSize:14];
                [view1 addSubview:label2];
            }
            self.scrolView.contentSize=CGSizeMake(0, y+320);
            _juJiScrollSize=CGSizeMake(0, y+320);
        }
    }

    //头部设置
    [self.iconImageView setImageWithURL:[NSURL URLWithString:_model.poster]];
    self.whereLabel.text=[NSString stringWithFormat:@"地区:%@",_model.areaname];
    self.whenLabel.text=[NSString stringWithFormat:@"年份:%@",_model.releasedate];
    self.starView.backgroundColor=[UIColor yellowColor];
    [self.starView setStar:[_model.rating floatValue]];
    self.starLabel.text=[NSString stringWithFormat:@"%.1f",[_model.rating floatValue]];
    
    
    //简介View
    _jianJieView=[[UIView alloc]initWithFrame:CGRectMakeEx(0, 242-_a, 320, 500)];
    [self.scrolView addSubview:_jianJieView];
    
    _jianJieView.backgroundColor=[UIColor colorWithRed:228/255.0 green:228/255.0 blue:234/255.0 alpha:1];
    UILabel *jianjieLabel=[_jianJieView addLabelWithFrame:CGRectMakeEx(20, 10, 280, 500) text:_model.desc];
    jianjieLabel.numberOfLines=0;
    jianjieLabel.textColor=[UIColor grayColor];
    jianjieLabel.font=[UIFont systemFontOfSize:16];
    [jianjieLabel sizeToFit];
    _jianJieScrollSize=CGSizeMake(0, _jianJieView.frame.origin.y+jianjieLabel.frame.size.height);
    if ([self.vt intValue]==2) {
        _jianJieView.hidden=NO;
        _scrolView.contentSize=_jianJieScrollSize;
    }
    else
        _jianJieView.hidden=YES;

    UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, size.height-110, size.width, 50)];
    backView.backgroundColor=[UIColor whiteColor];
    backView.alpha=0.5;
    [self.view addSubview:backView];
    
    //底部按钮
    _collectBtn.frame=CGRectMakeEx(25, 0, 40, 40);
    [_collectBtn addTarget:self action:@selector(favClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:_collectBtn];
    

    _shareBtn=[backView addImageButtonWithFrame:CGRectMakeEx(245, 0, 40, 40) title:nil image:@"share@2x.png" action:^(UIButton *button) {
        [self shareClick];
    }];

}
#pragma mark - 简介点击方法
-(void)jianjieClick
{
    _xiangGuanView.hidden=YES;
    _juJiView.hidden=YES;
    _jianJieView.hidden=NO;
    _scrolView.contentSize=_jianJieScrollSize;
    _topImageView1.hidden=NO;
    _topImageView2.hidden=YES;
    _topImageView3.hidden=YES;

}

#pragma mark - 剧集点击方法
-(void)jujiClick
{
    _xiangGuanView.hidden=YES;
    _jianJieView.hidden=YES;
    _juJiView.hidden=NO;
    self.scrolView.contentSize=_juJiScrollSize;
    _topImageView2.hidden=NO;
    _topImageView1.hidden=YES;
    _topImageView3.hidden=YES;

}

#pragma mark - 相关点击方法
-(void)xiangguanClick
{
    _juJiView.hidden=YES;
    _jianJieView.hidden=YES;
    _xiangGuanView.hidden=NO;
    self.scrolView.contentSize=CGSizeMake(0, 630);
    _topImageView3.hidden=NO;
    _topImageView1.hidden=YES;
    _topImageView2.hidden=YES;

    if (_relateSymbol) {
        return;
    }
    else{
        _relateSymbol=YES;
        _xiangGuanView=[[UIView alloc]initWithFrame:CGRectMakeEx(0, 242-_a, 320, 500)];
        [self.scrolView addSubview:_xiangGuanView];
        _xiangGuanView.backgroundColor=[UIColor colorWithRed:228/255.0 green:228/255.0 blue:234/255.0 alpha:1];
        //下载相关View数据
        int cid;
        if ([_model.vt intValue]==2)
            cid=1;
        else if ([_model.vt intValue]==1)
            cid=2;
        else if ([_model.vt intValue]==4)
            cid=11;
        else if ([_model.vt intValue]==3)
            cid=5;
        else if ([_model.vt intValue]==16)
            cid=16;
        NSString *urlString=[NSString stringWithFormat:RELATE_URL,_model.aid,_model.src,cid];
    
        NSLog(@"相关 URL %@",urlString);
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        for (NSDictionary *dd in dict[@"data"]) {
            DetailModel *model1=[[DetailModel alloc]init];
            [model1 setValuesForKeysWithDictionary:dd];
            [self.relateArray addObject:model1];
        }
        
        double x=5;
        double y=5;
        double w=100;
        double h=130;
        for (int i=0; i<6; i++) {
            if (i%3==0&&i!=0) {
                x=5;
                y+=160;
            }
            DetailModel *model1=self.relateArray[i];
            
            UIImageView *imageView=[[UIImageView alloc]init];
            imageView.userInteractionEnabled=YES;
            imageView.frame=CGRectMakeEx(x, y, w, h);
            [imageView setImageWithURL:[NSURL URLWithString:model1.poster]];
            //添加点击
            LCTapGesture *tap=[[LCTapGesture alloc]initWithTarget:self action:@selector(tapClick:)];
            tap.age=i;
            [imageView addGestureRecognizer:tap];
            
            UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMakeEx(0, 115, 100, 15)];
            label1.font=[UIFont systemFontOfSize:12];
            label1.backgroundColor=[UIColor whiteColor];
            label1.alpha=0.5;
            label1.textAlignment=NSTextAlignmentRight;
            
            if ([_model.vt intValue]==1||[_model.vt intValue]==3||[_model.vt intValue]==16)
            {
                if ([_model.nowepisodes isEqualToString:_model.episodes]) {
                    label1.text=[NSString stringWithFormat:@"%@集全",_model.nowepisodes];
                }
                else
                    label1.text=[NSString stringWithFormat:@"更新到%@集",_model.nowepisodes];
            }
            else if ([_model.vt intValue]==4)
            {
                label1.text=_model.nowepisodes;
            }
            [imageView addSubview:label1];
            
            UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMakeEx(x, y+h, w, 20)];
            label2.backgroundColor=[UIColor whiteColor];
            label2.font=[UIFont systemFontOfSize:14];
            label2.textAlignment=NSTextAlignmentLeft;
            label2.text=model1.name;
            [_xiangGuanView addSubview:label2];
            [_xiangGuanView addSubview:imageView];
            
            x+=105;
        }
        self.scrolView.contentSize=CGSizeMake(0, 630);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",[error description]);
    }];
    }
}
-(void)tapClick:(LCTapGesture*)tap
{
    DetailModel *model1=self.relateArray[tap.age];
    Detail1ViewController *dvc1=[[Detail1ViewController alloc]init];
    dvc1.aid=model1.aid;
    dvc1.vt=model1.vt;
    [self.navigationController pushViewController:dvc1 animated:YES];
    
}
-(void)whereBoFang
{
    NSString *urlString=[NSString stringWithFormat:BOFANG_URL,self.aid];
    NSLog(@"播放 URL %@",urlString);
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *array =[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        boFangArray=[NSMutableArray arrayWithArray:array];
        
        [self.boFangImageView setImageWithURL:[NSURL URLWithString:_model.sitelogo]];
        self.boFangLabel.text=_model.sitename;
        if (array==nil) {
            return ;
        }
        if (boFangArray.count==0) {
            NSLog(@"播放数组为空");
            [boFangArray addObject:@{@"sitelogo":_model.sitelogo,@"sitename":_model.sitename}];
        }
        double hegiht=30*boFangArray.count;
        boFangView=[[UIView alloc]initWithFrame:CGRectMake(200, 140, 110, hegiht)];
        boFangView.userInteractionEnabled=YES;
        boFangView.layer.borderWidth=1;
        boFangView.layer.cornerRadius=10;
        boFangView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:boFangView];
        for (int i=0; i<boFangArray.count; i++) {
            UIView *eachView=[[UIView alloc]initWithFrame:CGRectMake(0, 5+30*i, 110, 25)];
            [boFangView addSubview:eachView];
            //添加点击事件
            LCTapGesture *tap=[[LCTapGesture alloc]initWithTarget:self action:@selector(boFangTap:)];
            tap.age=i;
            [eachView addGestureRecognizer:tap];
            
            UIImageView *iView=[eachView addImageViewWithFrame:CGRectMake(5, 5, 25, 20) image:nil];
            iView.userInteractionEnabled=YES;
            
            [iView setImageWithURL:[NSURL URLWithString:boFangArray[i][@"sitelogo"]]];
            UILabel *lab=[eachView addLabelWithFrame:CGRectMake(35, 0, 60, 30) text:boFangArray[i][@"sitename"]];
            lab.font=[UIFont systemFontOfSize:14];
            [eachView addImageViewWithFrame:CGRectMake(5, 25, 100, 1) image:@"jianju.png"];
        }
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(alltapClick)];
        [self.allBoFangView addGestureRecognizer:tap];
        boFangView.hidden=YES;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",[error description]);
    }];
}
-(void)alltapClick
{
    if (boFangSymbol) {
    [UIView animateWithDuration:0.5 animations:^{
        boFangView.hidden=YES;
        boFangSymbol=NO;
    }];
    }
    else
    {
        boFangView.hidden=NO;
        boFangSymbol=YES;
    }
}


-(void)boFangTap:(LCTapGesture *)tap
{
    [self.boFangImageView setImageWithURL:[NSURL URLWithString:boFangArray[tap.age][@"sitelogo"]]];
    self.boFangLabel.text=boFangArray[tap.age][@"sitename"];
    boFangView.hidden=YES;
    boFangSymbol=NO;
}

- (IBAction)playClick:(id)sender {
    //播放

    [self boFangOneWith:0];
}

-(void)oneJuJiClick:(UIButton*)btn
{
    int which=(int)btn.tag-222;
    [self boFangOneWith:which];
}

-(void)oneJuJiTapClick:(LCTapGesture *)tap
{
    [self boFangOneWith:tap.age];
}

-(void)boFangOneWith:(int)which
{
    NSDictionary *dict=_model.videolist[which];

    if(![dict[@"url"] isEqualToString:@""])
    {
        NSLog(@"网页播放url%@",dict[@"url"]);
        UIWebView *webView=[[UIWebView alloc]initWithFrame:self.view.bounds];
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:dict[@"url"]]]];
        [self.view addSubview:webView];
        return;
    }
    else
    {
        GUAAlertView *v = [GUAAlertView alertViewWithTitle:@"提示"
                                                   message:@"暂无资源"
                                               buttonTitle:@"取消"
                                       buttonTouchedAction:^{
                                           NSLog(@"button touched");
                                       } dismissAction:^{
                                           NSLog(@"dismiss");
                                       }];
        [v show];

    }
}
#pragma mark - 分享点击
-(void)shareClick
{

    NSArray * shareButtonTitleArray = @[@"新浪微博",@"微信",@"微信朋友圈",@"手机QQ",@"短信",@"邮件"];
    NSArray * shareButtonImageNameArray = @[@"sns_icon_1",@"sns_icon_22",@"sns_icon_23.png",@"sns_icon_24.png",@"sns_icon_19",@"sns_icon_18"];
    LXActivity *lxActivity = [[LXActivity alloc] initWithTitle:@"分享到社交平台" delegate:self cancelButtonTitle:@"取消" ShareButtonTitles:shareButtonTitleArray withShareButtonImagesName:shareButtonImageNameArray];
    [lxActivity showInView:self.view];
}

-(void)didClickOnImageIndex:(NSInteger)imageIndex
{
     NSString *text=[NSString stringWithFormat:@"这部‘%@’真心不错哦,快点来http://itunes.apple.com下载‘开心影视’一起免费观看吧！",_model.name];
    [[UMSocialControllerService defaultControllerService] setShareText:text shareImage:_iconImageView.image socialUIDelegate:self];        //设置分享内容和回调对象
    if (imageIndex==0) {
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    else if (imageIndex==1)
    {
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    else if (imageIndex==2)
    {
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatTimeline].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    else if(imageIndex==3)
    {
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    else if (imageIndex==4)
    {
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSms].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    else if (imageIndex==5)
    {
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToEmail].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
}

//处理分享点击
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==4) {
        return;
    }
    NSString *text=[NSString stringWithFormat:@"这部%@真心不错哦,一起跟我玩",_model.name];
    [[UMSocialControllerService defaultControllerService] setShareText:text shareImage:_iconImageView.image socialUIDelegate:self];        //设置分享内容和回调对象
    
    if (buttonIndex==0) {
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);

    }
    else if (buttonIndex==1)
    {
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }
    else if (buttonIndex==2)
    {
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatTimeline].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);

    }
    else if(buttonIndex==3)
    {
        [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    }

}


-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

#pragma mark - 收藏点击
-(void)favClick
{
    if([self.queue isExistsWithAppMpdel:_model recordType:RecordTypeFav])
    {
        [self.queue deleteModel:_model recordType:RecordTypeFav];
        [_collectBtn setImage:[UIImage imageNamed:@"favor.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.queue addModel:_model recordType:RecordTypeFav];
        [_collectBtn setImage:[UIImage imageNamed:@"favor_click.png"] forState:UIControlStateNormal];
    }
}

//- (IBAction)downloadClick:(id)sender {
//    MyDatabaseQueue *queue=[MyDatabaseQueue shareInstance];
//    NSArray *arr=[queue getAllData];
//    for (MoreDetailModel *model11 in arr) {
//        NSLog(@"%@ %@",model11.aid,model11.name);
//    }
//}


@end
