//
//  UINavigationController+UISkipControl.h
//  UISkipControlOC
//
//  Created by AKsoftware on 2016/10/24.
//  Copyright © 2016年 AKsoftware. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (UISkipControl)

@property (nonatomic, copy) void (^completionBlock)(void);

//push
- (void)skipControlPushViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated isAllowQueued:(BOOL)allowQueued completionBlock:(void(^)(void))completionBlock;

//pop
- (UIViewController *)skipControlPopViewControllerAnimated:(BOOL)animated;

- (UIViewController *)popViewControllerAnimated:(BOOL)animated isAllowQueued:(BOOL)allowQueued completionBlock:(void(^)(void))completionBlock;

//popTo
- (NSArray *)skipPopToViewController:(UIViewController *)viewController animated:(BOOL)animated;

- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated isAllowQueued:(BOOL)allowQueued completionBlock:(void(^)(void))completionBlock;

//popToRoot
- (NSArray *)skipPopToRootViewControllerAnimated:(BOOL)animated;

- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated isAllowQueued:(BOOL)allowQueued completionBlock:(void(^)(void))completionBlock;
@end
