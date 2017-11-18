//
//  TechnicalViewController.m
//  FPESeals
//
//  Created by Christopher Bone on 15/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import "TechnicalViewController.h"
#import "CylinderProperty.h"
#import "CylinderProperties.h"
#import "TechnicalDetailViewController.h"

@interface TechnicalViewController ()

@property (strong, nonatomic) CylinderProperties *cylinder;

@end

@implementation TechnicalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.allowsSelection = NO;    // Disables Selecting rows
    
    self.cylinder = [[CylinderProperties alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Data Source

// Number Of Sections in Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {  return 1; }    // Only 1 section in Table View

// Number Of Rows in Section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSUInteger count;
    count = self.cylinder.cylinderProperties.count;       // Number of objects in Cylinder Properties Array
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell;
    
    // Determing cell style for row
    if (indexPath.row < 5) {
        // Input Style Cell
        cell = [tableView dequeueReusableCellWithIdentifier:@"InputCells" forIndexPath:indexPath];
    } else if (5 < indexPath.row && indexPath.row < 12) {
        // Output Style Cell
        cell = [tableView dequeueReusableCellWithIdentifier:@"OutputCells" forIndexPath:indexPath];
    } else {
        // Spacer Style Cell
        cell = [tableView dequeueReusableCellWithIdentifier:@"SpacerCell" forIndexPath:indexPath];
    }
   
    // Adding Cell Text (if appropiate)
    if (![cell.reuseIdentifier isEqualToString:@"SpacerCell"]) {
    CylinderProperty *temp = [[CylinderProperty alloc] init];
    temp = [self.cylinder.cylinderProperties objectAtIndex:indexPath.row];
    cell.textLabel.text = temp.propertyTitle;
    }
    return cell;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"PropertyDetail"]) {       // Segue Identifier = "PropertyDetail"
        
        TechnicalDetailViewController *destinationVC = [segue destinationViewController];       // Destination View Controller
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];          // Grabbing the index path of the cell who's accessory button was pressed
        
        CylinderProperty *tempProperty = [ self.cylinder.cylinderProperties objectAtIndex:indexPath.row];       // Getting assocaited cylinder property temporiarly
        
        destinationVC.property = tempProperty;      // Setting the destination cylinder property
    }
}

#pragma mark UITextField Delegates

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
    
}


@end
