//
//  STYNotification.h
//  test
//
//  Created by honghao5 on 17/4/17.
//  Copyright © 2017年 zhh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Notification)

- (void)observeNotification:(NSString *)notificationName next:(void (^)(id object, NSDictionary *userInfo))nextBlock;

- (void)postNotificationName:(NSString *)notificationName;
- (void)postNotificationName:(NSString *)notificationName object:(id)object;
- (void)postNotificationName:(NSString *)notificationName object:(id)object userInfo:(NSDictionary *)userInfo;

@end

#pragma mark - STYNotification

/**
 * Custom your own notification name
 */
static NSString * const kDismissNotification = @"kDismissNotification";

@interface STYNotification : NSObject

@end
