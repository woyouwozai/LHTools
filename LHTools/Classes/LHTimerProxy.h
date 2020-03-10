//
//  LHTimerProxy.h
//  learntest
//
//  Created by helly on 2020/2/18.
//  Copyright © 2020 com.dnetzj.www. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LHTimerProxy : NSProxy

@property(nonatomic,weak)id target;

+(LHTimerProxy *)proxyWithTarget:(id)target;

@end

NS_ASSUME_NONNULL_END
