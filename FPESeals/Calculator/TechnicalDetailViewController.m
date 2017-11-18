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
@property (weak, nonatomic) IBOutlet UILabel *propertyTitleOutlet;

// Body Description Label
@property (weak, nonatomic) IBOutlet UILabel *descriptionOutlet;
@end

@implementation TechnicalDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
