//
//  MyPictureGalleryAppDelegate.h
//  MyPictureGallery
//
//  Created by Mansi Narain on 11/23/10.
//  Copyright 2010 University of Southern California. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPictureGalleryViewController.h"


@interface MyPictureGalleryAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    MyPictureGalleryViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

