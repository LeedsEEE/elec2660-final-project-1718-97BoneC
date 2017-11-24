//
//  CompanyOffices.m
//  FPESeals
//
//  Created by Christopher Bone on 24/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import "CompanyOffices.h"
#import <UIKit/UIKit.h>


@implementation CompanyOffices


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        Office *Darlington = [[Office alloc] init];
        Darlington.name = @"Main Office";
        Darlington.image = [UIImage imageNamed:@""];
        Darlington.longitude = -1.512830;
        Darlington.latitude = 54.522202;
        Darlington.address = @{
                               @"Line One"  : @"FPE Seals Ltd",
                               @"Line Two"  : @"Barrington Way",
                               @"City"      : @"Darlington",
                               @"County"    : @"Co Durham",
                               @"Postcode"  : @"DL1 4WF",
                               };
        Darlington.telephone = @"+441325 282732";
        Darlington.email = @"sales@fpeseals.co.uk";
        
        Office *Doncaster = [[Office alloc] init];
        Doncaster.name = @"Doncaster Office";
        Doncaster.image = [UIImage imageNamed:@""];
        Doncaster.longitude = -1.172724;
        Doncaster.latitude = 53.576210;
        Doncaster.address = @{
                              @"Line One"  : @"FPE Seals Ltd",
                              @"Line Two"  : @"Unit 18 Hutton Business Park",
                              @"City"      : @"Doncaster",
                              @"County"    : @"South Yorkshire",
                              @"Postcode"  : @"DN6 7BD",
                              };
        Doncaster.telephone = @"+441302 727252";
        Doncaster.email = @"doncaster@fpeseals.co.uk";
        
        Office *Kent = [[Office alloc] init];
        Kent.name = @"Kent Office";
        Kent.image = [UIImage imageNamed:@""];
        Kent.longitude = 0.518907;
        Kent.latitude = 51.390603;
        Kent.address = @{
                         @"Line One"  : @"FPE Seals Ltd",
                         @"Line Two"  : @"Unit 26 Medway City Estate",
                         @"City"      : @"Chatham",
                         @"County"    : @"Kent",
                         @"Postcode"  : @"ME2 4DP",
                         };
        Kent.telephone = @"+441634 724394";
        Kent.email = @"kent@fpeseals.co.uk";
        
        Office *Scotland = [[Office alloc] init];
        Kent.name = @"Scotland Office";
        Kent.image = [UIImage imageNamed:@""];
        Kent.longitude = -2.110449;
        Kent.latitude = 57.154136;
        Kent.address = @{
                         @"Line One"  : @"Swan Seals Ltd",
                         @"Line Two"  : @"5-19 Holland Street",
                         @"City"      : @"Aberdeen",
                         @"County"    : @"Scotland",
                         @"Postcode"  : @"AB25 3UJ",
                         };
        Kent.telephone = @"+441224 648999";
        Kent.email = @"sales@swanseals.co.uk";
        
        
        self.offices = [[NSMutableArray alloc] init];
        
        [self.offices addObject:Darlington];
        [self.offices addObject:Doncaster];
        [self.offices addObject:Kent];
        [self.offices addObject:Scotland];
        
    }
    return self;
}
@end
