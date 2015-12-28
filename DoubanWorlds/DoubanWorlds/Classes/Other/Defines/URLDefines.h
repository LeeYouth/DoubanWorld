//
//  URLDefines.h
//  AnecdotesDemo
//
//  Created by LYoung on 15/10/13.
//  Copyright (c) 2015年 LYoung. All rights reserved.
//

#ifndef AnecdotesDemo_URLDefines_h
#define AnecdotesDemo_URLDefines_h

#define APIKey    @"0552046e035d7b8b0ff60d4a0a1872a1"
#define APISecret @"bcdf6eaa0bd75fff"

#define DoubanWorld_BaseURL @"http://api.douban.com"


//1.获取最近一周内的某个城市的热点活动
#define Recommend_URL [NSString stringWithFormat:@"%@/v2/event/list",DoubanWorld_BaseURL]
//2.获取热门城市列表
#define HotCities_URL [NSString stringWithFormat:@"%@/v2/loc/list",DoubanWorld_BaseURL]


#endif
