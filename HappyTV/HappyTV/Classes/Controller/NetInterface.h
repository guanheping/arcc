//
//  NetInterface.h
//  HappyTV
//
//  Created by allenariel on 15/4/30.
//  Copyright (c) 2015年 allen. All rights reserved.
//

#ifndef HappyTV_NetInterface_h
#define HappyTV_NetInterface_h

//一、首页：http://api.le123.com/kuaikan/apipage_json.so?code=ef14fd20217b550c&plattype=iphone&page=page_index&platform=Le123Plat001&uuid=02fe1c99a7319599a7a56d30cedad1f5a2e13de5_02fe1c99a7319599a7a56d30cedad1f5a2e13de5&version=1.5.8

#define MAIN_URL @"http://api.le123.com/kuaikan/apipage_json.so?code=ef14fd20217b550c&plattype=iphone&page=page_index&platform=Le123Plat001&uuid=02fe1c99a7319599a7a56d30cedad1f5a2e13de5_02fe1c99a7319599a7a56d30cedad1f5a2e13de5&version=1.5.8"


//1、视图与 aid相关
//点击(电视剧)：http://api.le123.com/kuaikan/apidetail_json.so?plattype=iphone&code=ef14fd20217b550c&definition=1&aid=2_298294&platform=Le123Plat001&version=1.5.8&uuid=02fe1c99a7319599a7a56d30cedad1f5a2e13de5_02fe1c99a7319599a7a56d30cedad1f5a2e13de5

//点击(电影)：http://api.le123.com/kuaikan/apidetail_json.so?plattype=iphone&code=ef14fd20217b550c&definition=1&aid=2_299722&platform=Le123Plat001&version=1.5.8&uuid=02fe1c99a7319599a7a56d30cedad1f5a2e13de5_02fe1c99a7319599a7a56d30cedad1f5a2e13de5
//#define DETAIL_URL @"http://api.le123.com/kuaikan/apidetail_json.so?plattype=iphone&code=ef14fd20217b550c&definition=1&aid=%@&platform=Le123Plat001&version=1.5.8&uuid=02fe1c99a7319599a7a56d30cedad1f5a2e13de5_02fe1c99a7319599a7a56d30cedad1f5a2e13de5"
#define DETAIL_URL @"http://api.le123.com/kuaikan/apidetail_json.so?plattype=iphone&code=ef14fd20217b550c&platform=Le123Plat001&uuid=d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a_d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a&aid=%@&version=1.5.8&definition=1"

//2+ 点击相关 (1)aid不同 (2)src不同 (3)cid不同(（电影）vt=2cid=1，（剧场）vt=1cid=2， （综艺）vt=4cid=11，  （动画片）vt=3 cid=5) 记录去 vt=16 cid=16
//http://api.le123.com/kuaikan/apidetailrelation_json.so??unique_id=d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a&platform=Le123Plat001&code=ef14fd20217b550c&aid=2_299857&src=2&plattype=iphone&version=1.5.8&num=6&uuid=d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a_d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a&cid=1

#define RELATE_URL @"http://api.le123.com/kuaikan/apidetailrelation_json.so??unique_id=d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a&platform=Le123Plat001&code=ef14fd20217b550c&aid=%@&src=%@&plattype=iphone&version=1.5.8&num=6&uuid=d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a_d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a&cid=%d"

//3、播放来源  aid 不同
//http://api.le123.com/kuaikan/apiwebsite_json.so?plattype=iphone&code=ef14fd20217b550c&platform=Le123Plat001&uuid=d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a_d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a&aid=2_299836&version=1.5.8&definition=1

#define BOFANG_URL @"http://api.le123.com/kuaikan/apiwebsite_json.so?plattype=iphone&code=ef14fd20217b550c&platform=Le123Plat001&uuid=d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a_d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a&aid=%@&version=1.5.8&definition=1"

//4、点击更多
//点击更多  vt不同  1 电视剧 2电影 3动画片 4综艺    韩剧 area=50042 美剧area=50071 纪录片vt=16 no all
//电影：http://api.le123.com/kuaikan/apilist_json.so?area=all&pageindex=1&plattype=iphone&code=ef14fd20217b550c&pagesize=18&uuid=d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a_d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a&platform=Le123Plat001&version=1.5.8&vt=2&subcategory=all
//参数1 area  参数1+ index 参数2 vt 参数3 categoryId
#define MORELIST_URL @"http://api.le123.com/kuaikan/apilist_json.so?area=%@&pageindex=%d&plattype=iphone&code=ef14fd20217b550c&pagesize=18&uuid=d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a_d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a&platform=Le123Plat001&version=1.5.8&vt=%@&subcategory=%@"

//二、频道
//1
//http://api.le123.com/kuaikan/apichannel_json.so?code=ef14fd20217b550c&plattype=iphone&uuid=02fe1c99a7319599a7a56d30cedad1f5a2e13de5_02fe1c99a7319599a7a56d30cedad1f5a2e13de5&platform=Le123Plat001&version=1.5.8
#define CHANNEL_URL @"http://api.le123.com/kuaikan/apichannel_json.so?code=ef14fd20217b550c&plattype=iphone&uuid=02fe1c99a7319599a7a56d30cedad1f5a2e13de5_02fe1c99a7319599a7a56d30cedad1f5a2e13de5&platform=Le123Plat001&version=1.5.8"

//2
//根据 vt的不同 获取不同的类型：
//电视剧：http://api.le123.com/kuaikan/apilist_json.so?pagesize=18&plattype=iphone&vt=1&pageindex=1&code=ef14fd20217b550c&platform=Le123Plat001&version=1.5.8&uuid=02fe1c99a7319599a7a56d30cedad1f5a2e13de5_02fe1c99a7319599a7a56d30cedad1f5a2e13de5

