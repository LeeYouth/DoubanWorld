//
//  NSString+Extension.h
//  
//
//  Created by apple on 14-5-30.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

/**
 *  计算文本占用的宽高
 *
 *  @param font    显示的字体
 *  @param maxSize 最大的显示范围
 *
 *  @return 占用的宽高
 */
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;
/**
 *  计算属性字符文本占用的宽高
 *
 *  @param font    显示的字体
 *  @param maxSize 最大的显示范围
 *  @param lineSpacing 行间距
 *
 *  @return 占用的宽高
 */
- (CGSize)attrStrSizeWithFont:(UIFont *)font andmaxSize:(CGSize)maxSize lineSpacing:(CGFloat)lineSpacing;


@end
