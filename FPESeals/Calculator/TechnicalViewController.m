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
#import "CylinderCalculations.h"

@interface TechnicalViewController ()

// Private Properties
@property (strong, nonatomic) CylinderProperties *cylinder;     // Object of Cylinder Properties (to get array to display)
@property (nonatomic) NSUInteger chosenTextField;               // Integer to store index of current chosen Text Field
@property (strong, nonatomic) CylinderCalculations *calculator; // Calculator Object


// Private Actions
- (IBAction)textFieldEdited:(UITextField *) sender;     // UITextField Action
- (IBAction)backgroundPressed:(id)sender;               // Tap Gesture

@end


@implementation TechnicalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.allowsSelection = NO;    // Disables Selecting rows
    
    // Intialising Objects and Arrays
    self.cylinder = [[CylinderProperties alloc] init];
    self.calculator = [[CylinderCalculations alloc] init];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View Data Source

// Number Of Sections in Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 2; }    // Only 2 section in Table View

// Number Of Rows in Section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.cylinder.cylinderPropertiesInput.count;     // Rows in Section 1 = Number of Input Variables
    } else if (section == 1) {
        return self.cylinder.cylinderPropertiesOuput.count;     // Rows in Section 2 = Number of Output Variables
    } else {
        return 0;
    }
    
}

// Cell For Row
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CylinderProperty *temp = [[CylinderProperty alloc] init];
    
    if (indexPath.section == 0 ) {
        temp = [self.cylinder.cylinderPropertiesInput objectAtIndex:indexPath.row];
        InputCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"InputCells" forIndexPath:indexPath];
        cell.textLabel.text = temp.propertyTitle;
        cell.inputTextField.placeholder = temp.propertyUnitsMet;
        cell.inputTextField.tag = indexPath.row;                //For use later to determine textfields row index
        return cell;
    } else if (indexPath.section == 1 ) {
        temp = [self.cylinder.cylinderPropertiesOuput objectAtIndex:indexPath.row];
        OutputCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"OutputCells" forIndexPath:indexPath];
        cell.textLabel.text = temp.propertyTitle;
        cell.contentView.tag = indexPath.row;       // To determine which Text Field corresponds to which cell(.contentView)
        cell.outputTextLabel.text = temp.propertyUnitsMet;
        return cell;
    } else {
        // Spacer Style Cell (No Label)
        UITableViewCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:@"SpacerCell" forIndexPath:indexPath];
        cell.contentView.tag = indexPath.row;       // To determine which Text Field corresponds to which cell(.contentView)
        return cell;
    }
    
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"PropertyDetail"]) {       // Segue Identifier = "PropertyDetail"
        
        TechnicalDetailViewController *destinationVC = [segue destinationViewController];       // Destination View Controller
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];          // Grabbing the index path of the cell who's accessory button was pressed
        
        CylinderProperty *tempProperty;
        if (indexPath.section == 0 ) {
            tempProperty = [ self.cylinder.cylinderPropertiesInput objectAtIndex:indexPath.row];       // Getting assocaited cylinder property temporiarly
        } else if (indexPath.section == 1 ) {
            tempProperty = [ self.cylinder.cylinderPropertiesOuput objectAtIndex:indexPath.row];       // Getting assocaited cylinder property temporiarly
        }
        destinationVC.property = tempProperty;      // Setting the destination cylinder property
    }
}



#pragma mark UITextField Delegates and Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // Gets the row index of the current (about to be editted) text field
    // Help obtained from: https://stackoverflow.com/questions/5732438/how-to-get-uitableviewcells-index-from-its-edited-uitextfield
    self.chosenTextField = textField.tag;
    return YES;
}

// Hitting "Done" (Return) Key on keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];       // Removing Keyboard

    return YES;
    
}

// When tap gesture is recognised
- (IBAction)backgroundPressed:(id)sender
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chosenTextField inSection:0];    // Inputs only in first
                                                                                                //  section
    InputCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];     // Getting cell of textfields location
    if ( [cell.inputTextField isFirstResponder]) {                          // Making sure textfield is first responder
        [cell.inputTextField resignFirstResponder];                         // Resigning keyboard if so
    }
}

// Getting "Live" entered data
- (IBAction)textFieldEdited:(UITextField *)sender
{
    self.chosenTextField = sender.tag;
    // Help obtained from: https://stackoverflow.com/questions/8483967/how-to-check-text-field-input-at-real-time
    float data = [sender.text doubleValue];     // Converting from string to float
    NSNumber *value = [NSNumber numberWithFloat:data];
    
    [self.calculator.inputVariables replaceObjectAtIndex:self.chosenTextField withObject:value];
    
    [self.calculator calculateValues];
    
    /* if (self.chosenTextField == 0)      // Bore Diameter
    {
        NSLog(@"Bore Diameter = %2f", data);
        [self.calculator setBoreDiameter:data];     // Setting value
    }
    else if ( self.chosenTextField == 1)        // Rod Diameter
    {
        NSLog(@"Rod Diameter = %2f", data);
        [self.calculator setRodDiameter:data];      // Setting value
    }
    else if (self.chosenTextField == 2 )        // Stroke Length
    {
        NSLog(@"Stroke Length = %2f", data);
        [self.calculator setStrokeLength:data];     // Setting value
    }
    else if (self.chosenTextField == 3)         // Input Pressure
    {
        NSLog(@"Input Pressure = %2f", data);
        [self.calculator setInputPressure:data];    // Setting value
    }
    else if (self.chosenTextField == 4)         // Input Flow
    {
        [self.calculator setInputFlow:data];        // Setting value
        NSLog(@"Input Flow = %2f", data);
    } */
    
    [self updateValues];        // Update Values shown to User
    
}

- (void) updateValues
{
    for (NSIndexPath *indexPath in [self.tableView indexPathsForVisibleRows])
    {
        NSArray *data = [self.calculator getData];
        if (indexPath.section == 1) {
            OutputCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            float value = [[data objectAtIndex:indexPath.row] floatValue];
            if (!(value == 0))     // If number is non zero
            {
                cell.outputTextLabel.text = [NSString stringWithFormat:@"%.2f",value];
            } else
            {
                CylinderProperty *temp = [self.cylinder.cylinderPropertiesOuput objectAtIndex:indexPath.row];
                cell.outputTextLabel.text = temp.propertyUnitsMet;
            }
        }
    }
}




@end
