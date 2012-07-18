//
//  MyPictureGalleryViewController.m
//  MyPictureGallery
//
//  Created by Mansi Narain on 11/23/10.
//  Copyright 2010 University of Southern California. All rights reserved.
//

#import "MyPictureGalleryViewController.h"
#import "FBConnect.h"

static NSString* kAppId = @"113237258742304";
static NSString* path =nil;

@implementation MyPictureGalleryViewController

@synthesize facebook = _facebook;

//////////////////////////////////////////////////////////////////////////////////////////////////
// UIViewController
/**
 * initialization
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (!kAppId) {
		NSLog(@"missing app id!");
		exit(1);
		return nil;
	}
	
	
	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		_permissions =  [[NSArray arrayWithObjects:
						  @"read_stream", @"offline_access",nil] retain];
	}
	
	return self;
}

/**
 * Set initial view
 */
- (void)viewDidLoad {
	_facebook = [[Facebook alloc] init];
	pictue1.hidden = YES;
	pictue2.hidden = YES;
	pictue3.hidden = YES;
	pictue4.hidden = YES;
	postonwall.hidden = YES;	
	labeltext.hidden =YES;
	labeltext.hidden =YES;
	textonwall.hidden =YES;
	textonwall.delegate =self;
	textonwall.returnKeyType = UIReturnKeyDone;
	_fbButton.isLoggedIn = NO;
	[_fbButton updateImage];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textfield {
	[textfield resignFirstResponder];
	return YES;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
// NSObject

- (void)dealloc {
	[pictue1 release];
	[pictue2 release];
	[pictue3 release];
	[pictue4 release];
	[postonwall release];
	[labeltext release];
	[statustext release];
	[textonwall release];
	[_fbButton release];
	[_facebook release];
	[_permissions release];
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// private

/**
 * Show the authorization dialog.
 */
- (void)login {
	[statustext setText:@""];
	[textonwall setText:@""];
	path = nil;
	pictue1.alpha =1;
	pictue2.alpha =1;
	pictue3.alpha =1;
	pictue4.alpha =1;
	[_facebook authorize:kAppId permissions:_permissions delegate:self];
}

/**
 * Invalidate the access token and clear the cookie.
 */
- (void)logout {
	[statustext setText:@""];
	[textonwall setText:@""];
	path = nil;
	pictue1.alpha =1;
	pictue2.alpha =1;
	pictue3.alpha =1;
	pictue4.alpha =1;
	[_facebook logout:self];

}

///////////////////////////////////////////////////////////////////////////////////////////////////
// IBAction

/**
 * Called on a login/logout button click.
 */
- (IBAction)fbButtonClick:(id)sender {
	if (_fbButton.isLoggedIn) {
		[self logout];
	} else {
		[self login];
	}
}




//Making Changes

-(IBAction)pictue1Click:(id)sender{
	pictue1.alpha = 0.5;
	pictue2.alpha = 1;
	pictue3.alpha = 1;
	pictue4.alpha =1;
	path = @"http://www-scf.usc.edu/~csci571/2010Fall/hw9/photo1.jpg";
}

-(IBAction)pictue2Click:(id)sender{
	pictue1.alpha = 1;
	pictue2.alpha = 0.5;
	pictue3.alpha = 1;
	pictue4.alpha =1;
	path = @"http://www-scf.usc.edu/~csci571/2010Fall/hw9/photo2.jpg";
}

-(IBAction)pictue3Click:(id)sender{
	pictue1.alpha = 1;
	pictue2.alpha = 1;
	pictue3.alpha = 0.5;
	pictue4.alpha =1;
	path = @"http://www-scf.usc.edu/~csci571/2010Fall/hw9/photo3.jpg";
}

-(IBAction)pictue4Click:(id)sender{
	pictue1.alpha = 1;
	pictue2.alpha = 1;
	pictue3.alpha = 1;
	pictue4.alpha =0.5;
	path = @"http://www-scf.usc.edu/~csci571/2010Fall/hw9/photo4.jpg";
}

-(IBAction)posttowallClick:(id)sender{
	//To check if user has selected an image
	if (path != nil) {
		
	NSString *textonwallpost = textonwall.text;
	
	SBJSON *jsonWriter = [[SBJSON new] autorelease];
	
	NSDictionary* actionLinks = [NSArray arrayWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:
														   @"MyPicture",@"text",path,@"href", nil], nil];
	
	NSString *actionLinksStr = [jsonWriter stringWithObject:actionLinks];
	NSDictionary* imageforfb = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"image", @"type",
                                path, @"src",
                                path, @"href",
                                nil];
	
	NSDictionary* attachment = [NSDictionary dictionaryWithObjectsAndKeys:
								textonwallpost, @"name",
								//textonwallpost, @"caption",
								path,@"href",
								[NSArray arrayWithObjects:imageforfb, nil ], @"media",
								nil];
	NSString *attachmentStr = [jsonWriter stringWithObject:attachment];
    //NSLog(attachmentStr);
	NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   kAppId, @"api_key",
								   @"Share on Facebook",  @"user_message_prompt",
								   actionLinksStr, @"action_links",
								   attachmentStr, @"attachment",
								   nil];
	
	
	[_facebook dialog:@"stream.publish"
			andParams:params
		  andDelegate:self];
	}
	else {
		[statustext setText:@"Please select a picture first"];
	}

}



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

