//
//  ServerAddress.h
//  HJTMVVM
//
//  Created by Heige on 16/6/16.
//  Copyright © 2016年 Heige. All rights reserved.
//

#ifndef ServerAddress_h
#define ServerAddress_h
//服务器地址
#define NetworkServer   @"https://api.yyhao.com/app_api/v1/"

//#ifdef DEBUG
//#define NetworkServer  @"http://192.168.1.166:6118/app_api/v1/"
//#else
//#define NetworkServer   @"https://api.yyhao.com/app_api/v1/"
//#endif

//获取配置项
#define Getconfig    @"getconfig/"

//获取推荐列表
#define Getrecommend    @"getrecommend/"

//获取书库列表任意项的详细内容
#define GetCategoryList  @"getsortlist/"

//获取漫画主体信息
#define Getcomicinfo  @"getcomicinfo/"

//获取相关列表
#define Getrelationcomic @"getrelationcomic/"
//用户登录
#define Getuserinfo  @"getuserinfo/"
//得到热门标签
#define Gethottags  @"gettopsearch/"

#define RemoveUserReadRecord    @"deluserread/"

#define GetUserrecord    @"getuserrecord/"

#endif /* ServerAddress_h */
