# NotificationUtils
A Notification on iOS.
###![alt tag](https://github.com/s9ya76/NotificationUtils/blob/master/Simulator%20Screen%20Shot.png)

## Notices
The current version is working with Xcode Version 7. If you are using different Xcode version, please check out the previous releases.

## Getting Started
### Installation
If you're using Xcode 7 and above, Swifter can be installed by simply dragging the Swifter Xcode project into your own project and adding either the ConnectionChecker as an embedded framework.

### How to use
#### Get notification view on top of screen in view controller:
```sh
self.notificationLabel
```
#### Show notification view:
```sh
UIViewController.showNotificationOnTop(self.notificationLabel, duration: 10, animated: true, hiddeOnTouch: true)
```
#### Close notification view:
```sh
UIViewController.closeNotificationOnTop(self.notificationLabel)
```

## Requirements
  - iOS 8 or later
  - Swift 2.0
