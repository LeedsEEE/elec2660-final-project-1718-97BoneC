//
//  TechnicalDetailViewController.m
//  FPESeals
//
//  Created by Christopher Bone on 15/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import "TechnicalDetailViewController.h"

@interface TechnicalDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *cylinderImageOutlet;      // Image Viewer

@property (weak, nonatomic) IBOutlet UINavigationItem *propertyHeaderOutlet;    // Main Body Title

@property (weak, nonatomic) IBOutlet UILabel *descriptionOutlet;        // Body Description Label

- (IBAction)tapGesture:(id)sender;
@end

@implementation TechnicalDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Setting associated view cylinder properties
    self.cylinderImageOutlet.image = [UIImage imageNamed:self.property.propertyImageName];      // Image Viewer
    
    // Adjusting image properties
    self.cylinderImageOutlet.layer.cornerRadius = 5;
    self.cylinderImageOutlet.layer.borderWidth = 2;
    self.cylinderImageOutlet.layer.borderColor = [[UIColor blackColor] CGColor];
    
    self.propertyHeaderOutlet.title = self.property.propertyTitle;          // Main  Body Title
    
    self.descriptionOutlet.text = self.property.propertyDescription;        // Body Description Label
    
    // If device is in Landscape, intent is for image to dominate the screen
    if (self.view.bounds.size.width > self.view.bounds.size.height) {       // Landscape Orientation
        
        // Advice From: https://stackoverflow.com/questions/25887009/ios-uinavigationcontroller-hide-navigationbar
        [self.navigationController setNavigationBarHidden:YES animated:YES];        // Hide Navigation Bar
        [self.tabBarController.tabBar setHidden:YES];                               // Hide Tab Bar
        self.cylinderImageOutlet.layer.borderColor = [[UIColor whiteColor] CGColor];
    }
}


- (void)didReceiveMemoryWarning {   [super didReceiveMemoryWarning];    }


// Advice From: http://pinkstone.co.uk/how-to-handle-device-rotation-since-ios-8/
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    // Hiding or showing Navigation and Tab Bar depending on orientation
    if (size.width > size.height)
    {
        // If in landscape
        [self.navigationController setNavigationBarHidden:YES animated:YES];            // Hide Nav and Tab
        [self.tabBarController.tabBar setHidden:YES];
        self.cylinderImageOutlet.layer.borderColor = [[UIColor whiteColor] CGColor];    // Set Image Border to White
    }
    else
    {
        // If in Portrait
        [self.navigationController setNavigationBarHidden:NO animated:YES];             // Show Nav and Tab
        [self.tabBarController.tabBar setHidden:NO];
        self.cylinderImageOutlet.layer.borderColor = [[UIColor blackColor] CGColor];    // Set Image Border to Black
    }
}

// Tapping on view to reveal/hide Nav and Tab Bar when in Landscape (full image view)
- (IBAction)tapGesture:(id)sender {
    
    if (self.view.bounds.size.width > self.view.bounds.size.height) // When device is in landscape
    {
        if ([self.navigationController isNavigationBarHidden]) {    // If Hidden
            
            // Show Nav and Tab
            [self.navigationController setNavigationBarHidden:NO animated:YES];
            [self.tabBarController.tabBar setHidden:NO];    }
        else {                                                      // If Revealed
            // Hide Nav and Tab
            [self.navigationController setNavigationBarHidden:YES animated:YES];
            [self.tabBarController.tabBar setHidden:YES];
            
        }
    }
    
}
@end
