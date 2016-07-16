
#import "CarouselScrollView.h"

#define BannerBaseIndex 40000
#define BannerContentAppearanceTime 0.2
#define BannerSlideTime 6

@interface CarouselScrollView ()
<UIScrollViewDelegate>
{
    NSTimer *scheduler;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *descriptionView;
@property (weak, nonatomic) IBOutlet UIView *gradientView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, assign) NSInteger currentViewIndex;

@end

@implementation CarouselScrollView

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        UIView *view = [[[NSBundle mainBundle] loadNibNamed:@"CarouselScrollView" owner:self options:nil] objectAtIndex:0];
        [view setFrame:self.bounds];
        [self addSubview:view];
        
        [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTop
                                                        multiplier:1
                                                          constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1
                                                          constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1
                                                          constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeTrailing
                                                        multiplier:1
                                                          constant:0]];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self initializeUI];
    [self initializeFont];
    [self initializeProperties];
}

- (void)initializeUI
{
    [self.descriptionView setHidden:YES];
    [self.gradientView setHidden:YES];
}

- (void)initializeFont
{
    self.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    self.subTitleLabel.font = [UIFont systemFontOfSize:14];
}

- (void)initializeProperties
{
    self.cacheCount                 = 2;
    self.slideTime                  = 6;
    self.scrollView.scrollsToTop    = NO;
    self.titleLabel.text            = @"";
    self.subTitleLabel.text         = @"";
    
    [self addObserver:self forKeyPath:@"bounds" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
}

#pragma mark - State
- (void)changeCompleteState
{
    [self.descriptionView setHidden:NO];
    self.descriptionView.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.descriptionView.alpha = 1;
    }];
    [self.activityIndicator stopAnimating];
}

#pragma mark - Setter
- (void)setNumberOfPage:(NSInteger)numberOfPage
{
    _numberOfPage = numberOfPage;
    
    [self.activityIndicator setHidden:YES];
    [self.descriptionView setHidden:NO];
    [self.pageControl setNumberOfPages:self.numberOfPage];
    [self reloadCarouselView];
}

- (void)setGradientColors:(NSArray *)colors
{
    [self.gradientView setHidden:NO];
//        self.gradientView.layer.colors = @[(id)[UIColorFromRGB(0x000000) colorWithAlphaComponent:0].CGColor,(id)[UIColorFromRGB(0x000000) colorWithAlphaComponent:0.6].CGColor];
}

- (void)setCurrentViewIndex:(NSInteger)currentViewIndex
{
    _currentViewIndex = currentViewIndex;
    if (self.numberOfPage > 0) {
        self.pageControl.currentPage = currentViewIndex%self.numberOfPage;
    }
}

#pragma mark - Timer
- (void)startTimer
{
    if (scheduler) {
        [scheduler invalidate];
        scheduler = nil;
    }
    scheduler = [NSTimer scheduledTimerWithTimeInterval:BannerSlideTime target:self selector:@selector(slideScheduler) userInfo:nil repeats:YES];
}
- (void)slideScheduler
{
    if ([self isVisible] == false && [self parentViewController] == nil) {
        [scheduler invalidate];
        scheduler = nil;
    }

    if (self.numberOfPage > 0) {
        [self slideToBannerWithDelta:1];
    }
}

#pragma mark - Content
- (void)reloadCarouselView
{
    if (self.numberOfPage > 0) {
        [self startTimer];
        NSInteger viewIndex = BannerBaseIndex * self.numberOfPage + MAX(self.pageControl.currentPage,0);
        [self reloadViewWithViewIndex:viewIndex];
    }
}
- (void)reloadViewWithViewIndex:(NSInteger)viewIndex
{
    //Page
    [self setCurrentViewIndex:viewIndex];
    
    //Clear Subview
    while ([self.scrollView subviews].count != 0) {
        [[[self.scrollView subviews] firstObject] removeFromSuperview];
    }
    
    //ScrollView Subview
    [self layoutIfNeeded];
    self.scrollView.contentSize = CGSizeMake(CGFLOAT_MAX, self.scrollView.frame.size.height);

    for (NSInteger i = -self.cacheCount; i <= self.cacheCount ; i++) {
        UIView *button   = [self getContentView:viewIndex + i];
        [self.scrollView addSubview:button];
    }

    //ScrollView Position
    [self.scrollView setContentOffset:CGPointMake([self getContentOffsetX_atIndex:viewIndex], 0) animated:YES];
    
    //ScrollView Content
    [self updateBannerDescription];
}

- (void)updateNextBannerView:(NSInteger)nextCurrentIndex delta:(NSInteger)delta
{
    [self setCurrentViewIndex:nextCurrentIndex];
    [self updateBannerDescription];
    
    for (int i=0 ; i<= self.cacheCount; i++) {
        NSInteger newIndex = self.currentViewIndex + delta*i;
        if ([self.scrollView viewWithTag:newIndex] == nil) {
            [self.scrollView addSubview:[self getContentView:newIndex]];
        }
    }
}

