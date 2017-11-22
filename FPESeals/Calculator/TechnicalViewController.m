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
@property (strong, nonatomic) NSMutableArray *LayoutArray;      // Array for Layout
@property (strong, nonatomic) CylinderProperties *cylinder;     // Object of Cylinder Properties (to get array to display)
@property (nonatomic) NSUInteger chosenTextField;               // Integer to store index of current chosen Text Field
@property (strong, nonatomic) CylinderCalculations *calculator; // Calculator Object


// Private Functions
- (NSMutableArray *)determineLayoutArray:(CylinderProperties *) inputarray;     // Determing the layout

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
    self.LayoutArray = [self determineLayoutArray:self.cylinder];
    self.calculator = [[CylinderCalculations alloc] init];

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
    
    [layout addObject:inputarray.Blank];        // Adding in blank spacers
    
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

// Cell For Row
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
        cell.inputTextField.tag = indexPath.row;                        //For use later to determine textfields row index
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
    // Help obtained from: https://stackoverflow.com/questions/5732438/how-to-get-uitableviewcells-index-from-its-edited-uitextfield
    self.chosenTextField = textField.tag;
    return YES;
}

// Hitting "Done" (Return) Key on keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];

    return YES;
    
}

// When tap gesture is recognised
- (IBAction)backgroundPressed:(id)sender
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chosenTextField inSection:0];
    InputCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if ( [cell.inputTextField isFirstResponder]) {
        [cell.inputTextField resignFirstResponder];
    }
}

// Getting "Live" entered data
- (IBAction)textFieldEdited:(UITextField *)sender
{
    // Help obtained from: https://stackoverflow.com/questions/8483967/how-to-check-text-field-input-at-real-time
    float data = [sender.text doubleValue];
    NSLog(@"%2f", data);
    
    if (self.chosenTextField == 0)      // Bore Diameter
    {
        NSLog(@"Bore Diameter = %2f", data);
        [self.calculator setBoreDiameter:data];
        
    }
    else if ( self.chosenTextField == 1)        // Rod Diameter
    {
        NSLog(@"Rod Diameter = %2f", data);
        [self.calculator setRodDiameter:data];
    }
    else if (self.chosenTextField == 2 )        // Stroke Length
    {
        NSLog(@"Stroke Length = %2f", data);
        [self.calculator setStrokeLength:data];
    }
    else if (self.chosenTextField == 3)         // Input Pressure
    {
        NSLog(@"Input Pressure = %2f", data);
        [self.calculator setInputPressure:data];
    }
    else if (self.chosenTextField == 4)         // Input Flow
    {
        NSLog(@"Input Flow = %2f", data);
    }
    
    [self updateValues];
    
}

- (void) updateValues
{
    NSArray *data = [self.calculator getData];
    int i = 6;
    for (NSNumber *value in data) {
        float number = [value floatValue];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        OutputCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        CylinderProperty *temp = [[CylinderProperty alloc] init];
        if (!(number == 0))
        {
            cell.outputTextLabel.text = [NSString stringWithFormat:@"%.2f",number];
            NSLog(@"Value = %@", value);
        } else 
        {
            temp = [self.LayoutArray objectAtIndex:indexPath.row];
            cell.outputTextLabel.text = temp.propertyUnitsMet;
        }
        i++;
    }
}




@end
