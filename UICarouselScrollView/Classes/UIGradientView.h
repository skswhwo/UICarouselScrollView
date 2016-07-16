//
//  UIGradientView.h
//  UICarouselView
//
//  Created by ChoJaehyun on 2016. 7. 17..
//  Copyright © 2016년 com.skswhwo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIGradientView : UIView

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-property-synthesis"
@property (nonatomic, strong, readonly) CAGradientLayer *layer;
#pragma clang diagnostic pop
@end


