//
//  UISkipControlHelper.m
//  UISkipControlOC
//
//  Created by AKsoftware on 2016/10/24.
//  Copyright © 2016年 AKsoftware. All rights reserved.
//

#import "UISkipControlHelper.h"
#import <objc/runtime.h>

@implementation UISkipControlHelper

+ (void)swizzlingOriginClass:(Class)originClass originMethodName:(NSString *)originMethodName
                currentClass:(Class)currentClass currentMethodName:(NSString *)currentMethodName
{
    SEL originSelector = NSSelectorFromString(originMethodName);
    SEL currentSelector = NSSelectorFromString(currentMethodName);
    Method originMethod = class_getInstanceMethod(originClass, originSelector);
    Method currentMethod = class_getInstanceMethod(currentClass, currentSelector);
    BOOL isSwizzed = class_addMethod(originClass, originSelector, method_getImplementation(currentMethod), method_getTypeEncoding(currentMethod));
    if (isSwizzed) {
        class_replaceMethod(originClass, currentSelector,method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, currentMethod);
    }
}

@end
