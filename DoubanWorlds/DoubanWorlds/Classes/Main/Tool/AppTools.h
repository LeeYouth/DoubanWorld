//
//  AppTools.h
//  DoubanWorlds
//
//  Created by LYoung on 15/12/23.
//  Copyright © 2015年 LYoung. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppTools : NSObject
/**
 *  字符串转换称颜色
 *
 *  @param stringToConvert 需要填充的颜色
 *
 *  @return RGB值
 */
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

@end
