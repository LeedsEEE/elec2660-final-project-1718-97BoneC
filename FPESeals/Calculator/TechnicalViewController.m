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
#import "InputCell.h"
#import "OutputCell.h"

@interface TechnicalViewController ()

// Private Properties
@property (strong, nonatomic) NSMutableArray *LayoutArray;
@property (strong, nonatomic) CylinderProperties *cylinder;



@property (nonatomic) NSUInteger chosenTextField;


// Private Functions
- (NSMutableArray *)determineLayoutArray:(CylinderProperties *) inputarray;

// Private Actions
- (IBAction)textFieldEdited:(id)sender;
- (IBAction)backgroundPressed:(id)sender;



@end

@implementation TechnicalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.allowsSelection = NO;    // Disables Selecting rows
    
    
    self.cylinder = [[CylinderProperties alloc] init];
    self.LayoutArray = [self determineLayoutArray:self.cylinder];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Layout Setup

- (NSMutableArray *)determineLayoutArray:(CylinderProperties *) inputarray {
    
    NSMutableArray *layout = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < inputarray.cylinderPropertiesInput.count; i++) {
        // Transferring Input Properties
        [layout addObject:[inputarray.cylinderPropertiesInput objectAtIndex:i]];
    }
    
    [layout addObject:inputarray.Blank];
    
    for (int i = 0; i < inputarray.cylinderPropertiesOuput.count; i++) {
        // Transferring Input Properties
        [layout addObject:[inputarray.cylinderPropertiesOuput objectAtIndex:i]];
    }
    
    return layout;
    
}

#pragma mark - Table View Data Source

// Number Of Sections in Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {  return 1; }    // Only 1 section in Table View

// Number Of Rows in Section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    NSUInteger count;
    count = self.LayoutArray.count;       // Number of objects in Cylinder Properties Array
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CylinderProperty *temp = [[CylinderProperty alloc] init];
    temp = [self.LayoutArray objectAtIndex:indexPath.row];
    
    // Determing cell style for row
    if (temp.isInput) {
        // Input Style Cell
        InputCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"InputCells" forIndexPath:indexPath];
        cell.textLabel.text = temp.propertyTitle;
        cell.inputTextField.placeholder = temp.propertyUnitsMet;
        cell.contentView.tag = indexPath.row;       // To determine which Text Field corresponds to which cell(.contentView)
        return cell;
        
    } else if (!(temp.isInput) && [temp.propertyTitle isEqualToString:@"Blank"]) {
        // Spacer Style Cell (No Label)
        UITableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"SpacerCell" forIndexPath:indexPath];
        cell.contentView.tag = indexPath.row;       // To determine which Text Field corresponds to which cell(.contentView)
        return cell;
        
    } else {
        // Output Style Cell
        OutputCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"OutputCells" forIndexPath:indexPath];
        cell.textLabel.text = temp.propertyTitle;
        cell.contentView.tag = indexPath.row;       // To determine which Text Field corresponds to which cell(.contentView)
        cell.outputTextLabel.text = temp.propertyUnitsMet;
        return cell;
    }
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"PropertyDetail"]) {       // Segue Identifier = "PropertyDetail"
        
        TechnicalDetailViewController *destinationVC = [segue destinationViewController];       // Destination View Controller
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];          // Grabbing the index path of the cell who's accessory button was pressed
        
        CylinderProperty *tempProperty = [ self.LayoutArray objectAtIndex:indexPath.row];       // Getting assocaited cylinder property temporiarly
        
        destinationVC.property = tempProperty;      // Setting the destination cylinder property
    }
}



#pragma mark UITextField Delegates and Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // Gets the row index of the current (about to be editted) text field
    self.chosenTextField = [self rowIndexOfTextField:textField];
    return YES;
}

// Hitting "Done" (Return) Key on keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];

    return YES;
    
}

- (IBAction)textFieldEdited:(id)sender
{
    // Help obtained from: https://stackoverflow.com/questions/8483967/how-to-check-text-field-input-at-real-time
    UITextField *textField = (UITextField *)sender;
    NSLog(@"%2f", [textField.text doubleValue]);
}

// When tap gesture is recognised
- (IBAction)backgroundPressed:(id)sender
{
    // Loop through every cell in Table View
    for (NSUInteger i = 0; i < self.LayoutArray.count; i++) {
        
        // Getting cell at associated index path
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        InputCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        
        // If cells TextField is first responder, resign and break loop
        if ( [cell.inputTextField isFirstResponder]) {
            [cell.inputTextField resignFirstResponder];
            break;
        }
    }
}


- (NSUInteger)rowIndexOfTextField:(UITextField *)textField {
    
    // Help obtained from: https://stackoverflow.com/questions/5732438/how-to-get-uitableviewcells-index-from-its-edited-uitextfield
    UIView *contentView = textField.superview;      // Associated ContentView of TextField
    NSLog(@"Row = %ld", contentView.tag);           // Printing to console
    NSUInteger rowIndex = contentView.tag;          // Setting rowIndex to textfields row index (tag numbers specified in cellForRow function
    
    return rowIndex;
}

@end
