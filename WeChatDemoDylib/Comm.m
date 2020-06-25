//
//  Comm.m
//  WeChatDemoDylib
//
//  Created by Mac on 2020/6/19.
//  Copyright © 2020 maimai. All rights reserved.
//

#import "Comm.h"
static NSMutableDictionary *hookConfig;
// 公共常用方法工具类
@implementation Comm

+(void) load {
}

+(void) test:(id)arg1 {
    //NSLog(@"test===%@", arg1);
    //NSLog(@"test===%d", arg1.type);

    
    NSLog(@"静态方法进来啦test1😁-----");
}

// 保存自己的配置数据
+(void) saveHookConfig:(id)setObject forKey:(NSString*)key {
    NSMutableDictionary *obj = [[NSMutableDictionary alloc] init];
    [obj setObject:setObject forKey:key];
    NSLog(@"将要存储的字典===%@", obj);
    //存入数组并同步
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    NSLog(@"及时获取=====%@",[Comm getHookConfig:key]);

}


// 获取配置文件isRedEnvelopeSwitchEnable是否开启自动抢红包
+(BOOL) confIsRedEnvelopeSwitchEnable {
    BOOL a = YES;
    if ([[[Comm getHookConfig:@"isRedEnvelopeSwitchEnable"] valueForKey:@"isRedEnvelopeSwitchEnable"] boolValue]) {
       a = YES;
    } else {
       a = NO;
    }
    //NSLog(@"confIsRedEnvelopeSwitchEnable hookConfig=====%@",hookConfig);
    //NSLog(@"confIsRedEnvelopeSwitchEnable a=====%d",a);
    return a;
}

// 获取配置文件wcWalkNumber 微信步数
+(NSString*) confWcWalkNumberString {
    return [[Comm getHookConfig:@"wcWalkNumberString"] valueForKey:@"wcWalkNumberString"];
}

// 获取配置
+(NSMutableDictionary*) getHookConfig:key {
    hookConfig = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    return hookConfig;
}
@end
