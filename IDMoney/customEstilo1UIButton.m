//
//  customEstilo1UIButton.m
//  BNCR_App
//
//  Created by Jose Carrillo on 12/29/16.
//  Copyright © 2016 Arc1Lab. All rights reserved.
//

#import "customEstilo1UIButton.h"

@interface customEstilo1UIButton()
@property UIColor *customBackgroundColor;
@end

@implementation customEstilo1UIButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)setup{
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowRadius = 1.0;
    self.layer.shadowOpacity = 0.8;
    [super setBackgroundColor:[UIColor clearColor]];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setBackgroundColor:(UIColor *)backgroundColor{
    self.customBackgroundColor = backgroundColor;
    super.backgroundColor = [UIColor clearColor];
}

-(void)drawRect:(CGRect)rect{
    [self.customBackgroundColor setFill];
    [[UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.cornerRadius] fill];
    
    CGFloat borderInset = self.borderWidth/2;
    CGRect borderRect = CGRectInset(self.bounds, borderInset, borderInset);
    UIBezierPath *borderPath = [UIBezierPath bezierPathWithRoundedRect:borderRect cornerRadius:self.cornerRadius - borderInset];
    [self.borderColor setStroke];
    borderPath.lineWidth = self.borderWidth;
    [borderPath stroke];
    
    // whatever else you need drawn
}


@end
