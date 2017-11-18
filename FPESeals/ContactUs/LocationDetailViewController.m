//
//  LocationDetailViewController.m
//  FPESeals
//
//  Created by Christopher Bone on 14/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import "LocationDetailViewController.h"

@interface LocationDetailViewController ()

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

@end

@implementation LocationDetailViewController

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
