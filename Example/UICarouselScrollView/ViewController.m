//
//  ViewController.m
//  UICarouselScrollView
//
//  Created by ChoJaehyun on 2016. 7. 16..
//  Copyright © 2016년 com.skswhwo. All rights reserved.
//

#import "ViewController.h"

#import "UICarouselScrollView.h"

@interface ViewController ()
<UICarouselScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UICarouselScrollView *testView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeProperties];
    
    [self requestSomething];
}

#pragma mark - Initializer
- (void)initializeProperties
{
//    [self.testView setMaxWidth:375];
    [self.testView setDelegate:self];
    [self.testView setSlideTime:3];
    [self.testView setShouldDetectNextAndPreviousClickEvent:NO];
    [self.testView setGradientColors:@[(id)[[UIColor blackColor] colorWithAlphaComponent:0].CGColor,(id)[[UIColor blackColor] colorWithAlphaComponent:0.6].CGColor]];
}

#pragma mark - API
- (void)requestSomething
{
    [self performSelector:@selector(finishRequest) withObject:nil afterDelay:2];
}

#pragma mark - API Callback
- (void)finishRequest
{
    [self.testView setNumberOfPage:3];
}

#pragma mark - CarouselScrollViewDelegate
- (UIView *)carouselScrollView:(UICarouselScrollView *)view viewAtPage:(NSInteger)page
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setClipsToBounds:YES];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    
    if (page == 0) {
        [imageView setImage:[UIImage imageNamed:@"test0"]];
    } else if (page == 1) {
        [imageView setImage:[UIImage imageNamed:@"test1"]];
    } else if (page == 2) {
        [imageView setImage:[UIImage imageNamed:@"test2"]];
    }
    return imageView;
}

- (void)carouselScrollView:(UICarouselScrollView *)view clickedAtPage:(NSInteger)page
{
    NSLog(@"click %@",@(page));
}
- (NSString *)carouselScrollView:(UICarouselScrollView *)view titleAtPage:(NSInteger)page
{
    return [NSString stringWithFormat:@"title %@",@(page)];
}
- (NSString *)carouselScrollView:(UICarouselScrollView *)view subTitleAtPage:(NSInteger)page
{
    return [NSString stringWithFormat:@"sub title %@",@(page)];
}

@end
