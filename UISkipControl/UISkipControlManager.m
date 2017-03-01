//
//  UISkipControlManager.m
//  UISkipControlOC
//
//  Created by AKsoftware on 2016/10/24.
//  Copyright © 2016年 AKsoftware. All rights reserved.
//

#import "UISkipControlManager.h"
#import "UINavigationController+UISkipControl.h"
#import "UIWindow+UISkipControl.h"
#import "UIViewController+UISkipControl.h"
#import <UIKit/UIKit.h>

@implementation UISkipControlManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static id __singleton__;
    dispatch_once(&onceToken, ^{
        __singleton__ = [[UISkipControlManager alloc] init];
    });
    return __singleton__;
}

- (instancetype)init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleUINavigationControllerSkipCompletion:) name:@"UINavigationControllerDidShowViewControllerNotification" object:nil];
    }
    return self;
}

- (void)handleUINavigationControllerSkipCompletion:(NSNotification *)notification
{
    UINavigationController *navigationController = notification.object;
    if ([navigationController isKindOfClass:[UINavigationController class]]) {
        if (navigationController.completionBlock) {
            navigationController.completionBlock();
        }
    }
}


#pragma realSkip

- (id)skipViewController:(nonnull UIViewController *)skippingController
   skippedViewController:(nullable UIViewController *)skippedViewController
                skipType:(UISkipControlSkipType)skipType
                animated:(BOOL)animatd
             allowQueued:(BOOL)isAllowQueeud
         completionBlock:(void(^)(void))competionBlock
{
    __weak UIWindow *weakWindow = [UIWindow windowForViewController:skippingController];
    
    if (!weakWindow) {
        //no Window
        return nil;
    }
    
    __weak UIViewController *weakSkippingController = skippingController;

    
    id cleanCompetionBlock = ^{
        __strong UIWindow *strongWindow = weakWindow;
        
        if (strongWindow) {
            strongWindow.isAnimated = NO;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (competionBlock) {
                competionBlock();
            }
            
            [strongWindow performSkipQueue];
            
        });
    };
    
    if (!weakWindow.isAnimated) {
        weakWindow.isAnimated = YES;
        return [self performSkipViewController:skippingController skippedViewController:skippedViewController skipType:skipType animated:animatd completionBlock:cleanCompetionBlock];
    } else if (isAllowQueeud) {
        __weak typeof(self) weakSelf = self;
        [weakWindow enqueueSkipBlock:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            __strong typeof(weakSkippingController) strongSkippingController = weakSkippingController;
            if (strongSelf && strongSkippingController) {
                [strongSelf performSkipViewController:strongSkippingController skippedViewController:skippedViewController skipType:skipType animated:animatd completionBlock:competionBlock];
            }
        }];
    }
    return nil;
}

- (id)performSkipViewController:(nonnull UIViewController *)skippingController
          skippedViewController:(nullable UIViewController *)skippedViewController
                       skipType:(UISkipControlSkipType)skipType
                       animated:(BOOL)animatd
                completionBlock:(void(^)(void))competionBlock
{
    if ([skippingController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)skippingController;
        navigationController.completionBlock = competionBlock;
    }
    
    
    switch (skipType) {
        case UISkipControlSkipTypePush:
        {
            UINavigationController *navigationController = (UINavigationController *)skippingController;
            NSAssert([navigationController isKindOfClass:[UINavigationController class]], @"%@ is not a UINavigationController", navigationController);
            [navigationController skipControlPushViewController:skippedViewController animated:animatd];
            return nil;
        }
            break;
        case UISkipControlSkipTypePop:
        {
            UINavigationController *navigationController = (UINavigationController *)skippingController;
            NSAssert([navigationController isKindOfClass:[UINavigationController class]], @"%@ is not a UINavigationController", navigationController);
            return [navigationController skipControlPopViewControllerAnimated:animatd];
        }
            break;
        case UISkipControlSkipTypePopTo:
        {
            UINavigationController *navigationController = (UINavigationController *)skippingController;
            NSAssert([navigationController isKindOfClass:[UINavigationController class]], @"%@ is not a UINavigationController", navigationController);
           return [navigationController skipPopToViewController:skippedViewController animated:animatd];
        }
            break;
        
        case UISkipControlSkipTypePopToRoot:
        {
            UINavigationController *navigationController = (UINavigationController *)skippingController;
            NSAssert([navigationController isKindOfClass:[UINavigationController class]], @"%@ is not a UINavigationController", navigationController);
           return [navigationController skipPopToRootViewControllerAnimated:animatd];
        }
            break;
        case UISkipControlSkipTypePresent:
        {
            [skippingController skipPresentViewController:skippedViewController animated:animatd completion:competionBlock];
            return nil;
        }
            break;
        case UISkipControlSkipTypeDismiss:
        {
            [skippingController skipPresentDismissViewControllerAnimated:animatd completion:competionBlock];
            return nil;
        }
            
        default:
            break;
    }
    return nil;
}



@end
