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
@property (weak, nonatomic) IBOutlet UIButton *telephoneButtonOutlet;

// EMail Outlet
@property (weak, nonatomic) IBOutlet UIButton *emailButtonOutlet;

// Done Button
- (IBAction)pressedDone:(id)sender;

// Call Number
- (IBAction)callNumber:(id)sender;

// Send Email
- (IBAction)sendEmail:(id)sender;

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
    [self.telephoneButtonOutlet setTitle:self.selectedOffice.telephone forState:UIControlStateNormal];     // Telephone
    [self.emailButtonOutlet setTitle:self.selectedOffice.email forState:UIControlStateNormal];              // Email
    
    
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


- (IBAction)callNumber:(id)sender
{
    // Advice From: https://stackoverflow.com/questions/665769/how-can-i-make-phone-call-in-objective-c
    NSString *numberToCall = [NSString stringWithFormat:@"tel:%@",self.selectedOffice.telephone];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:numberToCall]])
    {
        NSLog(@"Calling Number");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:numberToCall] options:@{} completionHandler:nil];
    } else {
        NSLog(@"No Phone App Present To Call Number");
        UIAlertController *phoneWarning = [UIAlertController alertControllerWithTitle:@"Error Dailing Number"
                                                                              message:@"Unable To Call Number Due Lack Of A Suitable Phone Application"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss"
                                                          style:UIAlertActionStyleCancel
                                                        handler:nil];
        [phoneWarning addAction: dismiss];
        [self presentViewController:phoneWarning animated:YES completion:nil];
    }
}


- (IBAction)sendEmail:(id)sender
{
    NSString *emailAddress = [NSString stringWithFormat:@"mailto:%@",self.selectedOffice.email];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:emailAddress]])
    {
        NSLog(@"Email Client Openning");
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:emailAddress] options:@{} completionHandler:nil];
    } else {
        NSLog(@"No Email Client Present To Generate Email");
        UIAlertController *emailWarning = [UIAlertController alertControllerWithTitle:@"Error Sending Email"
                                                                              message:@"Unable To Create Email Due To Lack Of A Suitable EMail Application"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *dismiss = [UIAlertAction actionWithTitle:@"Dismiss"
                                                          style:UIAlertActionStyleCancel
                                                        handler:nil];
        [emailWarning addAction: dismiss];
        [self presentViewController:emailWarning animated:YES completion:nil];
    }
    
}
@end
