//
//  TestViewController.m
//  testNotificationTool
//
//  Created by honghao5 on 17/4/20.
//  Copyright © 2017年 sina. All rights reserved.
//

#import "TestViewController.h"
#import "STYNotification.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    __weak typeof(self) weakSelf = self;
    
    [self observeNotification:kDismissNotification next:^(id object, NSDictionary *userInfo) {
        NSLog(@"object: %@", [object description]);
        NSLog(@"userinfo: %@", [userInfo description]);
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (IBAction)dismiss:(id)sender {
    NSString *testStr = @"haoge";
    [self postNotificationName:kDismissNotification object:testStr userInfo:@{@"sei":@"haoge"}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"释放了");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
