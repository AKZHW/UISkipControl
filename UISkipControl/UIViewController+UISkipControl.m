//
//  UIViewController+UISkipControl.m
//  UISkipControlOC
//
//  Created by AKsoftware on 2016/10/24.
//  Copyright © 2016年 AKsoftware. All rights reserved.
//

#import "UIViewController+UISkipControl.h"
#import "UISkipControlHelper.h"
#import "UISkipControlManager.h"

@implementation UIViewController (UISkipControl)


+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UISkipControlHelper swizzlingOriginClass:self originMethodName:@"presentViewController:animated:completion:"
                                     currentClass:self currentMethodName:@"skipPresentViewController:animated:completion:"];
        
        [UISkipControlHelper swizzlingOriginClass:self originMethodName:@"dismissViewControllerAnimated:completion:"
                                     currentClass:self currentMethodName:@"skipPresentDismissViewControllerAnimated:completion:"];
    });
}
                  
- (void)skipPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion
{
    [self presentViewController:viewControllerToPresent animated:flag allowQueued:NO completion:completion];
}

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag allowQueued:(BOOL)isAllowQueued completion:(void (^)(void))completion
{
    [[UISkipControlManager sharedInstance] skipViewController:self skippedViewController:viewControllerToPresent skipType:UISkipControlSkipTypePresent animated:flag allowQueued:isAllowQueued completionBlock:completion];
}

- (void)skipPresentDismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
{
    [self dismissViewControllerAnimated:flag allowQueued:NO completion:completion];
}


- (void)dismissViewControllerAnimated:(BOOL)flag allowQueued:(BOOL)isAllowQueued completion:(void (^)(void))completion
{
    [[UISkipControlManager sharedInstance] skipViewController:self skippedViewController:nil skipType:UISkipControlSkipTypeDismiss animated:flag allowQueued:isAllowQueued completionBlock:completion];
}



@end
