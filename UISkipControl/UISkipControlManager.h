//
//  UISkipControlManager.h
//  UISkipControlOC
//
//  Created by AKsoftware on 2016/10/24.
//  Copyright © 2016年 AKsoftware. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UISkipControlSkipType) {
    UISkipControlSkipTypeNone = 0,
    UISkipControlSkipTypePush,
    UISkipControlSkipTypePop,
    UISkipControlSkipTypePopTo,
    UISkipControlSkipTypePopToRoot,
    UISkipControlSkipTypePresent,
    UISkipControlSkipTypeDismiss,
};

@interface UISkipControlManager : NSObject

+ (nonnull instancetype)sharedInstance;

- (nullable id)skipViewController:(nonnull UIViewController *)skippingController
   skippedViewController:(nullable UIViewController *)skippedViewController
                skipType:(UISkipControlSkipType)skipType
                animated:(BOOL)animated
             allowQueued:(BOOL)isAllowQueeud
         completionBlock:(nullable void(^)(void))competionBlock;

@end
