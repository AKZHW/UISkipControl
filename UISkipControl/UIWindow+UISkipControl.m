//
//  UIWindow+UISkipControl.m
//  UISkipControlOC
//
//  Created by AKsoftware on 2016/10/24.
//  Copyright © 2016年 AKsoftware. All rights reserved.
//

#import "UIWindow+UISkipControl.h"
#import <objc/runtime.h>

static NSString *isAnimatedKey = @"isAnimated";
static NSString *skipQueueKey= @"skipQueueKey";

@interface UIWindow (SkipControl)

@property (nonatomic, strong) NSMutableArray *skipQueue;

@end

@implementation UIWindow (UISkipControl)

- (BOOL)isAnimated
{
    NSNumber *number = objc_getAssociatedObject(self, &isAnimatedKey);
    if (!number) {
        self.isAnimated = NO;
    }
    return number.boolValue;
}

- (void)setIsAnimated:(BOOL)isAnimated
{
    objc_setAssociatedObject(self, &isAnimatedKey, [NSNumber numberWithBool:isAnimated], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (NSMutableArray *)skipQueue
{
    NSMutableArray *skipQueue = objc_getAssociatedObject(self, &skipQueueKey);
    if (!skipQueue) {
        skipQueue = [NSMutableArray array];
    }
    [self setSkipQueue:skipQueue];
    return skipQueue;
}

- (void)setSkipQueue:(NSMutableArray *)skipQueue
{
    objc_setAssociatedObject(self, &skipQueueKey, skipQueue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)performSkipQueue
{
    if(!self.isAnimated) {
        SkipBlock block = [self.skipQueue firstObject];
        if (block) {
            block();
            [self.skipQueue removeObjectAtIndex:0];
        }
    }
}

- (void)enqueueSkipBlock:(SkipBlock)block
{
    if (block) {
        [self.skipQueue addObject:block];
    }
}


+ (UIWindow *)windowForViewController:(UIViewController *)viewController
{
    UIViewController *pViewController = viewController;
    while (pViewController && !pViewController.view.window) {
        pViewController = pViewController.presentedViewController;
    }
    return pViewController.view.window;
}

+ (UIViewController *)windowForTopViewController:(UIViewController *)viewController
{
    UIViewController *pViewController = viewController;
    while (pViewController && !pViewController.view.window) {
        pViewController = pViewController.presentedViewController;
    }
    return pViewController;
}


@end
