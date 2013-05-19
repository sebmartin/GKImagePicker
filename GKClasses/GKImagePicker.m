//
//  GKImagePicker.m
//  GKImagePicker
//
//  Created by Georg Kitz on 6/1/12.
//  Copyright (c) 2012 Aurora Apps. All rights reserved.
//

#import "GKImagePicker.h"
#import "GKImageCropViewController.h"
#import "GKCameraOverlayView.h"

@interface GKImagePicker ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, GKImageCropControllerDelegate>
@property (nonatomic, strong, readwrite) UIImagePickerController *imagePickerController;
- (void)_hideController;
@end

@implementation GKImagePicker

#pragma mark -
#pragma mark Getter/Setter

@synthesize cropSize, delegate, resizeableCropArea;
@synthesize imagePickerController = _imagePickerController;

-(UIImagePickerControllerSourceType)sourceType {
    return _imagePickerController.sourceType;
}

-(void)setSourceType:(UIImagePickerControllerSourceType)sourceType {
    if (sourceType == UIImagePickerControllerSourceTypeCamera &&
        [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == YES)
    {
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        _imagePickerController.showsCameraControls = NO;
        
        // Configure camera overlay view
        GKCameraOverlayView *view = [[GKCameraOverlayView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        [view.shutterButton addTarget:self action:@selector(onCameraShutter:) forControlEvents:UIControlEventTouchUpInside];
        view.cancelButton.target = self;
        view.cancelButton.action = @selector(onCancelCamera:);
        view.toggleCameraButton.target = self;
        view.toggleCameraButton.action = @selector(toggleCameraDevice:);
        _imagePickerController.cameraOverlayView = view;
    }
    else {
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
}

#pragma mark -
#pragma mark Init Methods

- (id)init{
    if (self = [super init]) {
        
        self.cropSize = CGSizeMake(320, 320);
        self.resizeableCropArea = NO;
        _imagePickerController = [[UIImagePickerController alloc] init];
        _imagePickerController.delegate = self;
        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    return self;
}

# pragma mark -
# pragma mark Private Methods

- (void)_hideController{
    
    if (![_imagePickerController.presentedViewController isKindOfClass:[UIPopoverController class]]){
        
        [self.imagePickerController dismissViewControllerAnimated:YES completion:nil];
        
    } 
    
}

#pragma mark -
#pragma mark UIImagePickerDelegate Methods

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    if ([self.delegate respondsToSelector:@selector(imagePickerDidCancel:)]) {
      
        [self.delegate imagePickerDidCancel:self];
        
    } else {
        
        [self _hideController];
    
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{

    // TODO: dismiss the camera controller?
    
    GKImageCropViewController *cropController = [[GKImageCropViewController alloc] init];
    cropController.contentSizeForViewInPopover = picker.contentSizeForViewInPopover;
    cropController.sourceImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    cropController.resizeableCropArea = self.resizeableCropArea;
    cropController.cropSize = self.cropSize;
    cropController.delegate = self;
    [picker pushViewController:cropController animated:YES];
    
}

#pragma mark -
#pragma GKImagePickerDelegate

- (void)imageCropController:(GKImageCropViewController *)imageCropController didFinishWithCroppedImage:(UIImage *)croppedImage{
    
    if ([self.delegate respondsToSelector:@selector(imagePicker:pickedImage:)]) {
        [self.delegate imagePicker:self pickedImage:croppedImage];   
    }
}

#pragma mark -
#pragma Camera actions

-(IBAction)onCameraShutter:(id)sender {
    if (self.sourceType == UIImagePickerControllerSourceTypeCamera) {
        [_imagePickerController takePicture];
    }
}

-(IBAction)onCancelCamera:(id)sender {
    
}

-(IBAction)toggleCameraDevice:(id)sender {
    if (_imagePickerController.cameraDevice == UIImagePickerControllerCameraDeviceRear) {
        _imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
    }
    else {
        _imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    }
}

@end
