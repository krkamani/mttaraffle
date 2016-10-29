//
//  ViewController.h
//  MTTA Raffle
//
//  Created by Krishna R Kamani on 10/21/16.
//  Copyright © 2016 Krishna R Kamani. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIBarButtonItem *resetButton;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *picknextButton;

@property (strong, nonatomic) IBOutlet UITextField *minTextBox;
@property (strong, nonatomic) IBOutlet UITextField *maxTextBox;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)resetButtonClicked:(id)sender;
- (IBAction)pickNextWinner:(id)sender;
@end

