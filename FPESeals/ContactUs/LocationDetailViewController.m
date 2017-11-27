//
//  LocationDetailViewController.m
//  FPESeals
//
//  Created by Christopher Bone on 14/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import "LocationDetailViewController.h"

@interface LocationDetailViewController ()

// Title Name
@property (weak, nonatomic) IBOutlet UINavigationItem *titleBarOutlet;

// Image
@property (weak, nonatomic) IBOutlet UIImageView *officeImageOutlet;

// Address Labels
@property (weak, nonatomic) IBOutlet UILabel *addressLineOneOutlet;
@property (weak, nonatomic) IBOutlet UILabel *addressLineTwoOutlet;
@property (weak, nonatomic) IBOutlet UILabel *addressCityOutlet;
@property (weak, nonatomic) IBOutlet UILabel *addressCountyOutlet;
@property (weak, nonatomic) IBOutlet UILabel *addressPCOutlet;

// Telephone Label
@property (weak, nonatomic) IBOutlet UILabel *telephoneOutlet;

// EMail Outlet
@property (weak, nonatomic) IBOutlet UILabel *emailOutlet;

// Done Button
- (IBAction)pressedDone:(id)sender;

@end

@implementation LocationDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleBarOutlet.title = self.selectedOffice.name;           // Title
    self.officeImageOutlet.image = self.selectedOffice.image;       // Image
    self.addressLineOneOutlet.text = [self.selectedOffice.address objectForKey:@"Line One"];    // Address
    self.addressLineTwoOutlet.text = [self.selectedOffice.address objectForKey:@"Line Two"];
    self.addressCityOutlet.text = [self.selectedOffice.address objectForKey:@"City"];
    self.addressCountyOutlet.text = [self.selectedOffice.address objectForKey:@"County"];
    self.addressPCOutlet.text = [self.selectedOffice.address objectForKey:@"Postcode"];
    self.telephoneOutlet.text = self.selectedOffice.telephone;      // Telephone
    self.emailOutlet.text = self.selectedOffice.email;              // Email
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressedDone:(id)sender
{
    // To return back to the Map View
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
