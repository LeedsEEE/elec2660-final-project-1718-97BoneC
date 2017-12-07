//
//  TechnicalDetailViewController.m
//  FPESeals
//
//  Created by Christopher Bone on 15/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import "TechnicalDetailViewController.h"

@interface TechnicalDetailViewController ()

// Image Viewer
@property (weak, nonatomic) IBOutlet UIImageView *cylinderImageOutlet;

// Main Body Title
@property (weak, nonatomic) IBOutlet UINavigationItem *propertyHeaderOutlet;

// Body Description Label
@property (weak, nonatomic) IBOutlet UILabel *descriptionOutlet;
@end

@implementation TechnicalDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.cylinderImageOutlet.image = [UIImage imageNamed:self.property.propertyImageName];
    self.cylinderImageOutlet.layer.cornerRadius = 5;
    self.cylinderImageOutlet.layer.borderWidth = 2;
    self.cylinderImageOutlet.layer.borderColor = [[UIColor blackColor] CGColor];
    self.propertyHeaderOutlet.title = self.property.propertyTitle;
    self.descriptionOutlet.text = self.property.propertyDescription;
    
    if (self.view.bounds.size.width > self.view.bounds.size.height) {       // Landscape Orientation
        
        // Advice From: https://stackoverflow.com/questions/25887009/ios-uinavigationcontroller-hide-navigationbar
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [self.tabBarController.tabBar setHidden:YES];
    }
    
    //Temporary Image Placeholder
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Advice From: http://pinkstone.co.uk/how-to-handle-device-rotation-since-ios-8/
-(void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    // Hiding or showing Navigation and Tab Bar depending on orientation
    if (size.width > size.height)
    {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [self.tabBarController.tabBar setHidden:YES];
        self.cylinderImageOutlet.layer.borderColor = [[UIColor whiteColor] CGColor];
    }
    else
    {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self.tabBarController.tabBar setHidden:NO];
        self.cylinderImageOutlet.layer.borderColor = [[UIColor blackColor] CGColor];
    }
}

@end
