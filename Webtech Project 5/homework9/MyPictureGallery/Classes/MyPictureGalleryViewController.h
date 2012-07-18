//
//  MyPictureGalleryViewController.h
//  MyPictureGallery
//
//  Created by Mansi Narain on 11/23/10.
//  Copyright 2010 University of Southern California. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FBConnect.h"
#import "FBLoginButton.h"

@interface MyPictureGalleryViewController : UIViewController
<FBRequestDelegate,
FBDialogDelegate,
FBSessionDelegate,UITextFieldDelegate>{
IBOutlet FBLoginButton* _fbButton;
IBOutlet UIButton* pictue1;
IBOutlet UIButton* pictue2;
IBOutlet UIButton* pictue3;
IBOutlet UIButton* pictue4;
IBOutlet UIButton* postonwall;	
IBOutlet UILabel* labeltext;
IBOutlet UITextField* textonwall;
IBOutlet UILabel* statustext;		
Facebook* _facebook;
NSArray* _permissions;
}


@property(readonly) Facebook *facebook;

-(IBAction)fbButtonClick:(id)sender;

-(IBAction)pictue1Click:(id)sender;

-(IBAction)pictue2Click:(id)sender;

-(IBAction)pictue3Click:(id)sender;

-(IBAction)pictue4Click:(id)sender;

-(IBAction)posttowallClick:(id)sender;

@end

