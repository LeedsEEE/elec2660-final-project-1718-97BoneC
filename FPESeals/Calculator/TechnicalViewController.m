//
//  TechnicalViewController.m
//  FPESeals
//
//  Created by Christopher Bone on 15/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import "TechnicalViewController.h"

#import "CylinderProperty.h"                    // Data Class
#import "CylinderData.h"                  // Data Model
#import "CylinderCalculations.h"                // Computing Class

#import "InputCell.h"       // Custom Input Cell (For Text Box)
#import "OutputCell.h"      // Custom Output Cell (For Text Label)

#import "TechnicalDetailViewController.h"       // For Navigation (Segue)


@interface TechnicalViewController ()

// Private Properties
@property (strong, nonatomic) CylinderData *cylinderData;     // Object of Cylinder Properties (to get array to display)
@property (strong, nonatomic) CylinderCalculations *calculator;     // Calculator Object
@property (nonatomic) NSUInteger chosenTextField;                   // Integer to store index of current chosen Text Field

// Private Actions
- (IBAction)textFieldEdited:(UITextField *) sender;     // UITextField Action
- (IBAction)backgroundPressed:(id)sender;               // Tap Gesture
- (IBAction)UnitsPressed:(UIBarButtonItem *)sender;     // "Units" Tab Bar button

@end


// Methods
@implementation TechnicalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.allowsSelection = NO;    // Disables Selecting rows (Only want to select detail icons)
    
    // Intialising Objects and Arrays
    self.cylinderData = [[CylinderData alloc] init];
    self.calculator = [[CylinderCalculations alloc] init];
    

}

- (void)didReceiveMemoryWarning {   [super didReceiveMemoryWarning];    }




#pragma mark - Table View Data Source

// Number Of Sections in Table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { return 2; }    // Only 2 section in Table View

// Number Of Rows in Section
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Inputs Section
    if (section == 0) {
        return self.cylinderData.cylinderPropertiesInput.count;  }   // Rows in Section 1 = Number of Input Variables
    
    // Output Section
    else if (section == 1) {
        return self.cylinderData.cylinderPropertiesOuput.count;  }   // Rows in Section 2 = Number of Output Variables
    
    else {  return 1;   }
}

// Cell For Row
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CylinderProperty *temp = [[CylinderProperty alloc] init];
    
    if (indexPath.section == 0 )    // Inputs
    {
        InputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InputCells" forIndexPath:indexPath];   // Storyboard Cell Reference
        
        temp = [self.cylinderData.cylinderPropertiesInput objectAtIndex:indexPath.row];     // Associated Cylinder Property
        
        if (!self.calculator.units) {   cell.inputTextField.placeholder = temp.propertyUnitsMet; }      // If Metric Units
        
        else {  cell.inputTextField.placeholder = temp.propertyUnitsImp; }     // If Imperial Units
        
        cell.textLabel.text = temp.propertyTitle;       // Setting Title
        cell.inputTextField.tag = indexPath.row;        //For use later to determine textfields row index
        return cell;
    }
    
    else if (indexPath.section == 1 )   // Outputs
    {
        OutputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OutputCells" forIndexPath:indexPath];  // Storyboard Cell Reference
        
        temp = [self.cylinderData.cylinderPropertiesOuput objectAtIndex:indexPath.row];     // Associated Cylinder Property
        float value = [[self.calculator.CalculatedValues objectAtIndex:indexPath.row] floatValue];
        
        if (value > 0 ) {       // If value in calculator to display
            cell.outputTextLabel.text = [NSString stringWithFormat:@"%.2f", value];
        }
        else if (!self.calculator.units) {   cell.outputTextLabel.text = temp.propertyUnitsMet;  }   // If Metric Units
        
        else { cell.outputTextLabel.text = temp.propertyUnitsImp; }     // If Imperial Units
        
        cell.textLabel.text = temp.propertyTitle;       // Setting Title
        return cell;
    }
    
    else {      // Spacer Style Cell (No Label)
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SpacerCell" forIndexPath:indexPath];  // Storyboard Cell Reference
        return cell;
    }
}


// Headers For Sections
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return @"Please Input Data...";     // Input Data Section
    }
    else if (section == 1)
    {
        return @"Calculated Outputs...";    // Output Data Section
    }
    else
    {
        return nil;
    }
}



#pragma mark - Navigation

// Preperation Before Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Ensuring correct segue
    if ([[segue identifier] isEqualToString:@"PropertyDetail"]) {       // Segue Identifier = "PropertyDetail"
        
        TechnicalDetailViewController *destinationVC = [segue destinationViewController];       // Destination View Controller
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];          // Index Path of the cells accessory button which was pressed
        
        CylinderProperty *tempProperty;
        if (indexPath.section == 0 )    // Inputs
        {
            tempProperty = [ self.cylinderData.cylinderPropertiesInput objectAtIndex:indexPath.row];       // Getting assocaited cylinder property
        }
        else if (indexPath.section == 1 )   // Outputs
        {
            tempProperty = [ self.cylinderData.cylinderPropertiesOuput objectAtIndex:indexPath.row];       // Getting assocaited cylinder property
        }
        
        destinationVC.property = tempProperty;      // Passing the selected cylinder property
    }
}



#pragma mark UITextField Delegates and Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    // Gets the row index of the current (about to be editted) text field to use in resigning keyboard
    // Help obtained from: https://stackoverflow.com/questions/5732438/how-to-get-uitableviewcells-index-from-its-edited-uitextfield
    self.chosenTextField = textField.tag;
    return YES;
}

