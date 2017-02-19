//
//  UINavigationController+UISkipControl.m
//  UISkipControlOC
//
//  Created by AKsoftware on 2016/10/24.
//  Copyright © 2016年 AKsoftware. All rights reserved.
//

#import "UINavigationController+UISkipControl.h"
#import "UISkipControlHelper.h"
#import "UISkipControlManager.h"
#import <objc/runtime.h>

static NSString *completionKey = @"completionKey";


@implementation UINavigationController (UISkipControl)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UISkipControlHelper swizzlingOriginClass:self originMethodName:@"pushViewController:animated:"
                                     currentClass:self currentMethodName:@"skipControlPushViewController:animated:"];
        
        [UISkipControlHelper swizzlingOriginClass:self originMethodName:@"popViewControllerAnimated:"
                                     currentClass:self currentMethodName:@"skipControlPopViewControllerAnimated:"];
        
        [UISkipControlHelper swizzlingOriginClass:self originMethodName:@"popToViewController:animated:"
                                     currentClass:self currentMethodName:@"skipControlPopToViewController:animated:"];
        
        [UISkipControlHelper swizzlingOriginClass:self originMethodName:@"popToRootViewControllerAnimated:"
                                     currentClass:self currentMethodName:@"skipControlPopToRootViewControllerAnimated:"];
    });
}


- (void(^)(void))completionBlock
{
    return objc_getAssociatedObject(self, &completionKey);
}

- (void)setCompletionBlock:(void (^)(void))completionBlock
{
    objc_setAssociatedObject(self, &completionKey, completionBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma replace Method

- (void)skipControlPushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0 && animated) {
        [self pushViewController:viewController animated:animated isAllowQueued:NO completionBlock:nil];
    } else {
        [self skipControlPushViewController:viewController animated:animated];
    }
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated isAllowQueued:(BOOL)allowQueued completionBlock:(void(^)(void))completionBlock
{
    [[UISkipControlManager sharedInstance] skipViewController:self skippedViewController:viewController skipType:UISkipControlSkipTypePush animated:animated allowQueued:allowQueued completionBlock:completionBlock];
}


//pop
- (UIViewController *)skipControlPopViewControllerAnimated:(BOOL)animated
{
    return [self popViewControllerAnimated:animated isAllowQueued:NO completionBlock:nil];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated isAllowQueued:(BOOL)allowQueued completionBlock:(void(^)(void))completionBlock
{
    return [[UISkipControlManager sharedInstance] skipViewController:self skippedViewController:nil skipType:UISkipControlSkipTypePop animated:animated allowQueued:allowQueued completionBlock:completionBlock];
}

//popTo

- (NSArray *)skipPopToViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    return [self popToViewController:viewController animated:animated isAllowQueued:NO completionBlock:nil];
}

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated isAllowQueued:(BOOL)allowQueued completionBlock:(void(^)(void))completionBlock
{
    return [[UISkipControlManager sharedInstance] skipViewController:self skippedViewController:viewController skipType:UISkipControlSkipTypePopTo animated:animated allowQueued:allowQueued completionBlock:completionBlock];
}

//popToRoot
- (NSArray *)skipPopToRootViewControllerAnimated:(BOOL)animated
{
    return [self popToRootViewControllerAnimated:animated isAllowQueued:NO completionBlock:nil];
}

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated isAllowQueued:(BOOL)allowQueued completionBlock:(void(^)(void))completionBlock
{
    return [[UISkipControlManager sharedInstance] skipViewController:self skippedViewController:nil skipType:UISkipControlSkipTypePopToRoot animated:animated allowQueued:allowQueued completionBlock:completionBlock];

}

@end
