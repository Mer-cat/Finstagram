# Project 4 - *Finstagram*

**Finstagram** is a photo sharing app using Parse as its backend.

Time spent: **25** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] User can sign up to create a new account using Parse authentication
- [X] User can log in and log out of his or her account
- [X] The current signed in user is persisted across app restarts
- [X] User can take a photo, add a caption, and post it to "Instagram"
- [X] User can view the last 20 posts submitted to "Instagram"
- [X] User can pull to refresh the last 20 posts submitted to "Instagram"
- [X] User can tap a post to view post details, including timestamp and caption.

The following **optional** features are implemented:

- [X] Run your app on your phone and use the camera to take the photo
- [ ] Style the login page to look like the real Instagram login page.
- [ ] Style the feed to look like the real Instagram feed.
- [X] User can use a tab bar to switch between all "Instagram" posts and posts published only by the user. AKA, tabs for Home Feed and Profile
- [ ] User can load more posts once he or she reaches the bottom of the feed using infinite scrolling.
- [X] Show the username and creation time for each post
- [X] After the user submits a new post, show a progress HUD while the post is being uploaded to Parse
- User Profiles:
  - [X] Allow the logged in user to add a profile photo
  - [X] Display the profile photo with each post
  - [ ] Tapping on a post's username or profile photo goes to that user's profile page
- [ ] User can comment on a post and see all comments for each post in the post details screen.
- [ ] User can like a post and see number of likes for each post in the post details screen.
- [ ] Implement a custom camera view.

The following **additional** features are implemented:

- [X] Implement a character limit on the caption and show characters remaining while user is typing.
- [X] Display timestamps as time ago using the DateTools pod
- [X] Implement autolayout on the main views of the app.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Using PFImageView to load images from files instead of current method
2. How to improve the UI, especially when a table view or collection view takes up only part of the screen

## Video Walkthrough

Here's a walkthrough of implemented user stories:

Main features:

<img src='http://g.recordit.co/WuySRVPegW.gif' title='Main features Walkthrough' width='' alt='Video Walkthrough' />

Selecting a profile photo:

<img src='http://g.recordit.co/62sMi9jhEm.gif' title='Profile Image Walkthrough' width='' alt='Video Walkthrough' />

Autolayout:

<img src='http://g.recordit.co/a6Qdy39kwn.gif' title='Autolayout Walkthrough' width='' alt='Video Walkthrough' />
GIF created with [Recordit](https://recordit.co/).

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [Parse](https://github.com/parse-community/Parse-SDK-iOS-OSX) - backend database
- [DateTools](https://github.com/MatthewYork/DateTools) - time formatting
- [MBProgressHUD](https://github.com/matej/MBProgressHUD) - HUD for progress when loading data

## Notes

Autolayout can be quite challenging at times. Also, it was interesting to learn that tap gesture recognizers don't function well in repeatable contexts such as table view cells.

## License

    Copyright [2020] [Mercy Bickell]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
