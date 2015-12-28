//
//  UIView+ViewController.m
//  Movie
//
//  Created by xzm on 13-9-18.
//  Copyright (c) 2013年 ios. All rights reserved.
//

#import "UIView+ViewController.h"

@implementation UIView (ViewController)

-(UIViewController *)viewController{
   
    id next = [self nextResponder];
    
    while (next) {
        next = [next nextResponder];
        if ([next isKindOfClass:[UIViewController class]]) {
            
            return next;
        }
    }
    return nil;
}

@end
