//
//  NSMutableDictionary+Safe.h
//  WeChatDemoDylib
//
//  Created by Mac on 2020/6/21.
//  Copyright © 2020 maimai. All rights reserved.
//
#import <AppKit/AppKit.h>


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (Safe)

- (void)safeSetObject:(id)anObject forKey:(id)aKey;

@end

NS_ASSUME_NONNULL_END
