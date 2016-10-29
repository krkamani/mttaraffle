//
//  ViewController.m
//  MTTA Raffle
//
//  Created by Krishna R Kamani on 10/21/16.
//  Copyright © 2016 Krishna R Kamani. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){

    NSMutableArray *tableData;
    int from;
    int to;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    tableData = [[NSMutableArray alloc] init];
    [_minTextBox setDelegate:self];
    [_maxTextBox setDelegate:self];
    self.tableView.tableFooterView = [UIView new];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    NSString *text = @"Last pick is -> 0";
    if(indexPath.row == 0){
        text = [text stringByAppendingString:[NSString stringWithFormat:@"%@",[tableData objectAtIndex:[tableData count] - [indexPath row]-1]]];
        
        UIFont *fontBold = [UIFont fontWithName:@"HelveticaNeue-Bold" size:20];
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc]initWithString:text];
        
        [string addAttribute:NSFontAttributeName value:fontBold range:NSMakeRange(0, [text length])];
        
        cell.textLabel.attributedText = string;
        
        
    } else {
        text = @"Pick ";
        text = [text stringByAppendingString:[NSString stringWithFormat:@"%lu",[tableData count] - [indexPath row]]];
        text = [text stringByAppendingString: @" of "];
        text = [text stringByAppendingString:[NSString stringWithFormat:@"%lu",[tableData count]]];
        text = [text stringByAppendingString: @" is -> 0"];
        text = [text stringByAppendingString:[NSString stringWithFormat:@"%@",[tableData objectAtIndex:[tableData count] - [indexPath row]-1]]];
            cell.textLabel.text = text;
    }
    
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor whiteColor];
    }
    else
    {
        
        
      UIColor *color =   [[UIColor alloc] initWithRed:230.0 / 255 green:230.0 / 255 blue:230.0 / 255 alpha:1.0];
        
        cell.backgroundColor = color;
    }
 
    return cell;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)resetButtonClicked:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are you sure ?"
                                                                   message:@"Are u sure to end the Raffle , All the winners will be reset?"
                                                            preferredStyle:UIAlertControllerStyleAlert]; // 1
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Yes"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                                  [tableData removeAllObjects];
                                                              [[self minTextBox] setEnabled:TRUE];
                                                              [[self maxTextBox] setEnabled:TRUE];
                                                              [[self minTextBox] setText:@""];
                                                              [[self maxTextBox] setText:@""];
                                                               [_tableView reloadData];
                                                          }];
    UIAlertAction *second = [UIAlertAction actionWithTitle:@"Cancel"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                              NSLog(@"You pressed button one");
                                                          }];
    [alert addAction:firstAction]; // 4
     [alert addAction:second]; // 4
    
    [self presentViewController:alert animated:YES completion:nil]; // 6
   
}

- (IBAction)pickNextWinner:(id)sender {
    
    NSString *alertMessage = @"";
    
    from = [_minTextBox.text intValue];
    to = [_maxTextBox.text intValue];
    
    if(from == 0){
        alertMessage = @"Please enter start Tag.";
    } else if(to == 0){
        alertMessage = @"Please enter end Tag.";
    } else if(to <= from) {
        alertMessage = @"Start Tag should be lesser than End Tag.";
    } if([tableData count] > to-from){
        alertMessage = @"More picks then number of Raffle's.";
    }
    
    if([alertMessage length] > 0) {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Please Verify"
                                                                   message:alertMessage
                                                            preferredStyle:UIAlertControllerStyleAlert]; // 1
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"OK"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                              NSLog(@"You pressed button one");
                                                          }];
    [alert addAction:firstAction]; // 4
    
    [self presentViewController:alert animated:YES completion:nil]; // 6
    } else {
        
        [[self minTextBox] setEnabled:FALSE];
        [[self maxTextBox] setEnabled:FALSE];
        
        bool isAlreadyPicked;
        
        int ramdomNumber = (int)from + arc4random() % (to-from+1);
        
        for (int i = 0; i < [tableData count]; i++){
            if(ramdomNumber == [[tableData objectAtIndex:i] intValue]){
                isAlreadyPicked = YES;
                [self pickNextWinner:self];
                break;
            }
        }
        if(!isAlreadyPicked){
        [tableData addObject:[NSNumber numberWithInt:ramdomNumber]];
        
         [_tableView reloadData];
        }
    }
  
}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 0.0f;
}

@end
