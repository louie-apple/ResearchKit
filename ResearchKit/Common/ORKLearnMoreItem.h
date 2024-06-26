/*
 Copyright (c) 2019, Apple Inc. All rights reserved.
 
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

#import <Foundation/Foundation.h>
#import <ResearchKit/ORKDefines.h>

NS_ASSUME_NONNULL_BEGIN

@class ORKLearnMoreInstructionStep;
@class ORKLearnMoreView;
@protocol ORKLearnMoreViewDelegate;

/**
 An object that allows additional information to be
 presented with a question.
 */

ORK_CLASS_AVAILABLE
@interface ORKLearnMoreItem : NSObject <NSCopying, NSSecureCoding>


/**
 * Returns an initialized `ORKLearnMoreItem` using specified values.

 @param text                        Text to be used in title label of button. If nil, the button is initialized with type `UIButtonTypeDetailDisclosure`.
 @param learnMoreInstructionStep    The `ORKLearnMoreInstructionStep` to be presented when button is pressed.
 @return An initialized learn more item.
 */
- (instancetype)initWithText:(nullable NSString *)text learnMoreInstructionStep:(ORKLearnMoreInstructionStep *)learnMoreInstructionStep;

/**
 * Convenience class initializer to create a button.
 * Using this initializer initializes the button with type `UIButtonTypeCustom`, and assures that button's title label will have text.
 * Returns an initialized `ORKLearnMoreItem` using specified values.

 @param text                        Text to be used as title label of button.
 @param learnMoreInstructionStep    The `ORKLearnMoreInstructionStep` to be used in `ORKLearnMoreStepViewController` to present when the button is pressed.
 @return An inittialized learn more item.
 */
+ (instancetype)learnMoreItemWithText:(NSString *)text learnMoreInstructionStep:(ORKLearnMoreInstructionStep *)learnMoreInstructionStep;

/**
 Text to be used in title label of button.
 */
@property (nonatomic, nullable) NSString *text;

/**
 The `ORKLearnMoreInstructionStep` to be presented when the button is pressed.
 */
@property (nonatomic, nonnull) ORKLearnMoreInstructionStep *learnMoreInstructionStep;

@property (nonatomic, weak) id<ORKLearnMoreViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
