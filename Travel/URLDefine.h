//
//  URLDefine.h
//  Travel
//
//  Created by qianfeng on 15/6/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#ifndef Travel_URLDefine_h
#define Travel_URLDefine_h

//推荐页面接口
#define REC_URL @"http://open.qyer.com/qyer/recommands/entry?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_device_info=dior&oauth_token="

//推荐页面cell加载
#define REC_CELL_URL @"http://open.qyer.com/qyer/recommands/trip?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&type=index&page=%ld&count=10"

//目的地页面接口
#define DES_URL @"http://open.qyer.com/qyer/footprint/continent_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_device_info=dior"

//社区页面接口
#define GROUO_URL @"http://open.qyer.com/qyer/bbs/forum_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&lat=34.786472&lon=113.671383"


//点击推荐页面进入Post&page=%ld  &type=%@(&forum_type=6)  &forum_id=%@
#define GROUP_DETAIL_URL_POST @"http://open.qyer.com/qyer/bbs/forum_thread_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&lat=34.786486&lon=113.6714&count=10&delcache=0"

#endif

