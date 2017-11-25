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

#import "Office.h"
#import "CompanyOffices.h"
#import "LocationDetailViewController.h"

@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *user;      // For Users Location
@property (weak, nonatomic) IBOutlet MKMapView *mapView;    // For modifying Map

@property (strong, nonatomic) CompanyOffices *company;      // To Annotate Map With Office Locations

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
    
    [self setCentreOfMapForLatitude:Latitude andLongitude:Longitude andScale:Zoom];     // Setting static view
    
    self.company = [[CompanyOffices alloc] init];
    [self showOfficeLocations];
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
    
        LocationDetailViewController *destVC = [segue destinationViewController];
        
        Office *tempOffice = [self.company.offices objectAtIndex:0];
        destVC.selectedOffice = tempOffice;
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

- (void)showOfficeLocations
{
    for (Office *temp in self.company.offices) {
        
        MKPointAnnotation *location = [[MKPointAnnotation alloc] init];
        CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(temp.latitude, temp.longitude);
        [location setCoordinate:coords];
        [location setTitle:temp.name];
        
        
        NSLog(@"Location Placed = %@", temp.name);
        [self.mapView addAnnotation:location];
    }
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{ }

#pragma mark MKMapView Delegates

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    [self performSegueWithIdentifier:@"LocationSegue" sender:view];
}
@end
