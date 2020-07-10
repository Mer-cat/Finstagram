//
//  PostDetailsViewController.m
//  Finstagram
//
//  Created by Mercy Bickell on 7/8/20.
//  Copyright © 2020 mercycat. All rights reserved.
//

#import "PostDetailsViewController.h"
#import "DateTools.h"

@interface PostDetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *postImage;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeAgoLabel;

@end

@implementation PostDetailsViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPost];
}

#pragma mark - Init

- (void)initPost {
    // Set image
    UIImage *placeholderImage = [UIImage imageNamed:@"image_placeholder"];
    [self.post.image getDataInBackgroundWithBlock:^(NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error getting image: %@", error.localizedDescription);
            [self.postImage setImage: placeholderImage];
        } else {
            [self.postImage setImage: [UIImage imageWithData:data]];
        }
    }];
    
    // Set labels
    self.usernameLabel.text = self.post.author.username;
    self.captionLabel.text = self.post.caption;
    NSDate *timeCreated = self.post.createdAt;
    self.timeAgoLabel.text = [NSString stringWithFormat:@"Posted %@ ago", timeCreated.shortTimeAgoSinceNow];
}

@end
