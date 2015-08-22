//
//  CJRingBezierView.m
//  CJBezierPath
//
//  Created by Constantin Jacob on 09.06.15.
//  Copyright (c) 2015 Constantin Jacob. All rights reserved.
//

#import "CJRingBezierView.h"

@implementation CJRingBezierView

@synthesize progressRingColor, backgroundRingColor, backgroundLineWidth, progressLineWidth;

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
#if TARGET_INTERFACE_BUILDER
    [self IBSetupSublayers];
    
#else
    [self setupSubLayers];
#endif
    
}

//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if (self) {
//#if !TARGET_INTERFACE_BUILDER
////        [self setupSubLayers];
//#endif
//    }
//    
//    return self;
//}


- (void)setupSubLayers
{
    self.backgroundRing = [CAShapeLayer layer];
    self.backgroundRing.bounds = self.frame;
    self.backgroundRing.frame = self.frame;
    self.backgroundRing.path = [self drawBezierRingWithCenter:CGPointMake(self.layer.frame.size.width/2, self.layer.frame.size.height/2) andRingRadius:self.center.x/2];
//    self.backgroundRing.backgroundColor = [UIColor redColor].CGColor;
    
    self.backgroundRing.fillColor = nil;
    self.backgroundRing.strokeColor = [UIColor greenColor].CGColor;
    self.backgroundRing.lineWidth = 10;
    
    self.progressRing = [CAShapeLayer layer];
    self.progressRing.bounds = self.frame;
    self.progressRing.frame = self.bounds;
    self.progressRing.path = [self drawBezierRingWithCenter:CGPointMake(self.progressRing.bounds.size.width, self.progressRing.bounds.size.height) andRingRadius:100];
    self.progressRing.fillColor = nil;
    self.progressRing.strokeColor = [UIColor redColor].CGColor;
    self.progressRing.lineWidth = 10;
    self.progressRing.strokeEnd = 0.0;
    self.progressRing.lineCap = kCALineCapRound;
    
    [self.layer addSublayer:self.backgroundRing];
    [self.layer addSublayer:self.progressRing];
}



- (void)IBSetupSublayers
{
    self.backgroundRing = [CAShapeLayer layer];
    self.backgroundRing.bounds = self.bounds;
    self.backgroundRing.frame = self.frame;
    self.backgroundRing.path = [self drawBezierRingWithCenter:CGPointMake(self.backgroundRing.bounds.size.width, self.backgroundRing.bounds.size.height) andRingRadius:100];
    self.backgroundRing.fillColor = nil;
    self.backgroundRing.strokeColor = [self.backgroundRingColor CGColor];
    self.backgroundRing.lineWidth = self.backgroundLineWidth;
    
    
    self.progressRing = [CAShapeLayer layer];
    self.progressRing.bounds = self.bounds;
    self.progressRing.frame = self.frame;
    self.progressRing.path = [self drawBezierRingWithCenter:CGPointMake(self.progressRing.bounds.size.width, self.progressRing.bounds.size.height) andRingRadius:100];
    self.progressRing.strokeEnd = self.IBProgress/10;
    self.progressRing.fillColor = nil;
    self.progressRing.strokeColor = [self.progressRingColor CGColor];
    self.progressRing.lineWidth = self.progressLineWidth;
    self.progressRing.lineCap = kCALineCapRound;
    
    [self.layer addSublayer:self.backgroundRing];
    [self.layer addSublayer:self.progressRing];
}

- (CGPathRef)drawBezierRingWithCenter:(CGPoint)center andRingRadius:(float)radius
{
    
    double eins = CGRectGetMidX(self.bounds);
    double zwei = CGRectGetMidY(self.bounds);
    
    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(eins, zwei) radius:130 startAngle:-M_PI_2 endAngle:(2*M_PI-M_PI_2) clockwise:YES].CGPath;
}


- (void)setProgress:(double)progress
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double lastKnownProgress = [defaults doubleForKey:@"lastKnownProgress"];
    [self startAnimatingProgressRingLayerFromValue:lastKnownProgress toValue:progress animated:NO];
    [defaults setDouble:progress forKey:@"lastKnownProgress"];
    [defaults synchronize];
}

- (void)setProgress:(double)progress animated:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    double lastKnownProgress = 0;//[defaults doubleForKey:@"lastKnownProgress"];
    self.progressRing.strokeEnd = progress;
    [self startAnimatingProgressRingLayerFromValue:lastKnownProgress toValue:progress animated:animated];
    [defaults setDouble:progress forKey:@"lastKnownProgress"];
    [defaults synchronize];
}


- (void)startAnimatingProgressRingLayerFromValue:(double)fromValue toValue:(double)toValue animated:(BOOL)animated
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    if (animated) {
        animation.duration = 2.0;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    } else {
        animation.duration = 0.01;
    }
    
    animation.fromValue = [NSNumber numberWithDouble:fromValue];
    animation.toValue = [NSNumber numberWithDouble:toValue];
    animation.removedOnCompletion = YES;
    
    [self.progressRing addAnimation:animation forKey:nil];
}



@end
