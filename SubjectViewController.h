//
//  SubjectViewController.h
//  Planit
//
//  Created by Rahul Raman  Sharma on 10/03/14.
//  Copyright (c) 2014 Rahul Raman  Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubjectViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
   NSMutableArray *mSubjectsarray;
    NSMutableArray *mColourarray;
    NSMutableDictionary *mSubjectsdict;
}
@property (nonatomic,retain)IBOutlet UITableView *mSubjectsTableView;

- (IBAction)AddSubject:(id)sender;
//- (IBAction)EditClicked:(id)sender;
@end
