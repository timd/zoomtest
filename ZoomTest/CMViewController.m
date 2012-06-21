//
//  CMViewController.m
//  ZoomTest
//
//  Created by Tim Duckett on 20/06/2012.
//  Copyright (c) 2012 Charismatic Megafauna Ltd. All rights reserved.
//

#import "CMViewController.h"
#import "TiledLayer.h"

@interface CMViewController ()

@property (nonatomic, strong) UIView *contentView;

@end

@implementation CMViewController

@synthesize contentView = _contentView;

@synthesize scrollView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.contentView = [[TiledLayer alloc] initWithFrame:CGRectMake(0, 0, 1000, 1740)];
    
    [self.scrollView setContentSize:self.contentView.frame.size];
    [self.scrollView addSubview:self.contentView];
    
    [self.scrollView setMinimumZoomScale:0.25];
    [self.scrollView setMaximumZoomScale:2.0];
    
    [self.scrollView setZoomScale:0.5];
    
}

- (void)viewDidUnload
{
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {

    return self.contentView;

}

@end
