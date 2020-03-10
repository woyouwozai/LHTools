//
//  LHGCDTimer.m
//  learntest
//
//  Created by helly on 2020/2/18.
//  Copyright © 2020 com.dnetzj.www. All rights reserved.
//

#import "LHGCDTimer.h"

@implementation LHGCDTimer

+(LHGCDTimer *)scheduledGCDTimerWithTimeInterval:(NSTimeInterval)interval delay:(NSTimeInterval)delay block :(void (^)(LHGCDTimer * _Nonnull))block repeats:(BOOL)repeats sync:(BOOL)sync
{
    if(interval < 0 || delay < 0)
        return nil;
    
    LHGCDTimer *timer = [[LHGCDTimer alloc] init];
    dispatch_queue_t queue = sync ? dispatch_get_main_queue() : dispatch_get_global_queue(0, 0);
    dispatch_source_t gcdTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    timer.innerTimer = gcdTimer;
    
    //设置timer
    dispatch_source_set_timer(gcdTimer,
                              dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC),
                              interval * NSEC_PER_SEC,
                              0);
    
    //设置回调
    dispatch_source_set_event_handler(gcdTimer, ^{
        block(timer);
        if(!repeats)
            [timer invalidate];
    });
    
    //start
    dispatch_resume(gcdTimer);
    
    return timer;
}

+(LHGCDTimer *)scheduledGCDTimerWithTimeInterval:(NSTimeInterval)interval delay:(NSTimeInterval)delay target:(id)target selector:(SEL)aSelector userInfo:(nullable id)userInfo  repeats:(BOOL)repeats sync:(BOOL)sync
{
    if(!target || !aSelector)
        return nil;
    __weak typeof(target) weakTarget = target;//不用weak 如果block里使用了target gcd定时器内部会会target强引用（target-->LHGCDTimer对象-->innerTimer-->block-->target）
    return [LHGCDTimer scheduledGCDTimerWithTimeInterval:interval delay:delay block:^(LHGCDTimer * _Nonnull timer) {
        if([weakTarget respondsToSelector:aSelector]){
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [weakTarget performSelector:aSelector withObject:userInfo];
            #pragma clang diagnostic pop
        }
    } repeats:repeats sync:sync];
}

-(void)invalidate
{
    dispatch_source_cancel(self.innerTimer);
}

@end
