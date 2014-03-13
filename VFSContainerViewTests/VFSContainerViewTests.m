//
//  VFSContainerViewTests.m
//
//  Copyright (c) 2014 emdentec (http://emdentec.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
