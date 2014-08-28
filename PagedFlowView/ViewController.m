//
//  ViewController.m
//  PagedFlowView
//
//  Created by Lu Kejin on 3/5/12.
//  Copyright (c) 2012 geeklu.com. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ViewController
@synthesize hFlowView;
@synthesize vFlowView;
@synthesize hPageControl;



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    imageArray = [[NSArray alloc] initWithObjects:@"0.tiff",@"1.tiff",@"2.tiff",@"3.tiff",@"4.tiff",@"5.tiff",@"6.tiff",@"7.tiff",nil];
    
    hFlowView.delegate = self;
    hFlowView.dataSource = self;
    hFlowView.pageControl = hPageControl;
    hFlowView.minimumPageAlpha = 0;
    hFlowView.minimumPageScale = 1;
    
    vFlowView.delegate = self;
    vFlowView.dataSource = self;
    vFlowView.minimumPageAlpha = 0.4;
    vFlowView.minimumPageScale = 0.8;
    vFlowView.orientation = PagedFlowViewOrientationVertical;
    
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark PagedFlowView Delegate
- (CGSize)sizeForPageInFlowView:(PagedFlowView *)flowView;{
    return CGSizeMake(200, 150);
}

- (void)flowView:(PagedFlowView *)flowView didScrollToPageAtIndex:(NSInteger)index {
    NSLog(@"Scrolled to page # %d ", index);
    
//    UIView *tmpView = [[UIView alloc] initWithFrame:CGRectMake(arc4random()%130, arc4random()%130, 10+arc4random()%130, 10+arc4random()%130)];
//    tmpView.backgroundColor = [UIColor colorWithRed:(arc4random()%255)/255
//                                              green:(arc4random()%255)/255
//                                               blue:(arc4random()%255)/255
//                                              alpha:1];
//    [[flowView getCurrentView] addSubview:tmpView];
//    NSLog(@"Scrolled to page # %d  - %@", index,NSStringFromCGRect(tmpView.frame));
}

- (void)flowView:(PagedFlowView *)flowView didTapPageAtIndex:(NSInteger)index{
    NSLog(@"Tapped on page # %d", index);
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark PagedFlowView Datasource
//返回显示View的个数
- (NSInteger)numberOfPagesInFlowView:(PagedFlowView *)flowView{
    return [imageArray count];
}

//返回给某列使用的View
- (UIView *)flowView:(PagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    UIImageView *imageView = (UIImageView *)[flowView dequeueReusableCell];
    if (!imageView) {
        imageView = [[UIImageView alloc] init];
        imageView.layer.cornerRadius = 6;
        imageView.layer.masksToBounds = YES;
    }
    imageView.image = [UIImage imageNamed:[imageArray objectAtIndex:index]];
    return imageView;
}

- (IBAction)pageControlValueDidChange:(id)sender {
    UIPageControl *pageControl = sender;
    [hFlowView scrollToPage:pageControl.currentPage];
    [vFlowView scrollToPage:pageControl.currentPage];
}

@end
