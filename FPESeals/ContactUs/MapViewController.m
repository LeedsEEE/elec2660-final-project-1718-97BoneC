//
//  MapViewController.m
//  FPESeals
//
//  Created by Christopher Bone on 14/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

// For Users Location
@property (strong, nonatomic) CLLocationManager *user;

// For modifying Map
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

// Defining the static view of the UK
static const float Latitude = 54.778051;
static const float Longitude = -2.935973;
static const float Zoom = 8.5;

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // To allow the user's location to be displayed on the map
    self.user = [[CLLocationManager alloc] init];
    [self.user requestWhenInUseAuthorization];
    // Map --> Attributes Inspector --> Show user's Location = YES
    
    [self setCentreOfMapForLatitude:Latitude andLongitude:Longitude andScale:Zoom];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"LocationSegue"]) {
    
#warning Not Finished
    }
}

- (void)setCentreOfMapForLatitude: (float)latitude andLongitude: (float)longitude andScale: (float)scale
{
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(latitude, longitude);
    MKCoordinateSpan mkScale = MKCoordinateSpanMake(scale, scale);
    MKCoordinateRegion view = MKCoordinateRegionMake(center, mkScale);
    [self.mapView setRegion:view animated:YES];

}

@end
