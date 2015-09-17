//
//  FuncPublic.h
//  NiuScrollView
//
//  Created by ilaoniu on 15-9-17.
//  Copyright (c) 2015年 ilaoniu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FuncPublic : NSObject

+(FuncPublic *)SharedFuncPublic;

/*
 * 保存default信息
 * str:需要保存的文字
 * key:关键字
 */
+(void)SaveDefaultInfo:(id)str andKey:(NSString *)key;
/*
 * 获得保存的default信息
 * key:关键字
 */
+(id)GetDefaultInfo:(NSString *)key;

@end
