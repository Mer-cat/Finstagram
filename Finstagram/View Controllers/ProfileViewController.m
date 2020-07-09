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

@interface ProfileViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *postArray;
@property (nonatomic, strong) PFUser *user;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    self.user = [PFUser currentUser];
    
    [self reloadProfile];
    [self reloadPosts];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl setTintColor:[UIColor redColor]];
    
    // Refreshes posts when user pulls down
    [self.refreshControl addTarget:self action:@selector(reloadPosts) forControlEvents:UIControlEventValueChanged];
    [self.collectionView insertSubview:self.refreshControl atIndex:0];
    self.collectionView.alwaysBounceVertical = YES;
}

- (void)reloadProfile {
    self.usernameLabel.text = self.user[@"username"];
    // Set profile image
    // TODO: Allow user to choose profile image
    UIImage *placeholderImage = [UIImage imageNamed:@"image_placeholder"];
    [self.profileImage setImage: placeholderImage];
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

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.postArray.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    PostCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PostCollectionCell" forIndexPath:indexPath];
    
    // Associates cell and post
    cell.post = self.postArray[indexPath.item];
    [cell refreshPost];
    
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"postDetailsFromCollectionSegue"]) {
        PostDetailsViewController *detailsViewController = [segue destinationViewController];
        PostCollectionCell *tappedCell = sender;
        Post *specificPost = tappedCell.post;
        detailsViewController.post = specificPost;
    }
}


@end