//三、专题
//1
//http://api.le123.com/kuaikan/apithemelist_json.so?pagesize=10&plattype=iphone&pageindex=1&code=ef14fd20217b550c&platform=Le123Plat001&version=1.5.8&uuid=02fe1c99a7319599a7a56d30cedad1f5a2e13de5_02fe1c99a7319599a7a56d30cedad1f5a2e13de5
#define TOPIC_URL @"http://api.le123.com/kuaikan/apithemelist_json.so?pagesize=10&plattype=iphone&pageindex=1&code=ef14fd20217b550c&platform=Le123Plat001&version=1.5.8&uuid=02fe1c99a7319599a7a56d30cedad1f5a2e13de5_02fe1c99a7319599a7a56d30cedad1f5a2e13de5"
//2
//http://api.le123.com/kuaikan/apitheme_json.so?pagesize=18&plattype=iphone&themeid=1021&pageindex=1&code=ef14fd20217b550c&platform=Le123Plat001&version=1.5.8&uuid=02fe1c99a7319599a7a56d30cedad1f5a2e13de5_02fe1c99a7319599a7a56d30cedad1f5a2e13de5
#define DETOPIC_URL @"http://api.le123.com/kuaikan/apitheme_json.so?pagesize=18&plattype=iphone&themeid=%@&pageindex=1&code=ef14fd20217b550c&platform=Le123Plat001&version=1.5.8&uuid=02fe1c99a7319599a7a56d30cedad1f5a2e13de5_02fe1c99a7319599a7a56d30cedad1f5a2e13de5"

//四、排行榜
//1
//http://api.le123.com/kuaikan/apirank_json.so?record=5%2C5%2C5%2C5&plattype=iphone&code=ef14fd20217b550c&platform=Le123Plat001&uuid=d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a_d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a&rank=m_rank_tv%2Cm_rank_movie%2Cm_rank_cartoon%2Cm_rank_zongyi&version=1.6.4
#define CHARTS_URL @"http://api.le123.com/kuaikan/apirank_json.so?record=5%2C5%2C5%2C5&plattype=iphone&code=ef14fd20217b550c&platform=Le123Plat001&uuid=d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a_d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a&rank=m_rank_tv%2Cm_rank_movie%2Cm_rank_cartoon%2Cm_rank_zongyi&version=1.6.4"
//2
//http://api.le123.com/kuaikan/apirank_json.so?rank=m_rank_movie&plattype=iphone&record=50&code=ef14fd20217b550c&platform=Le123Plat001&version=1.5.8&uuid=02fe1c99a7319599a7a56d30cedad1f5a2e13de5_02fe1c99a7319599a7a56d30cedad1f5a2e13de5
#define EACHCHARTS_URL @"http://api.le123.com/kuaikan/apirank_json.so?rank=%@&plattype=iphone&record=50&code=ef14fd20217b550c&platform=Le123Plat001&version=1.5.8&uuid=02fe1c99a7319599a7a56d30cedad1f5a2e13de5_02fe1c99a7319599a7a56d30cedad1f5a2e13de5"

//五、搜索
//1进入搜索界面
//http://api.le123.com/kuaikan/apirecommend_json.so?code=ef14fd20217b550c&version=1.6.4&uuid=d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a_d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a&recommend=REC_SEARCH_TOP&plattype=iphone&platform=Le123Plat001
#define SEARCH_URL @"http://api.le123.com/kuaikan/apirecommend_json.so?code=ef14fd20217b550c&version=1.6.4&uuid=d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a_d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a&recommend=REC_SEARCH_TOP&plattype=iphone&platform=Le123Plat001"
//2搜索提示
//http://api.le123.com/kuaikan/apisuggest_json.so?from=%3Cnull%3E&wd=%E4%BB%96&plattype=iphone&platform=Le123Plat001&code=ef14fd20217b550c&uuid=d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a_d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a&version=1.6.4
#define SEATAG_URL @"http://api.le123.com/kuaikan/apisuggest_json.so?from=%%3Cnull%%3E&wd=%@&plattype=iphone&platform=Le123Plat001&code=ef14fd20217b550c&uuid=d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a_d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a&version=1.6.4"
//3、搜索
//http://api.le123.com/kuaikan/apisearch_json.so?wd=%E5%BF%AB%E4%B9%90%E5%A4%A7%E6%9C%AC%E8%90%A5&pageindex=1&plattype=iphone&platform=Le123Plat001&code=ef14fd20217b550c&pagesize=10&uuid=d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a_d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a&version=1.6.4
#define SEACLICK_URL @"http://api.le123.com/kuaikan/apisearch_json.so?wd=%@&pageindex=1&plattype=iphone&platform=Le123Plat001&code=ef14fd20217b550c&pagesize=10&uuid=d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a_d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a&version=1.6.4"
//http://api.le123.com/kuaikan/apisearch_json.so?wd=%E5%BF%AB%E4%B9%90%E5%A4%A7%E6%9C%AC%E8%90%A5&pageindex=1&plattype=iphone&platform=Le123Plat001&vt=1&code=ef14fd20217b550c&pagesize=10&version=1.6.4&uuid=d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a_d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a
#define SEACHANGE_URL @"http://api.le123.com/kuaikan/apisearch_json.so?wd=%@%%A5&pageindex=1&plattype=iphone&platform=Le123Plat001&vt=%@&code=ef14fd20217b550c&pagesize=10&version=1.6.4&uuid=d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a_d368a1afad1bb67da2ed7f8c5fe2310f99e7ce0a"
#endif
