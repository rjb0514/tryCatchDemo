//
//  ViewController.m
//  tryDemo
//
//  Created by ru on 2018/3/30.
//  Copyright © 2018年 GMJK. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"捕获异常";
    
    //设置来接系统的异常
     NSSetUncaughtExceptionHandler(handleException);
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"制造异常" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn sizeToFit];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    btn.center = self.view.center;
    [self.view addSubview:btn];
    
    
    
}



- (void)btnClick:(UIButton *)btn {
    
    
    [self test1];
    
    
}


//这种法法 会造成系统崩溃  类似于手机系统崩溃信息
- (void)test1 {
    NSArray *arr = [NSArray array];
    //如果感觉访问的数组会出现问题 可以采取 @try
    @try {
        NSLog(@"11");
        //访问越界数组的值
        NSString *str = arr[1];
        //如果上面的语句发生了异常  那么 44就不会打印
        NSLog(@"44");
        
        
    }@catch(NSException *exception) {
        NSLog(@"22");
        
        //这里抛出异常的话系统就会崩溃  可以在自定义捕获异常的方法里做一些事情
        @throw exception;
    }
    @finally {
        NSLog(@"33");
    }
    
}


//这个方法可以自己去处理 不是很严重影响app流程的 异常
- (void)test2 {
    NSArray *arr = [NSArray array];
    //如果感觉访问的数组会出现问题 可以采取 @try
    @try {
        NSLog(@"11");
        //访问越界数组的值
        NSString *str = arr[1];
        //如果上面的语句发生了异常  那么 44就不会打印
        NSLog(@"44");
        
        
    }@catch(NSException *exception) {
        NSLog(@"22");
        
        //这里抛出异常的话系统就会崩溃  可以在自定义捕获异常的方法里做一些事情
        
    }
    @finally {
        NSLog(@"33");
    }
}


#pragma mark - 拦截系统的异常
//拦截异常
void handleException(NSException *exception){
    
    NSMutableDictionary * info = [NSMutableDictionary dictionary];
    info[@"callStack"] = [exception callStackSymbols];//调用栈信息（错误来源哪个方法）
    info[@"name"] = [exception name];//异常名字
    info[@"reason"] = [exception reason];//异常描述
    
    //    [info writeToFile:<#(nonnull NSString *)#> atomically:<#(BOOL)#>]  写入沙盒
    
    NSLog(@"%@-----%s",exception, __func__);
}



@end
