//
//  Comm.h
//  WeChatDemoDylib
//
//  Created by Mac on 2020/6/19.
//  Copyright © 2020 maimai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Comm : NSObject
+ (void)test:(id)arg1;

+(void) saveHookConfig:(id)setObject forKey:(NSString*)key;
+(BOOL) confIsRedEnvelopeSwitchEnable;
+(NSString*) confWcWalkNumberString;

@end

NS_ASSUME_NONNULL_END
