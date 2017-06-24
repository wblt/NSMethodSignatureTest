//
//  test.m
//  test
//
//  Created by wb on 2017/6/23.
//  Copyright © 2017年 wb. All rights reserved.
//

#import "test.h"

@implementation test
- (NSString *)testDemo:(NSString *)dd {

    NSLog(@"我进入了方法一=====%@",dd);
    
    return @"我是方法一。。。。";
}

// 两个参数
- (NSString *)testDemo:(NSString *)dd withSeconde:(NSString *)sss {
    NSLog(@"我进入了方法二====%@=====%@",dd,sss);
    return @"我是方法二。。。。";
}

// 三个参数
- (NSInteger)testDemo:(NSString *)dd withSeconde:(NSString *)sss withThree:(NSString *)three {
    NSLog(@"我进入了方法三====%@=====%@=====%@",dd,sss,three);
    return 20;
}
@end
