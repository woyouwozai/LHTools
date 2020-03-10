//
//  LHGCDTimer.h
//  learntest
//
//  Created by helly on 2020/2/18.
//  Copyright © 2020 com.dnetzj.www. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LHGCDTimer : NSObject

@property(nonatomic,strong) dispatch_source_t innerTimer;

+(LHGCDTimer *)scheduledGCDTimerWithTimeInterval:(NSTimeInterval)interval delay:(NSTimeInterval)delay block:(void(^)(LHGCDTimer *timer))block repeats:(BOOL)repeats sync:(BOOL)sync;

+(LHGCDTimer *)scheduledGCDTimerWithTimeInterval:(NSTimeInterval)interval delay:(NSTimeInterval)delay target:(id)target selector:(SEL)aSelector userInfo:(nullable id)userInfo repeats:(BOOL)repeats sync:(BOOL)sync;

-(void)invalidate;

@end

NS_ASSUME_NONNULL_END
