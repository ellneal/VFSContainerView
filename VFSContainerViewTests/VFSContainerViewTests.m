//
//  VFSContainerViewTests.m
//  VFSContainerViewTests
//
//  Created by Elliot Neal on 11/03/2014.
//  Copyright (c) 2014 emdentec. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <VFSContainerView/VFSContainerView.h>


@interface VFSContainerViewTests : XCTestCase


@property (strong, nonatomic) VFSContainerView *containerView;

@end


@implementation VFSContainerViewTests


- (void)setUp {
    [super setUp];
    
    VFSContainerView *containerView = [[VFSContainerView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    [self setContainerView:containerView];
}

- (void)tearDown {
    [super tearDown];
    
    [self setContainerView:nil];
}

- (void)testRespondsToUserInteractionOutsideSubviewsEnabled {
    
    VFSContainerView *containerView = [self containerView];
    
    SEL getSelector = @selector(isUserInteractionOutsideSubviewsEnabled);
    SEL setSelector = @selector(setUserInteractionOutsideSubviewsEnabled:);
    
    XCTAssert([containerView respondsToSelector:getSelector], @"%s should exist on %@", sel_getName(getSelector), NSStringFromClass([containerView class]));
    XCTAssert([containerView respondsToSelector:setSelector], @"%s should exist on %@", sel_getName(setSelector), NSStringFromClass([containerView class]));
}

- (void)testUserInteractionOutsideSubviewsEnabledIsOffByDefault {
    
    VFSContainerView *containerView = [self containerView];
    
    XCTAssertFalse([containerView isUserInteractionOutsideSubviewsEnabled], @"isUserInteractionOutsideSubviewsEnabled should be NO by default.");
}

- (void)testIgnoresTouchesWhenUserInteractionOutsideSubviewsIsDisabledAndNoSubviewsExist {
    
    VFSContainerView *containerView = [self containerView];
    [containerView setUserInteractionOutsideSubviewsEnabled:NO];
    
    CGPoint touchPoint = [containerView center];
    BOOL isPointInside = [containerView pointInside:touchPoint withEvent:nil];
    
    XCTAssertFalse(isPointInside, @"VFSContainerView should consider points to not be inside when subview is not present.");
}

- (void)testDoesntIgnoreTouchesWhenUserInterationOutsideSubviewsIsEnabledAndNoSubviewsExist {
    
    VFSContainerView *containerView = [self containerView];
    [containerView setUserInteractionOutsideSubviewsEnabled:YES];
    
    CGPoint touchPoint = [containerView center];
    BOOL isPointInside = [containerView pointInside:touchPoint withEvent:nil];
    
    XCTAssertTrue(isPointInside, @"VFSContainerView should consider points to be inside when subview is not present and userInteractionOutsideSubviewsEnabled is true.");
}

- (void)testDoesntIgnoreTouchesInsideSubviewsWhenUserInterationOutsideSubviewsIsDisabled {
    
    VFSContainerView *containerView = [self containerView];
    [containerView setUserInteractionOutsideSubviewsEnabled:NO];
    
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(25, 25, 50, 50)];
    [containerView addSubview:subview];
    
    CGPoint touchPoint = [subview center];
    BOOL isPointInside = [containerView pointInside:touchPoint withEvent:nil];
    
    XCTAssertTrue(isPointInside, @"VFSContainerView should consider points to be inside when subview is present and userInteractionOutsideSubviewsEnabled is false.");
}

- (void)testIgnoresTouchesOutsideSubviewsWhenUserInteractionOutsideSubviewsIsDisabled {
    
    VFSContainerView *containerView = [self containerView];
    [containerView setUserInteractionOutsideSubviewsEnabled:NO];
    
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(25, 25, 50, 50)];
    [containerView addSubview:subview];
    
    CGPoint touchPoint = CGPointMake(20, 20);
    BOOL isPointInside = [containerView pointInside:touchPoint withEvent:nil];
    
    XCTAssertFalse(isPointInside, @"VFSContainerView should consider points to be outside when subview is present and userInteractionOutsideSubviewsEnabled is false, but the touch doesn't fall within a subview.");
}

- (void)testIgnoresTouchesInsideSubviewsWhenUserInterationOutsideSubviewsIsDisabledAndTheSubviewIsHidden {
    
    VFSContainerView *containerView = [self containerView];
    [containerView setUserInteractionOutsideSubviewsEnabled:NO];
    
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(25, 25, 50, 50)];
    [subview setHidden:YES];
    [containerView addSubview:subview];
    
    CGPoint touchPoint = [subview center];
    BOOL isPointInside = [containerView pointInside:touchPoint withEvent:nil];
    
    XCTAssertFalse(isPointInside, @"VFSContainerView should consider points to be outside when subview is present and userInteractionOutsideSubviewsEnabled is false, but the subview is hidden.");
}

- (void)testIgnoresTouchesInsideSubviewsWhenUserInterationOutsideSubviewsIsDisabledAndTheSubviewHasNoAlpha {
    
    VFSContainerView *containerView = [self containerView];
    [containerView setUserInteractionOutsideSubviewsEnabled:NO];
    
    UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(25, 25, 50, 50)];
    [subview setAlpha:0.f];
    [containerView addSubview:subview];
    
    CGPoint touchPoint = [subview center];
    BOOL isPointInside = [containerView pointInside:touchPoint withEvent:nil];
    
    XCTAssertFalse(isPointInside, @"VFSContainerView should consider points to be outside when subview is present and userInteractionOutsideSubviewsEnabled is false, but the subview has no alpha.");
}

@end
