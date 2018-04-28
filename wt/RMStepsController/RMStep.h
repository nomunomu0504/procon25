#import <Foundation/Foundation.h>

/**
 A `RMStep` is used to set the title of a certain step and to customize the appearance of this step in a `RMStepsBar`
 */

@interface RMStep : NSObject

/**
 Provides access to the title of this step as it is used by an instance of `RMStepsBar`.
 */
@property (nonatomic, strong) NSString *title;

/**
 Provides access to the selected bar color of this step as it is used by an instance of `RMStepsBar`.
 */
@property (nonatomic, strong) UIColor *selectedBarColor;

/**
 Provides access to the enabled bar color of this step as it is used by an instance of `RMStepsBar`.
 */
@property (nonatomic, strong) UIColor *enabledBarColor;

/**
 Provides access to the disabled bar color of this step as it is used by an instance of `RMStepsBar`.
 */
@property (nonatomic, strong) UIColor *disabledBarColor;

/**
 Provides access to the selected text color of this step as it is used by an instance of `RMStepsBar`.
 */
@property (nonatomic, strong) UIColor *selectedTextColor;

/**
 Provides access to the enabled text color of this step as it is used by an instance of `RMStepsBar`.
 */
@property (nonatomic, strong) UIColor *enabledTextColor;

/**
 Provides access to the disabled text color of this step as it is used by an instance of `RMStepsBar`.
 */
@property (nonatomic, strong) UIColor *disabledTextColor;

@end
