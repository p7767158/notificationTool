# notificationTool
A NSNotification tool, use block replace the selector, and remove observer auto.

import "STYNotification.h"

[self observeNotification:kDismissNotification next:^(id object, NSDictionary *userInfo) {

        NSLog(@"object: %@", [object description]);
        NSLog(@"userinfo: %@", [userInfo description]);
				
}];

custom notificationName in STYNotification.h.
