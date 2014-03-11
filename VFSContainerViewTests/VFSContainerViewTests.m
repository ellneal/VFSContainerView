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

@end
