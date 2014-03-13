//
//  VFSContainerView.m
//  VFSContainerView
//
//  Created by Elliot Neal on 11/03/2014.
//  Copyright (c) 2014 emdentec. All rights reserved.
//

#import "VFSContainerView.h"


@implementation VFSContainerView


- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    for (UIView *view in [self subviews]) {
        
        if (![view isHidden] && [view alpha] > 0.f) {
            
            CGPoint convertedPoint = [view convertPoint:point fromView:self];
            return [view pointInside:convertedPoint withEvent:event];
        }
    }
    
    return [self isUserInteractionOutsideSubviewsEnabled];
}

@end
