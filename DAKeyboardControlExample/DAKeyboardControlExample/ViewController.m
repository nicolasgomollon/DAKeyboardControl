//
//  ViewController.m
//  DAKeyboardControlExample
//
//  Created by Daniel Amitay on 7/16/12.
//  Copyright (c) 2012 Daniel Amitay. All rights reserved.
//

#import "ViewController.h"
#import "DAKeyboardControl.h"

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = @"DAKeyboardControl";
	self.view.backgroundColor = [UIColor lightGrayColor];
	
	UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, self.view.bounds.size.width, self.view.bounds.size.height - 40.0f)];
	tableView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	[self.view addSubview:tableView];
	
	UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0f, self.view.bounds.size.height - 40.0f, self.view.bounds.size.width, 40.0f)];
	toolbar.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth);
	[self.view addSubview:toolbar];
	
	UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(10.0f, 6.0f, toolbar.bounds.size.width - 20.0f - 68.0f, 30.0f)];
	textField.borderStyle = UITextBorderStyleRoundedRect;
	textField.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	[toolbar addSubview:textField];
	
	UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	sendButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
	[sendButton setTitle:NSLocalizedString(@"Send", nil) forState:UIControlStateNormal];
	sendButton.frame = CGRectMake(toolbar.bounds.size.width - 68.0f, 6.0f, 58.0f, 29.0f);
	[toolbar addSubview:sendButton];
	
	
	self.view.keyboardTriggerOffset = toolbar.bounds.size.height;
	
	[self.view addKeyboardPanningWithFrameBasedActionHandler:^(CGRect keyboardFrame, BOOL opening, BOOL closing) {
		/*
		 Try not to call "self" inside this block (retain cycle).
		 But if you do, make sure to remove DAKeyboardControl
		 when you are done with the view controller by calling:
		 [self.view removeKeyboardControl];
		 */
		
		CGRect toolbarFrame = toolbar.frame;
		toolbarFrame.origin.y = keyboardFrame.origin.y - toolbarFrame.size.height;
		toolbar.frame = toolbarFrame;
		
		CGRect tableViewFrame = tableView.frame;
		tableViewFrame.size.height = toolbarFrame.origin.y;
		tableView.frame = tableViewFrame;
	} constraintBasedActionHandler:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
		return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	} else {
		return YES;
	}
}

@end
