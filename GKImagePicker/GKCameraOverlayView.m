//
//  GKCameraOverlayView.m
//  GKImagePicker
//
//  Created by Seb Martin on 2013-03-17.
//  Copyright (c) 2013 Georg Kitz. All rights reserved.
//

#import "GKCameraOverlayView.h"

@implementation GKCameraOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Toolbar
        NSInteger barHeight = 44;
        CGRect toolbarFrame = CGRectMake(0, frame.size.height - barHeight, frame.size.width, barHeight);
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:toolbarFrame];
        toolbar.barStyle = UIBarStyleBlackTranslucent;
        [self addSubview:toolbar];
        
        // Shutter button
        CGRect buttonFrame;
        buttonFrame.size = CGSizeMake(64, 64);
        buttonFrame.origin = CGPointMake(frame.size.width - 80, frame.size.height / 2 - 32);
        UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
        [button setImage:[UIImage imageNamed:@"PLCameraShutterButton"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"PLCameraShutterButtonPressed"] forState:UIControlStateHighlighted];
        [self addSubview:button];
    }
    return self;
}

@end