//Changes Done

/**
 * Called when the user has logged in successfully.
 */
- (void)fbDidLogin {	
	UIImage *img1  = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www-scf.usc.edu/~csci571/2010Fall/hw9/photo1.jpg"]]];
	UIImage *img2  = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www-scf.usc.edu/~csci571/2010Fall/hw9/photo2.jpg"]]];
	UIImage *img3  = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www-scf.usc.edu/~csci571/2010Fall/hw9/photo3.jpg"]]];
	UIImage *img4  = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www-scf.usc.edu/~csci571/2010Fall/hw9/photo4.jpg"]]];
	[pictue1 setImage:img1 forState:UIControlStateNormal];
	[pictue2 setImage:img2 forState:UIControlStateNormal];
	[pictue3 setImage:img3 forState:UIControlStateNormal];
	[pictue4 setImage:img4 forState:UIControlStateNormal];
	pictue1.hidden=NO;
	pictue2.hidden=NO;
	pictue3.hidden=NO;
	pictue4.hidden=NO;
	postonwall.hidden = NO;
	labeltext.hidden=NO;
	statustext.hidden =NO;
	textonwall.hidden =NO;
	_fbButton.isLoggedIn = YES;
	[_fbButton updateImage];
}

/**
 * Called when the user canceled the authorization dialog.
 */
-(void)fbDidNotLogin:(BOOL)cancelled {
	NSLog(@"did not login");
}

/**
 * Called when the request logout has succeeded.
 */
- (void)fbDidLogout {
    pictue1.hidden=YES;
	pictue2.hidden=YES;
	pictue3.hidden=YES;
	pictue4.hidden=YES;
	postonwall.hidden = YES;
	labeltext.hidden=YES;
	statustext.hidden =YES;
	textonwall.hidden =YES;	
	_fbButton.isLoggedIn = NO;
	[statustext setText:@""];
	[_fbButton updateImage];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
// FBRequestDelegate

/**
 * Called when the Facebook API request has returned a response. This callback
 * gives you access to the raw response. It's called before
 * (void)request:(FBRequest *)request didLoad:(id)result,
 * which is passed the parsed response object.
 */
- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
	NSLog(@"received response");
};


/**
 * Called when an error prevents the Facebook API request from completing successfully.
 */
- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
	[statustext setText:[error localizedDescription]];
};


///////////////////////////////////////////////////////////////////////////////////////////////////
// FBDialogDelegate

/**
 * Called when a UIServer Dialog successfully return.
 */
- (void)dialogDidComplete:(FBDialog *)dialog {
	[statustext setText:@"Go check your Wall!"];
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

@end

