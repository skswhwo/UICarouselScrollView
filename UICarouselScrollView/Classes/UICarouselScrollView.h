
#import <UIKit/UIKit.h>

@protocol UICarouselScrollViewDelegate;

@interface UICarouselScrollView : UIView

@property (nonatomic, assign) NSInteger cacheCount; //default = 2
@property (nonatomic, assign) NSInteger numberOfPage;
@property (nonatomic, assign) float slideTime;  //if 0, don't auto slide
@property (nonatomic, assign) float maxWidth;   //if 0, screen size
@property (nonatomic, assign) BOOL shouldDetectNextAndPreviousClickEvent;

@property (nonatomic, weak) id <UICarouselScrollViewDelegate> delegate;

- (void)setGradientColors:(NSArray *)colors;

@end


@protocol UICarouselScrollViewDelegate <NSObject>

@required
- (UIView *)carouselScrollView:(UICarouselScrollView *)view viewAtPage:(NSInteger)page;

@optional
- (void)carouselScrollView:(UICarouselScrollView *)view clickedAtPage:(NSInteger)page;
- (NSString *)carouselScrollView:(UICarouselScrollView *)view titleAtPage:(NSInteger)page;
- (NSString *)carouselScrollView:(UICarouselScrollView *)view subTitleAtPage:(NSInteger)page;

@end
