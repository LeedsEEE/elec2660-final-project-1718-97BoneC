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
    
    if ([sender isKindOfClass:[MKAnnotationView class]]) {
        if ([[segue identifier] isEqualToString:@"LocationSegue"]) {
            MKAnnotationView *location = sender;
            LocationDetailViewController *destVC = [segue destinationViewController];
            
            NSUInteger index = [self determineOfficeIndexForString:location.annotation.title];
            Office *tempOffice = [self.company.offices objectAtIndex:index];
            destVC.selectedOffice = tempOffice;
        }
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
    for (Office *temp in self.company.offices) {        // Loop through every office in array
        
        MKPointAnnotation *location = [[MKPointAnnotation alloc] init];
        CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(temp.latitude, temp.longitude);      // Set Coords
        [location setCoordinate:coords];    // Set annotation Coords
        [location setTitle:temp.name];      // Set name (title)
        
        
        
        NSLog(@"Location Placed = %@", temp.name);      // Debug
        [self.mapView addAnnotation:location];          // Add location
    }
}

- (NSUInteger)determineOfficeIndexForString:(NSString *)name
{
    NSUInteger index = 0;       // Initialising
    for (Office *temp in self.company.offices) {        // Looping through array of offices
        if ([name isEqualToString:temp.name]) {         // Checking to see which office name was inputted
            index = [self.company.offices indexOfObject:temp];      // If names match return index of office
            break;      // Break for loop
        }
    }
    return index;       // Return the index of the named office
}

#pragma mark MKMapView Delegates

// Annotation Selected
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    if (!(view.annotation == mapView.userLocation)){        // Make sure annotation is not the user
    // Advice from: https://stackoverflow.com/questions/5947188/how-to-find-out-pin-id-in-map-annotation-view
    [mapView deselectAnnotation:view.annotation animated:YES];          // To deselect annotation
    [self performSegueWithIdentifier:@"LocationSegue" sender:view];     // Perform segue
    }
}

//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{ }
@end
