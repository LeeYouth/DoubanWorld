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

/**
 *  设置行间距为6的字符
 *
 *  @param contentText 传入的字符串
 *
 *  @return 返回属性化的字符
 */
+ (NSMutableAttributedString *)setLineSpacingWith:(NSString *)contentText lineSpacing:(CGFloat)lineSpacing;
/**
 *  格式化一个数量
 *
 *  @param count 传入的数量
 *
 *  @return 返回格式化的数量
 */
+ (NSString *)formatCount:(NSString *)count;

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (NSString *)formatRating:(NSString *)rating;

+ (NSString *)formatCountstr:(NSString *)countStr;

@end
