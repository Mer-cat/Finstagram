//
//  ProfileViewController.m
//  Finstagram
//
//  Created by Mercy Bickell on 7/9/20.
//  Copyright © 2020 mercycat. All rights reserved.
//

#import "ProfileViewController.h"
#import <Parse/Parse.h>
#import "PostCollectionCell.h"
#import "PostDetailsViewController.h"
#import "ComposeViewController.h"
#import "Post.h"

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *postArray;
@property (nonatomic, strong) PFUser *user;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation ProfileViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.user = [PFUser currentUser];
    
    [self reloadProfile];
    [self reloadPosts];
    
    // Add refresh control for collection view
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl setTintColor:[UIColor redColor]];
    [self.refreshControl addTarget:self action:@selector(reloadPosts) forControlEvents:UIControlEventValueChanged];
    [self.collectionView insertSubview:self.refreshControl atIndex:0];
    
    // Allows refreshing even when collection view is not full
    self.collectionView.alwaysBounceVertical = YES;
}

#pragma mark - Init

- (void)reloadProfile {
    self.usernameLabel.text = self.user[@"username"];
    
    // Set image either to place holder or what user selected
    UIImage *placeholderImage = [UIImage imageNamed:@"image_placeholder"];
    [self.profileImage setImage: placeholderImage];
    [self.user[@"profileImage"] getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error getting image: %@", error.localizedDescription);
        } else {
            [self.profileImage setImage: [UIImage imageWithData:data]];
        }
    }];
}

/**
 * Create new image picker to allow user to select profile image from their camera or photo library
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

/**
 * Fetch posts that have been posted by the current user from Parse
 */
- (void)reloadPosts {
    PFQuery *postQuery = [PFQuery queryWithClassName:@"Post"];
    [postQuery whereKey:@"author" equalTo:self.user];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;
    
    // Fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> *posts, NSError *error) {
        if (posts != nil) {
            self.postArray = posts;
            [self.collectionView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
    }];
}

#pragma mark - Actions

- (IBAction)onTapProfileImage:(id)sender {
    [self initUIImagePickerController];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.postArray.count;
}

/**
 * Associate each collection view cell with a particular post
 */
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PostCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionCell" forIndexPath:indexPath];
    Post *post = self.postArray[indexPath.item];
    [cell refreshPost:post];
    return cell;
}

#pragma mark - UIImagePickerControllerDelegate

/**
 * Delegate method for UIImagePickerController
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
    // Assign image chosen to appear in the image view
    UIImage *resizedImage = [ComposeViewController resizeImage:originalImage withSize:CGSizeMake(400, 400)];
    self.profileImage.image = resizedImage;
    PFFileObject *imageFile = [Post getPFFileFromImage:resizedImage];
    self.user[@"profileImage"] = imageFile;
    [self.user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if (succeeded) {
            NSLog(@"The profile image was saved!");
        } else {
            NSLog(@"Problem saving profile image: %@",error.localizedDescription);
        }
    }];
    
    // Dismiss UIImagePickerController to go back to your original view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation

/**
 * Pass post corresponding to tapped cell to the details view controller
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"postDetailsFromCollectionSegue"]) {
        PostDetailsViewController *detailsViewController = [segue destinationViewController];
        PostCollectionCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
        Post *specificPost = self.postArray[indexPath.item];
        detailsViewController.post = specificPost;
    }
}

@end
