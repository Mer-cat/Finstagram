//
//  LoginViewController.m
//  Finstagram
//
//  Created by Mercy Bickell on 7/6/20.
//  Copyright © 2020 mercycat. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

/**
 * View controller for initial login screen, where users can register or log in
 */
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

#pragma mark - Actions

- (IBAction)didTapSignUp:(id)sender {
    [self registerUser];
}

- (IBAction)didTapLogin:(id)sender {
    [self loginUser];
}

#pragma mark - Parse network calls

- (void)registerUser {
    // Initialize a user object
    PFUser *newUser = [PFUser user];
    
    // Check for empty username or password
    if ([self.usernameField.text isEqual:@""]) {
        [self createAlertWithMessage:@"Please enter your username" withTitle:@"Username required"];
    }
    if([self.passwordField.text isEqual:@""]) {
        [self createAlertWithMessage:@"Please enter your password" withTitle:@"Password required"];
    }
    
    // Set user properties
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    // Call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
            [self createAlertWithMessage:error.localizedDescription withTitle:@"Error signing up"];
        } else {
            NSLog(@"User registered successfully");
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

- (void)loginUser {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
            NSLog(@"User log in failed: %@", error.localizedDescription);
            [self createAlertWithMessage:error.localizedDescription withTitle:@"Error logging in"];
        } else {
            NSLog(@"User logged in successfully");
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
        }
    }];
}

#pragma mark - UIAlertController helper

/**
 * Create new alert on the screen with specified message and title
 */
- (void)createAlertWithMessage:(NSString *) alertMessage withTitle:(NSString *)title {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:alertMessage
                                                            preferredStyle:(UIAlertControllerStyleAlert)];
    
    // Create an OK action
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
        // Dismiss the view.
    }];
    // Add the OK action to the alert controller
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:^{
        // Optional code for what happens after the alert controller has finished presenting
    }];
}

@end