// Hitting "Done" (Return) Key on keyboard
// Not needed when number pad is used
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];       // Dismissing Keyboard

    return YES;
}

// When resigning keyboard
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self checkInputtedData];       // See Below
    return YES;                     // Allows User to finish editing text field and move to another object on view
}

// Making Sure Correct Data Is Entered
- (void)checkInputtedData
{
    NSNumber *limit = [NSNumber numberWithInt:10000000];
    for (NSNumber *value in self.calculator.inputVariables) {
        
        if (value > limit) {
            UIAlertController *dataWarning = [UIAlertController alertControllerWithTitle:@"Warning!"
                                                                                 message:@"Your Entered Value Is Too Large To Process: Please Adjust Entered Value [MAX: 10000000]"
                                                                             preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss"
                                                              style:UIAlertActionStyleCancel
                                                            handler:nil];
            [dataWarning addAction: dismiss];                                            // Adding Alert Dismiss Button
            [self presentViewController:dataWarning animated:YES completion:nil];        // Presenting Alert to User
        }
        
    }
    
    
    NSNumber *first = [self.calculator.inputVariables objectAtIndex:0];     // Entered Value for Bore Diameter
    NSNumber *second = [self.calculator.inputVariables objectAtIndex:1];    // Entered Value For Rod Diameter
    
    if ((second > first) && !(first == 0) && !(second == 0)) {   // Rod Diameter can't be smaller than the bore (can't have negative area, check CylinderCalculations Class)
        UIAlertController *rodDataWarning = [UIAlertController alertControllerWithTitle:@"Warning!"
                                                                             message:@"Rod Diameter is Greater Than Bore Diameter: Please Check Values and Change As Necessary"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss"
                                                          style:UIAlertActionStyleCancel
                                                        handler:nil];
        [rodDataWarning addAction: dismiss];                                            // Adding Alert Dismiss Button
        [self presentViewController:rodDataWarning animated:YES completion:nil];        // Presenting Alert to User
        
    }
}

// When tap gesture is recognised
- (IBAction)backgroundPressed:(id)sender
{
    // self.chosenTextField is a NSUInteger NOT a UITextField
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chosenTextField inSection:0];    // User only inputs in first section (TextFields)
    
    InputCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];     // Getting cell for textfields location
    
    if ( [cell.inputTextField isFirstResponder]) {                          // Making sure textfield is first responder
        [cell.inputTextField resignFirstResponder];                         // Resigning keyboard if so
    }
}

// Getting "Live" entered data
- (IBAction)textFieldEdited:(UITextField *)sender       // Value Changed
{
    self.chosenTextField = sender.tag;          // Updating viewcontroller about chosen textfield

    float data = [sender.text doubleValue];             // Converting string to double
    NSNumber *value = [NSNumber numberWithFloat:data];      // Creating NSNumber Object to enter value into array
    
    [self.calculator.inputVariables replaceObjectAtIndex:self.chosenTextField withObject:value];    // Update Data Model (Cylinder Calculations)
    
    [self.calculator calculateValues];      // Cylinder Calculations Method

    [self updateValues];        // Update Values shown to User (see below)
    
}


// Updates Values of Labels
- (void) updateValues
{
    for (NSIndexPath *indexPath in [self.tableView indexPathsForVisibleRows])       // Grabs Index Path of currently visible rows
    {
        if (indexPath.section == 1)     // Output Section
        {
            CylinderProperty *temp = [self.cylinderData.cylinderPropertiesOuput objectAtIndex:indexPath.row];   // Associated Cylinder Property
            
            OutputCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];        // Associated Cell to update
            
            float value = [[self.calculator.CalculatedValues objectAtIndex:indexPath.row] floatValue];  // Getting Assocaited Value for cell
            
            if (!(value == 0))     // If number is non zero
            {   cell.outputTextLabel.text = [NSString stringWithFormat:@"%.2f",value];  }   // Display Value
            
            else if (self.calculator.units == true)
            {   cell.outputTextLabel.text = temp.propertyUnitsImp;  }       // If Imperial Units
            else
            {   cell.outputTextLabel.text = temp.propertyUnitsMet;  }       // If Metric Units
        }
    }
}


#pragma mark Changing Units

// Pressing 'Units' Navigation Button
- (IBAction)UnitsPressed:(UIBarButtonItem *)sender {
    
    if (self.calculator.units)  {           // If Imperial Set Metric
        self.calculator.units = false;
        sender.title = @"Metric";
    } else  {                               // If Metric Set Imperial
        self.calculator.units = true;
        sender.title = @"Imperial";
    }
    
    // Moves TableView view to the top row
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    // Clearing Inputted Data
    for (NSIndexPath *indexPath in [self.tableView indexPathsForVisibleRows])       // Index Paths for visible rows
    {
        // Advice from: https://stackoverflow.com/questions/6560888/how-to-delete-the-contents-of-a-uitextfield-programmatically
        if (indexPath.section == 0) {
            // Setting String in textfield to nil / " "
            InputCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.inputTextField.text = nil;
            // Updating Model
            [self.calculator.inputVariables replaceObjectAtIndex:indexPath.row withObject:@0.0];
        }
    }
    [self.calculator calculateValues];      // Cylinder Calculations Method
    
    // Force tableview to reload (and regenerate cells)
    [self.tableView reloadData];
}
@end
