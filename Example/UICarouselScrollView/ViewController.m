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
{
    UICarouselScrollView *carouselView;
}
@property (weak, nonatomic) IBOutlet UICarouselScrollView *nibView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initializeProperties];
    
    //Asynchronous
    [self requestSomething];
}

#pragma mark - Initializer
- (void)initializeProperties
{
    //Nib
    [self.nibView setMaxWidth:480];
    [self.nibView setDelegate:self];
    [self.nibView setSlideTime:3];
    [self.nibView setShouldDetectNextAndPreviousClickEvent:NO];
    [self.nibView setGradientColors:@[(id)[[UIColor blackColor] colorWithAlphaComponent:0].CGColor,(id)[[UIColor blackColor] colorWithAlphaComponent:0.6].CGColor]];
    
    //Programmatically
    carouselView = [[UICarouselScrollView alloc] initWithFrame:CGRectMake(10, 300, 260, 180)];
    [self.view addSubview:carouselView];
    [carouselView setDelegate:self];
    [carouselView setMaxWidth:200];
    [carouselView setSlideTime:2];
    [carouselView setShouldDetectNextAndPreviousClickEvent:NO];
    [carouselView setGradientColors:@[(id)[[UIColor blackColor] colorWithAlphaComponent:0].CGColor,(id)[[UIColor blackColor] colorWithAlphaComponent:0.6].CGColor]];
}
#pragma mark - API
- (void)requestSomething
{
    [self performSelector:@selector(finishRequest) withObject:nil afterDelay:2];
}
- (void)finishRequest
{
    [self.nibView setNumberOfPage:3];
    [carouselView setNumberOfPage:3];
}

#pragma mark - CarouselScrollViewDelegate
- (UIView *)carouselScrollView:(UICarouselScrollView *)view viewAtPage:(NSInteger)page
{
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView setClipsToBounds:YES];
    [imageView setContentMode:UIViewContentModeScaleAspectFill];
    
    if (page == 0) {
        [imageView setImage:[self getImageRect:CGRectMake(0, 0, 1, 1) color:[UIColor redColor]]];
    } else if (page == 1) {
        [imageView setImage:[self getImageRect:CGRectMake(0, 0, 1, 1) color:[UIColor blueColor]]];
    } else if (page == 2) {
        [imageView setImage:[self getImageRect:CGRectMake(0, 0, 1, 1) color:[UIColor yellowColor]]];
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

-(UIImage *)getImageRect:(CGRect)rect color:(UIColor *)color
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
