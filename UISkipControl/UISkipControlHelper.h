//
//  UISkipControlHelper.h
//  UISkipControlOC
//
//  Created by AKsoftware on 2016/10/24.
//  Copyright © 2016年 AKsoftware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UISkipControlHelper : NSObject
+ (void)swizzlingOriginClass:(Class)originClass originMethodName:(NSString *)originMethodName
                currentClass:(Class)currentClass currentMethodName:(NSString *)currentMethodName;
@end
