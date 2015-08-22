//
//  ViewController.m
//  CJBezierPath
//
//  Created by Constantin Jacob on 09.06.15.
//  Copyright (c) 2015 Constantin Jacob. All rights reserved.
//

#import "ViewController.h"
#import "CJRingBezierView.h"

@interface ViewController ()
@property (nonatomic, strong) IBOutlet CJRingBezierView *ring;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////            [self.ring setProgress:0.8 animated:NO];
//        self.ring.progress = 0.5;
//    });
    
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
//    NSLog(@"-- %f", self.ring.bounds.size.width);
//    NSLog(@"-! %f", self.ring.bounds.size.height);
//    [self.ring setupSubLayers];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
