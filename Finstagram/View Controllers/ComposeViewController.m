//
//  ComposeViewController.m
//  Finstagram
//
//  Created by Mercy Bickell on 7/7/20.
//  Copyright © 2020 mercycat. All rights reserved.
//

#import "ComposeViewController.h"
#import "Post.h"
#import "MBProgressHUD.h"

/**
 * View controller for creating new posts, consisting of images with captions
 */
@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *captionField;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (nonatomic) NSInteger characterLimit;
@property (weak, nonatomic) IBOutlet UILabel *charactersRemainingLabel;

@end

@implementation ComposeViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.captionField.delegate = self;
    self.characterLimit = 2000;
    self.charactersRemainingLabel.text = [NSString stringWithFormat:@"%ld", self.characterLimit];
}

#pragma mark - Actions

- (IBAction)onTapImage:(id)sender {
    // Present image picker/camera
    [self initUIImagePickerController];
}

/**
 * Make a new post with an image and caption
 */
- (IBAction)didPressShare:(id)sender {
    
    // Show activity indicator while waiting for post to upload
    MBProgressHUD *activityIndicator = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    activityIndicator.label.text = NSLocalizedString(@"Loading...", @"HUD loading title");
    
    [Post postUserImage:self.postImage.image withCaption:self.captionField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"Successfully posted photo!");
            
            // Manually return to the home screen
            [self dismissViewControllerAnimated:true completion:nil];
        } else {
            NSLog(@"Failed to post photo: %@", error.localizedDescription);
        }
        [activityIndicator hideAnimated:YES];
    }];
}

- (IBAction)didPressCancel:(id)sender {
    // Manually return to the home screen
    [self dismissViewControllerAnimated:true completion:nil];
}

#pragma mark - UIImagePickerController init

/**
 * Create new image picker to allow user to select an image from their camera or photo library
 */
- (void)initUIImagePickerController {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        NSLog(@"Camera not available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate

/**
 * Delegate method for UIImagePickerController
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    // Assign image chosen to appear in the image view
    self.postImage.image = [ComposeViewController resizeImage:editedImage withSize:CGSizeMake(400, 400)];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

/**
 * Character limit method that accounts for copy/paste operations
 */
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)string {
    if (range.length + range.location > textView.text.length) {
        return NO;
    }
    
    NSUInteger newLength = [textView.text length] + [string length] - range.length;
    BOOL shouldChange = newLength <= self.characterLimit;
    
    // Update characters remaining
    if (shouldChange) {
    NSInteger charactersRemaining = self.characterLimit - newLength;
    self.charactersRemainingLabel.text = [NSString stringWithFormat:@"%ld/%ld", charactersRemaining, self.characterLimit];
    }
    
    return shouldChange;
}

#pragma mark - Image upload helper

/**
 * Resizes images since Parse only allows 10MB uploads for a photo
 * Note: this class could be better housed in a helper class, but it is currently the only helper method
 */
+ (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
