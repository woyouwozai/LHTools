//
//  LHTimerProxy.m
//  learntest
//
//  Created by helly on 2020/2/18.
//  Copyright © 2020 com.dnetzj.www. All rights reserved.
//

#import "LHTimerProxy.h"

@implementation LHTimerProxy

+(LHTimerProxy *)proxyWithTarget:(id)target
{
    LHTimerProxy *proxy = [LHTimerProxy alloc];
    proxy.target = target;
    return proxy;
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [self.target methodSignatureForSelector:sel];
}

-(void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation invokeWithTarget:self.target];
}
@end
