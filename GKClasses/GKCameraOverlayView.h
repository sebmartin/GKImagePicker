//
//  GKCameraOverlayView.h
//  GKImagePicker
//
//  Created by Seb Martin on 2013-03-17.
//  Copyright (c) 2013 Georg Kitz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GKCameraOverlayView : UIView

@property (strong, nonatomic) UIButton *shutterButton;
@property (strong, nonatomic) UIBarButtonItem *toggleCameraButton;
@property (strong, nonatomic) UIBarButtonItem *cancelButton;
@property (strong, nonatomic) UIToolbar *toolbar;

@end
