//
//  MovieHttpTool.h
//  DoubanWorlds
//
//  Created by LYoung on 16/1/5.
//  Copyright © 2016年 LYoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieHttpTool : NSObject

+(void)getHotMovieWithStart:(int)start arrayBlock:(ArrayBlock)arrayBlock;

@end
