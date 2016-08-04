# UICarouselScrollView

Horizontal scrollable view with specific content width.

![alt text](https://github.com/skswhwo/UICarouselScrollView/blob/master/sample1.gif "demo")
![alt text](https://github.com/skswhwo/UICarouselScrollView/blob/master/sample2.gif "demo")

## Installation

UICarouselScrollView is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

`
pod "UICarouselScrollView"
`

And then run:

`
$ pod install
`

## Usage
### Delegate
```objective-c
@required
- (UIView *)carouselScrollView:(UICarouselScrollView *)view viewAtPage:(NSInteger)page;

@optional
- (void)carouselScrollView:(UICarouselScrollView *)view clickedAtPage:(NSInteger)page;
- (NSString *)carouselScrollView:(UICarouselScrollView *)view titleAtPage:(NSInteger)page;
- (NSString *)carouselScrollView:(UICarouselScrollView *)view subTitleAtPage:(NSInteger)page;
```
### Nib
```objective-c
[self.nibView setDelegate:self];
[self.nibView setSlideTime:3];
[self.nibView setShouldDetectNextAndPreviousClickEvent:NO];
[self.nibView setGradientColors:@[(id)[[UIColor blackColor] colorWithAlphaComponent:0].CGColor,(id)[[UIColor blackColor] colorWithAlphaComponent:0.6].CGColor]];
```

### Programmatically
```objective-c
carouselView = [[UICarouselScrollView alloc] initWithFrame:CGRectMake(10, 300, 260, 180)];
[self.view addSubview:carouselView];
[carouselView setDelegate:self];
[carouselView setMaxWidth:200];
[carouselView setSlideTime:2];
[carouselView setShouldDetectNextAndPreviousClickEvent:NO];
[carouselView setGradientColors:@[(id)[[UIColor blackColor] colorWithAlphaComponent:0].CGColor,(id)[[UIColor blackColor] colorWithAlphaComponent:0.6].CGColor]];
```

## Properties
```objective-c
@property (nonatomic, assign) NSInteger numberOfPage;	//trigger
@property (nonatomic, assign) NSInteger cacheCount; //default = 2 (previous&next pages)
@property (nonatomic, assign) float slideTime;  //if 0, don't auto slide
@property (nonatomic, assign) float maxWidth;   //if 0, view size
@property (nonatomic, assign) BOOL shouldDetectNextAndPreviousClickEvent;
```

## Author

skswhwo, skswhwo@gmail.com

## License

UICarouselScrollView is available under the MIT license. See the LICENSE file for more info.
