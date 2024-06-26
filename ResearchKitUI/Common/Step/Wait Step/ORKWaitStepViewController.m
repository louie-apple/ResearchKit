/*
 Copyright (c) 2015, Alejandro Martinez, Quintiles Inc.
 Copyright (c) 2015, Brian Kelly, Quintiles Inc.
 Copyright (c) 2015, Bryan Strothmann, Quintiles Inc.
 Copyright (c) 2015, Greg Yip, Quintiles Inc.
 Copyright (c) 2015, John Reites, Quintiles Inc.
 Copyright (c) 2015, Pavel Kanzelsberger, Quintiles Inc.
 Copyright (c) 2015, Richard Thomas, Quintiles Inc.
 Copyright (c) 2015, Shelby Brooks, Quintiles Inc.
 Copyright (c) 2015, Steve Cadwallader, Quintiles Inc.
 Copyright (c) 2015, Apple Inc. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 
 1.  Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2.  Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation and/or
 other materials provided with the distribution.
 
 3.  Neither the name of the copyright holder(s) nor the names of any contributors
 may be used to endorse or promote products derived from this software without
 specific prior written permission. No license is granted to the trademarks of
 the copyright holders even if such marks are included in this software.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


#import "ORKWaitStepViewController.h"

#import "ORKStepHeaderView_Internal.h"
#import "ORKWaitStepView.h"
#import "ORKStepView.h"
#import "ORKStepViewController_Internal.h"
#import "ORKNavigationContainerView_Internal.h"
#import "ORKWaitStep.h"
#import "ORKTaskViewController_Internal.h"

#import "ORKHelpers_Internal.h"

NSString * const ORKWaitStepViewAccessibilityIdentifier = @"ORKWaitStepView";


@implementation ORKWaitStepViewController {
    ORKWaitStepView *_waitStepView;
    ORKProgressIndicatorType _indicatorType;
    NSString *_updatedText;
    NSArray<NSLayoutConstraint *> *_constraints;
}

- (ORKWaitStep *)waitStep {
    return (ORKWaitStep *)self.step;
}

- (void)stepDidChange {
    [super stepDidChange];
    
    [_waitStepView removeFromSuperview];
    
    if (self.step && [self isViewLoaded]) {
        if (!_waitStepView) {
            // Collect the text content from step during the when _waitStepView hasn't been initialized.
            _updatedText = [self waitStep].text;
        }
        
        _waitStepView = [[ORKWaitStepView alloc] initWithIndicatorType:[self waitStep].indicatorType];
        _waitStepView.frame = self.view.bounds;
        _waitStepView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_waitStepView];
        [self setupNavigationFooterView];
        [self setupConstraints];
        _waitStepView.stepTopContentImage = self.step.image;
        _waitStepView.titleIconImage = self.step.iconImage;
        _waitStepView.stepTitle = self.step.title;
        _waitStepView.stepText = _updatedText;
        _waitStepView.stepDetailText = self.step.detailText;
        _waitStepView.stepHeaderTextAlignment = self.step.headerTextAlignment;
        _waitStepView.bodyItems = self.step.bodyItems;
        _waitStepView.stepTopContentImageContentMode = self.step.imageContentMode;
        _waitStepView.accessibilityIdentifier = ORKWaitStepViewAccessibilityIdentifier;
        
        [self.taskViewController setNavigationBarColor:[self.view backgroundColor]];
    }
}

- (void)setupNavigationFooterView {
    if (!_navigationFooterView) {
        _navigationFooterView = _waitStepView.navigationFooterView;
        _navigationFooterView.neverHasContinueButton = YES;
    }
}

- (void)setupConstraints {
    if (_constraints) {
        [NSLayoutConstraint deactivateConstraints:_constraints];
    }
    _constraints = nil;
    _waitStepView.translatesAutoresizingMaskIntoConstraints = NO;
    
    
    _constraints = @[
                     [NSLayoutConstraint constraintWithItem:_waitStepView
                                                  attribute:NSLayoutAttributeTop
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.view
                                                  attribute:NSLayoutAttributeTop
                                                 multiplier:1.0
                                                   constant:0.0],
                     [NSLayoutConstraint constraintWithItem:_waitStepView
                                                  attribute:NSLayoutAttributeLeft
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.view
                                                  attribute:NSLayoutAttributeLeft
                                                 multiplier:1.0
                                                   constant:0.0],
                     [NSLayoutConstraint constraintWithItem:_waitStepView
                                                  attribute:NSLayoutAttributeRight
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.view
                                                  attribute:NSLayoutAttributeRight
                                                 multiplier:1.0
                                                   constant:0.0],
                     [NSLayoutConstraint constraintWithItem:_waitStepView
                                                  attribute:NSLayoutAttributeBottom
                                                  relatedBy:NSLayoutRelationEqual
                                                     toItem:self.view
                                                  attribute:NSLayoutAttributeBottom
                                                 multiplier:1.0
                                                   constant:0.0]
                     ];
    [NSLayoutConstraint activateConstraints:_constraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self stepDidChange];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    [_waitStepView.progressView setProgress:progress animated:animated];
}

- (void)updateText:(NSString *)text {
    _updatedText = text;
    [self stepDidChange];
}

@end
