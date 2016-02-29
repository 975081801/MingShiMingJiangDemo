//
//  NSString+GFS.h
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/2/29.
//  Copyright © 2016年 GFS. All rights reserved.
// 转换汉字为拼音

#import <Foundation/Foundation.h>

@interface NSString (GFS)
+ (NSString *)pinYinStringFromChinese:(NSString *)chinese;
@end
