//
//  CJRingBezierView.h
//  CJBezierPath
//
//  Created by Constantin Jacob on 09.06.15.
//  Copyright (c) 2015 Constantin Jacob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

IB_DESIGNABLE
@interface CJRingBezierView : UIView

@property (nonatomic, strong) CAShapeLayer *progressRing;
@property (nonatomic, strong) CAShapeLayer *backgroundRing;
@property (nonatomic, assign) double progress;


@property (nonatomic) IBInspectable UIColor *backgroundRingColor;
@property IBInspectable UIColor *progressRingColor;
@property IBInspectable float IBProgress;
@property IBInspectable float backgroundLineWidth;
@property IBInspectable float progressLineWidth;



-(void)setProgress:(double)progress animated:(BOOL)animated;

-(void)setupSubLayers;

@end
