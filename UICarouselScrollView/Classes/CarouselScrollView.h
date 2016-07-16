
#import <UIKit/UIKit.h>

@protocol CarouselScrollViewDelegate;

@interface CarouselScrollView : UIView

@property (nonatomic, assign) NSInteger cacheCount; //default = 2
@property (nonatomic, assign) NSInteger numberOfPage;
@property (nonatomic, assign) float slideTime;  //if 0, don't auth slide
@property (nonatomic, assign) float maxWidth;
@property (nonatomic, assign) BOOL shouldDetectNextAndPreviousClickEvent;

@property (nonatomic, weak) id <CarouselScrollViewDelegate> delegate;

- (void)setGradientColors:(NSArray *)colors;

//If needed
- (void)reloadCarouselView;

@end


@protocol CarouselScrollViewDelegate <NSObject>

@required
- (UIView *)carouselScrollView:(CarouselScrollView *)view viewAtPage:(NSInteger)page;

@optional
- (void)carouselScrollView:(CarouselScrollView *)view clickedAtPage:(NSInteger)page;
- (NSString *)carouselScrollView:(CarouselScrollView *)view titleAtPage:(NSInteger)page;
- (NSString *)carouselScrollView:(CarouselScrollView *)view subTitleAtPage:(NSInteger)page;

@end
