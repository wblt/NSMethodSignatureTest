//
//  test.h
//  test
//
//  Created by wb on 2017/6/23.
//  Copyright © 2017年 wb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface test : NSObject

// 一个参数
- (NSString *)testDemo:(NSString *)dd;

// 两个参数
- (NSString *)testDemo:(NSString *)dd withSeconde:(NSString *)sss;

@end
