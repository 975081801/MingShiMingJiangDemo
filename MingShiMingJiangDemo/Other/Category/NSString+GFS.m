//
//  NSString+GFS.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/2/29.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "NSString+GFS.h"

@implementation NSString (GFS)
+ (NSString *)pinYinStringFromChinese:(NSString *)chinese
{
    CFMutableStringRef chineseMutableStringRef = CFStringCreateMutableCopy(NULL, 0, (CFStringRef)chinese);
    
    CFStringTransform(chineseMutableStringRef, NULL, kCFStringTransformMandarinLatin, NO);
    
    return (__bridge NSString *)(chineseMutableStringRef);
}
@end
