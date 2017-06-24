//
//  ViewController.m
//  test
//
//  Created by wb on 2017/6/23.
//  Copyright © 2017年 wb. All rights reserved.
//

#import "ViewController.h"

#import <objc/message.h>

#import "test.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 调用方法一
//    [self perform:@"testDemo:" withObjects:@"first",nil];
    
    // 调用方法二
//    [self perform:@"testDemo:withSeconde:" withObjects:@"first",@"sercond",nil];
    
    // 调用方法三
    [self perform:@"testDemo:withSeconde:withThree:" withObjects:@"first",@"sercond",@"three",nil];
    
}

- (NSInteger )testDemo:(NSString *)dd {
    
    NSLog(@"我进入了方法一=====%@",dd);
    
    return 12;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)perform:(NSString *)serviceName withObjects:(id)object,... {
    test *t = [[test alloc] init];
    // 获取方法签名
    NSMethodSignature *signature = [[test class] instanceMethodSignatureForSelector:NSSelectorFromString(serviceName)];
    if (signature == nil) {
        //可以抛出异常也可以不操作。
        return;
    }
    // NSInvocation : 利用一个NSInvocation对象包装一次方法调用（方法调用者、方法名、方法参数、方法返回值）
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    // 设置调用者
    invocation.target = t;
    // 设置调用的方法
    invocation.selector = NSSelectorFromString(serviceName);
    // 计算方法个数
    NSInteger paramsCount = signature.numberOfArguments - 2;
    //1.定义一个指向个数可变的参数列表指针；
    va_list args;
    
    //2.va_start(args, str);string为第一个参数，也就是最右边的已知参数,这里就是获取第一个可选参数的地址.使参数列表指针指向函数参数列表中的第一个可选参数，函数参数列表中参数在内存中的顺序与函数声明时的顺序是一致的。
    va_start(args, object);
    if (object)
    {
        //依次取得除第一个参数以外的参数
        //4.va_arg(args,NSString)：返回参数列表中指针所指的参数，返回类型为NSString，并使参数指针指向参数列表中下一个参数。
        int i = 0;
        // 设置第一个参数
        [invocation setArgument:&object atIndex: i + 2];
        NSLog(@"ss %@",object);
        id ss = va_arg(args, id);
        while (ss)
        {
            i ++;
            if (i >= paramsCount) {
                break;
            }
            // 设置除第一个以外的参数
            NSLog(@"ss %@",ss);
            [invocation setArgument:&ss atIndex: i + 2];
            ss = va_arg(args,  id);
        }
    }
    //5.清空参数列表，并置参数指针args无效。
    va_end(args);
    
    //retain 所有参数，防止参数被释放dealloc
    [invocation retainArguments];
    // 调用方法
    [invocation invoke];
    
    //获得返回值类型
    const char *returnType = signature.methodReturnType;
    //声明返回值变量
    id returnValue;
    //如果没有返回值，也就是消息声明为void，那么returnValue=nil
    if( !strcmp(returnType, @encode(void)) ){
        returnValue =  nil;
    }else if( !strcmp(returnType, @encode(id)) ){
        //如果返回值为对象，那么为变量赋值
        [invocation getReturnValue:&returnValue];
    } else{
        //如果返回值为普通类型NSInteger  BOOL
        //返回值长度
        NSUInteger length = [signature methodReturnLength];
        //根据长度申请内存
        void *buffer = (void *)malloc(length);
        //为变量赋值
        [invocation getReturnValue:buffer];
        if( !strcmp(returnType, @encode(BOOL)) ) {
            returnValue = [NSNumber numberWithBool:*((BOOL*)buffer)];
        }
        else if( !strcmp(returnType, @encode(NSInteger)) ){
            returnValue = [NSNumber numberWithInteger:*((NSInteger*)buffer)];
        } else {
            returnValue = [NSValue valueWithBytes:buffer objCType:returnType];
        }
    }
    NSLog(@"result:%@",returnValue);
}


@end
