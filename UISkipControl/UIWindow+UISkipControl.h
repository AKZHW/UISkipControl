//
//  UIWindow+UISkipControl.h
//  UISkipControlOC
//
//  Created by AKsoftware on 2016/10/24.
//  Copyright © 2016年 AKsoftware. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SkipBlock)();

@interface UIWindow (UISkipControl)

@property (nonatomic, assign) BOOL isAnimated;

+ (UIWindow *)windowForViewController:(UIViewController *)viewController;
+ (UIViewController *)windowForTopViewController:(UIViewController *)viewController;


/**
 *  执行加入到此window的跳转队列里面来，包括push present pop等等
 */
- (void)performSkipQueue;

/**
 * 将操作加入到当前window队列之中
 *
 *  @param block
 */
- (void)enqueueSkipBlock:(SkipBlock)block;
@end
