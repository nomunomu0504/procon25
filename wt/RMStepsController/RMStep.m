#import "RMStep.h"

@interface RMStep ()

@property (nonatomic, strong, readwrite) UIView *stepView;
@property (nonatomic, strong, readwrite) UILabel *numberLabel;
@property (nonatomic, strong, readwrite) UILabel *titleLabel;

@property (nonatomic, strong, readwrite) CAShapeLayer *circleLayer;

@end

@implementation RMStep

#pragma mark Properties
- (UIView *)stepView {
    if(!_stepView) {
        self.stepView = [[UIView alloc] initWithFrame:CGRectZero];
        _stepView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [_stepView.layer addSublayer:self.circleLayer];
        
        [_stepView addSubview:self.numberLabel];
        [_stepView addSubview:self.titleLabel];
        
        UILabel *titleLabel = self.titleLabel;
        UILabel *numberLabel = self.numberLabel;
        NSDictionary *bindingsDict = NSDictionaryOfVariableBindings(titleLabel, numberLabel);
        
        [_stepView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(40)-[titleLabel]-(0)-|" options:0 metrics:nil views:bindingsDict]];
        [_stepView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[titleLabel]-(0)-|" options:0 metrics:nil views:bindingsDict]];
        [_stepView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(11)-[numberLabel]-(9)-[titleLabel]" options:0 metrics:nil views:bindingsDict]];
        [_stepView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(0)-[numberLabel]-(0)-|" options:0 metrics:nil views:bindingsDict]];
    }
    
    return _stepView;
}

- (UILabel *)numberLabel {
    if(!_numberLabel) {
        self.numberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _numberLabel.text = @"0";
        _numberLabel.textColor = self.disabledTextColor;
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        _numberLabel.backgroundColor = [UIColor clearColor];
        _numberLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
        _numberLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _numberLabel;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.text = self.title;
        _titleLabel.textColor = self.disabledTextColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return _titleLabel;
}

- (CAShapeLayer *)circleLayer {
    if(!_circleLayer) {
        NSInteger radius = 12;
        
        self.circleLayer = [CAShapeLayer layer];
        _circleLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 2.0*radius, 2.0*radius) cornerRadius:radius].CGPath;
        _circleLayer.position = CGPointMake(9, 10);
        _circleLayer.fillColor = [UIColor clearColor].CGColor;
        _circleLayer.strokeColor = self.disabledTextColor.CGColor;
        _circleLayer.lineWidth = 1;
    }
    
    return _circleLayer;
}

- (void)setTitle:(NSString *)newTitle {
    if(_title != newTitle) {
        _title = newTitle;
        
        self.titleLabel.text = newTitle;
    }
}

- (UIColor *)selectedBarColor {
    if(!_selectedBarColor) {
        self.selectedBarColor = [UIColor colorWithRed:23./255. green:220./255. blue:108./255. alpha:1];
    }
    
    return _selectedBarColor;
}

- (UIColor *)enabledBarColor {
    if(!_enabledBarColor) {
        self.enabledBarColor = [UIColor colorWithWhite:142./255. alpha:0.5];
    }
    
    return _enabledBarColor;
}

- (UIColor *)disabledBarColor {
    if(!_disabledBarColor) {
        self.disabledBarColor = [UIColor clearColor];
    }
    
    return _disabledBarColor;
}

- (UIColor *)selectedTextColor {
    if(!_selectedTextColor) {
        self.selectedTextColor = [UIColor colorWithWhite:1 alpha:1];
    }
    
    return _selectedTextColor;
}

- (UIColor *)enabledTextColor {
    if(!_enabledTextColor) {
        self.enabledTextColor = [UIColor colorWithWhite:1 alpha:1];
    }
    
    return _enabledTextColor;
}

- (UIColor *)disabledTextColor {
    if(!_disabledTextColor) {
        self.disabledTextColor = [UIColor colorWithWhite:0.75 alpha:1];
    }
    
    return _disabledTextColor;
}

@end
