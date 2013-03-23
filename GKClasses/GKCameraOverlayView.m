//
//  GKCameraOverlayView.m
//  GKImagePicker
//
//  Created by Seb Martin on 2013-03-17.
//  Copyright (c) 2013 Georg Kitz. All rights reserved.
//

#import "GKCameraOverlayView.h"

@implementation GKCameraOverlayView

@synthesize shutterButton, toggleCameraButton;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Toolbar
        NSInteger barHeight = 44;
        CGRect toolbarFrame = CGRectMake(0, frame.size.height - barHeight, frame.size.width, barHeight);
        self.toolbar = [[UIToolbar alloc] initWithFrame:toolbarFrame];
        self.toolbar.barStyle = UIBarStyleBlackTranslucent;
        [self addSubview:self.toolbar];
        
        // Toolbar items
        self.cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:nil action:nil];
        NSMutableArray *items = [NSMutableArray arrayWithObjects:self.cancelButton, nil];
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            // Add camera toggle button if device has a front facing camera
            UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            self.toggleCameraButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
            [items addObjectsFromArray:@[flexItem, self.toggleCameraButton]];
        }
        [self.toolbar setItems:items animated:NO];
        
        // Shutter button
        CGRect buttonFrame;
        buttonFrame.size = CGSizeMake(64, 64);
        buttonFrame.origin = CGPointMake(frame.size.width - 80, frame.size.height / 2 - 32);
        self.shutterButton = [[UIButton alloc] initWithFrame:buttonFrame];
        [self.shutterButton setImage:[UIImage imageNamed:@"PLCameraShutterButton"] forState:UIControlStateNormal];
        [self.shutterButton setImage:[UIImage imageNamed:@"PLCameraShutterButtonPressed"] forState:UIControlStateHighlighted];
        [self addSubview:self.shutterButton];

    }
    return self;
}

@end
