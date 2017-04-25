//
//  STYNotification.m
//  test
//
//  Created by honghao5 on 17/4/17.
//  Copyright © 2017年 zhh. All rights reserved.
//

#import "STYNotification.h"
#import <objc/runtime.h>
#import <UIKit/UIKit.h>

typedef void (^NextBlock) (id object, NSDictionary *userInfo);

static NSString * const STYNotificationNextBlockKey = @"STYNotificationNextBlockKey";

@implementation NSObject (Notification)

+ (void)load
{
    SEL ori = NSSelectorFromString(@"dealloc");
    SEL new = NSSelectorFromString([@"sty_" stringByAppendingString:NSStringFromSelector(ori)]);
    sty_swizzle(self, ori, new);
}

void sty_swizzle(Class c, SEL orig, SEL new)
{
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    
    method_exchangeImplementations(origMethod, newMethod);
}

- (void)sty_dealloc
{
    if ([self nextBlock]) {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
        [self setNextBlock:nil];
    }
    
    [self sty_dealloc];
}

- (NextBlock)nextBlock
{
    return objc_getAssociatedObject(self, &STYNotificationNextBlockKey);
}

- (void)setNextBlock:(NextBlock)nextBlock
{
    objc_setAssociatedObject(self, &STYNotificationNextBlockKey, nextBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)observeNotification:(NSString *)notificationName next:(void (^)(id object, NSDictionary *userInfo))nextBlock
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(observeMethod:) name:notificationName object:nil];
    if (nextBlock) {
        [self setNextBlock:nextBlock];
    }
}

- (IBAction)observeMethod:(NSNotification *)notification
{
    if ([self nextBlock]) {
        [self nextBlock](notification.object, notification.userInfo);
    }
}

- (void)postNotificationName:(NSString *)notificationName
{
    [self postNotificationName:notificationName object:nil userInfo:nil];
}

- (void)postNotificationName:(NSString *)notificationName object:(id)object
{
    [self postNotificationName:notificationName object:object userInfo:nil];
}

- (void)postNotificationName:(NSString *)notificationName object:(id)object userInfo:(NSDictionary *)userInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:object userInfo:userInfo];
}

@end

#pragma mark - STYNotification

@implementation STYNotification

@end
