//
//  UIViewController+UISkipControl.h
//  UISkipControlOC
//
//  Created by AKsoftware on 2016/10/24.
//  Copyright © 2016年 AKsoftware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (UISkipControl)

- (void)skipPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion;

- (void)presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag allowQueued:(BOOL)isAllowQueued completion:(void (^)(void))completion;

- (void)skipPresentDismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion;

- (void)dismissViewControllerAnimated:(BOOL)flag allowQueued:(BOOL)isAllowQueued completion:(void (^)(void))completion;
@end