- (void)updateBannerDescription
{
    [UIView animateWithDuration:BannerContentAppearanceTime animations:^{
        self.titleLabel.alpha = 0;
        self.subTitleLabel.alpha = 0;
    } completion:^(BOOL finished) {
        
        self.titleLabel.text = [self getTitleDescription];
        self.subTitleLabel.text = [self getSubTitleDescription];
        
        [UIView animateWithDuration:BannerContentAppearanceTime animations:^{
            self.titleLabel.alpha = 1;
            self.subTitleLabel.alpha = 1;
        }];
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (self.numberOfPage == 0)
        return;
    
    [self startTimer];
    self.scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    
    CGFloat targetX = scrollView.contentOffset.x + velocity.x * 60.0;
    CGFloat tempIndex = targetX/[self getContentWidth];
    CGFloat targetIndex = 0;
    if (velocity.x == 0) {
        targetIndex = round(tempIndex);
    } else {
        targetIndex = (velocity.x > 0)?ceil(tempIndex):floor(tempIndex);
    }
    targetIndex = MAX(targetIndex, 0);
    targetContentOffset->x = [self getContentOffsetX_atIndex:targetIndex];
    
    NSInteger currentIndexCandidate = (NSInteger)targetIndex;
 
    NSInteger diff = currentIndexCandidate - self.currentViewIndex;
    if (ABS(diff) > self.cacheCount) {
        [self reloadViewWithViewIndex:(self.currentViewIndex + diff)];
    } else if (self.currentViewIndex > currentIndexCandidate) {
        [self updateNextBannerView:(self.currentViewIndex + diff) delta:-1];
    } else if (self.currentViewIndex < currentIndexCandidate) {
        [self updateNextBannerView:(self.currentViewIndex + diff) delta:1];
    }
}


#pragma mark - Banner Action
- (IBAction)viewTapped:(UITapGestureRecognizer *)recognizer
{
    if (self.numberOfPage > 0) {
        if ([self.delegate respondsToSelector:@selector(carouselScrollView:clickedAtPage:)]) {
            CGPoint point = [recognizer locationInView:self.scrollView];
            for (UIView *aSubView in [self.scrollView subviews]){
                if(CGRectContainsPoint(aSubView.frame, point)) {
                    [self bannerButtonClicked:aSubView.tag];
                }
            }
        }
    }
}
- (void)bannerButtonClicked:(NSInteger)viewIndex
{
    NSInteger delta = viewIndex - self.currentViewIndex;
    if (delta == 0)
    {
        [self.delegate carouselScrollView:self clickedAtPage:self.pageControl.currentPage];
    }
    else
    {
        if (self.shouldDetectNextAndPreviousClickEvent)
        {
            [self.delegate carouselScrollView:self clickedAtPage:viewIndex%self.numberOfPage];
        }
        else
        {
            [self startTimer];
            [self slideToBannerWithDelta:delta];
        }
    }
}

- (void)slideToBannerWithDelta:(NSInteger)delta
{
    //ScrollView Content (data)
    [self updateNextBannerView:self.currentViewIndex+delta delta:delta];
    
    //ScrollView Position
    [self.scrollView setContentOffset:CGPointMake([self getContentOffsetX_atIndex:self.currentViewIndex], 0) animated:YES];
    
}

#pragma mark - Observer
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self && [keyPath isEqualToString:@"bounds"]) {
        CGRect new = [[change objectForKey:@"new"] CGRectValue];
        CGRect old = [[change objectForKey:@"old"] CGRectValue];
        if (new.size.width != old.size.width) {
            [self reloadCarouselView];
        }
    }
}

#pragma mark - Private
- (UIView *)getContentView:(NSInteger)viewIndex
{
    NSInteger page   = viewIndex%self.numberOfPage;
    UIView *view = [self.delegate carouselScrollView:self viewAtPage:page];
    CGRect frame            = self.scrollView.frame;
    frame.size.width        = [self getContentWidth];
    float margin            = [UIScreen mainScreen].bounds.size.width - frame.size.width;
    frame.origin.x          = viewIndex * frame.size.width + margin/2;
    [view setFrame:frame];
    [view setTag:viewIndex];
    return view;
}

- (NSString *)getTitleDescription
{
    if ([self.delegate respondsToSelector:@selector(carouselScrollView:titleAtPage:)]) {
        return [self.delegate carouselScrollView:self titleAtPage:self.pageControl.currentPage];
    }
    return nil;
}

- (NSString *)getSubTitleDescription
{
    if ([self.delegate respondsToSelector:@selector(carouselScrollView:subTitleAtPage:)]) {
        return [self.delegate carouselScrollView:self subTitleAtPage:self.pageControl.currentPage];
    }
    return nil;
}

- (float)getContentOffsetX_atIndex:(NSInteger)targetIndex
{
    return targetIndex * [self getContentWidth];
}

- (float)getContentWidth
{
    return MIN([self getMaxWidth], [UIScreen mainScreen].bounds.size.width);
}

- (float)getMaxWidth
{
    return (self.maxWidth > 0?self.maxWidth:[UIScreen mainScreen].bounds.size.width);
}

- (BOOL)isVisible
{
    return self.window?true:false;
}

- (UIViewController *)parentViewController {
    UIResponder *responder = self;
    while ([responder isKindOfClass:[UIView class]])
        responder = [responder nextResponder];
    return (UIViewController *)responder;
}
@end
