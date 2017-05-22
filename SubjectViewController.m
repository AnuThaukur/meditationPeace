//
//  SubjectViewController.m
//  Planit
//
//  Created by Rahul Raman  Sharma on 10/03/14.
//  Copyright (c) 2014 Rahul Raman  Sharma. All rights reserved.
//

#import "SubjectViewController.h"
#import "HomeViewController.h"
#import "AddDueDateViewController.h"
#import "FileUploadViewController.h"
@interface SubjectViewController ()

@end

@implementation SubjectViewController

@synthesize mSubjectsTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    mSubjectsarray=[[NSMutableArray alloc]init];
    mSubjectsdict =[[NSMutableDictionary alloc]init];
    
    [mSubjectsarray addObjectsFromArray:[PREF valueForKey:@"subjectsdata"]];
   
    NSLog(@"details%@",mSubjectsarray);
    
    
    mSubjectsTableView.delegate=self;
    mSubjectsTableView.dataSource=self;
      
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
#pragma mark --
#pragma mark -- UITableViewDelegate Method --



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == mSubjectsTableView) {
        return [mSubjectsarray count];
        
    }
    else if (tableView == mSubjectsTableView){
        return [mSubjectsarray count];
        
    }
    return YES;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (tableView == mSubjectsTableView) {
            NSDictionary *dict=[mSubjectsarray objectAtIndex:[indexPath row]];
            cell.textLabel.text =[dict valueForKey:@"subject"];

          }
    else if (tableView == mSubjectsTableView){
        // cell.textLabel.text =  [mSubjectsarray objectAtIndex:[indexPath row]];
        
    }
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == mSubjectsTableView) {
        if ([indexPath row]==[mSubjectsarray count]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please add subject"
                                                            message:nil
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Continue", nil];
            [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
            [alert show];
        }
        else{
            
        }
        
    }
    else if (tableView == mSubjectsTableView){
        
    }
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = [indexPath row];
    NSUInteger count = [mSubjectsarray count];
    
    if (row < count) {
        return UITableViewCellEditingStyleDelete;
    } else {
        return UITableViewCellEditingStyleNone;
    }
}
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = [indexPath row];
    NSUInteger count = [mSubjectsarray count];
    
    if (count) {
        [mSubjectsarray removeObjectAtIndex:row];
        [PREF removeObjectForKey:@"subjectsdata"];
        [PREF setObject:mSubjectsarray forKey:@"subjectsdata"];
        [PREF synchronize];
        NSLog(@"name%@ ",[PREF valueForKey:@"subjectsdata"]);
        [mSubjectsTableView reloadData];

    }
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    if([title isEqualToString:@"Continue"])
    {
        UITextField *subjecttxt = [alertView textFieldAtIndex:0];
        NSLog(@"Subject: %@", subjecttxt.text);
        if (subjecttxt.text.length>0) {
            [mSubjectsdict setValue:subjecttxt.text forKey:@"subject"];
            
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Choose Color"
                                                                               message:nil
                                                                       delegate:self
                                                              cancelButtonTitle:@"Cancel"
                                                              otherButtonTitles:@"Red",@"Yellow",@"Green",@"Blue", nil];
                       [alert show];
            
    
        }
        
        
    }
    else{

        NSLog(@"title: %@", title);
        if([title isEqualToString:@"Cancel"])
        {
            
            }
        else{
        [mSubjectsdict setValue:title forKey:@"color"];

        NSLog(@"details%@",mSubjectsarray);
        NSLog(@"details%@",mSubjectsdict);
        [mSubjectsarray addObject:mSubjectsdict];
            mSubjectsdict=nil;
            mSubjectsdict =[[NSMutableDictionary alloc]init];

        [PREF removeObjectForKey:@"subjectsdata"];
        [PREF setObject:mSubjectsarray forKey:@"subjectsdata"];
        [PREF synchronize];
        NSLog(@"name%@ ",[PREF valueForKey:@"subjectsdata"]);
        [mSubjectsTableView reloadData];

        }
    }
}

 - (IBAction)AddSubject:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please add subject"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Continue", nil];
    [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
    [alert show];
}


- (void)tableView:(UITableView *)tableView
didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //[self updateViewTitle];
    [tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
