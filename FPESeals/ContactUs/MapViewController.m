//
//  MapViewController.m
//  FPESeals
//
//  Created by Christopher Bone on 14/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>                   // Map View
#import <CoreLocation/CoreLocation.h>       // Users' Location

#import "Office.h"                          // Office Properties
#import "CompanyOffices.h"                  // Office Data

#import "LocationDetailViewController.h"        // For Segue



@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) CLLocationManager *user;      // For Users Location
@property (weak, nonatomic) IBOutlet MKMapView *mapView;    // For modifying Map
@property (nonatomic) float zoomLevel;                      // Inital Zoom Level

@property (strong, nonatomic) CompanyOffices *company;      // To Annotate Map With Office Locations

@end

// Defining the static view of the UK
static const float Latitude = 54.5;
static const float Longitude = -2.5;
static const float Zoom = 7.5;

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // To allow the user's location to be displayed on the map
    self.user = [[CLLocationManager alloc] init];
    [self.user requestWhenInUseAuthorization];
    // Map --> Attributes Inspector --> Show user's Location = YES
    
    self.company = [[CompanyOffices alloc] init];       // Intialising
    [self showOfficeLocations];                         // Custom Method (see below)
    
    // A linear formulea to determine the scale depending on map hieght
    if (self.view.bounds.size.height > self.view.bounds.size.width){
        self.zoomLevel = ((736.0 - self.mapView.bounds.size.height)/80) + Zoom; }   // If Hieght > Width
    else {
        self.zoomLevel = ((736.0 - self.mapView.bounds.size.width)/80) + Zoom;  }   // If Width > Height
    
    [self setCentreOfMapForLatitude:Latitude andLongitude:Longitude andScale:self.zoomLevel];     // Setting static view
}

- (void)didReceiveMemoryWarning {   [super didReceiveMemoryWarning];    }



// Setting area shown on the Map View
- (void)setCentreOfMapForLatitude: (float)latitude andLongitude: (float)longitude andScale: (float)scale
{
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(latitude, longitude);    // Generate centre coords
    MKCoordinateSpan mkScale = MKCoordinateSpanMake(scale, scale);                      // Generate 'zoom' scale
    MKCoordinateRegion view = MKCoordinateRegionMake(center, mkScale);                  // Setting view values
    [self.mapView setRegion:view animated:YES];                                         // Setting mapView
}


// Looping through Data Model and generating office locations on map
- (void)showOfficeLocations
{
    for (Office *temp in self.company.offices) {        // Loop through every office in array
        
        MKPointAnnotation *location = [[MKPointAnnotation alloc] init];
        CLLocationCoordinate2D coords = CLLocationCoordinate2DMake(temp.latitude, temp.longitude);      // Set Coords
        [location setCoordinate:coords];    // Set annotation Coords
        [location setTitle:temp.name];      // Set name (title)
        
        [self.mapView addAnnotation:location];          // Add location to map
    }
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([sender isKindOfClass:[MKAnnotationView class]]) {      // Eliminating choosing User's Location
        if ([[segue identifier] isEqualToString:@"LocationSegue"]) {        // Correct Segue
            MKAnnotationView *location = sender;        // Setting sender at MKAnnotationView
            
            LocationDetailViewController *destVC = [segue destinationViewController];   // Next ViewController
            
            NSUInteger index = [self determineOfficeIndexForString:location.annotation.title]; // Getting index using custom method below
            Office *tempOffice = [self.company.offices objectAtIndex:index];        // Getting Office of index
            destVC.selectedOffice = tempOffice;                                     // Passing Office of index
        }
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


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    // Advice From: https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/LocationAwarenessPG/AnnotatingMaps/AnnotatingMaps.html
    
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;     // Ensuring User's Location view isn't changed (default)
    }
    else {
        
        MKMarkerAnnotationView *view = [[MKMarkerAnnotationView alloc]              // Initialising annotation view
                                  initWithAnnotation:annotation
                                  reuseIdentifier:@"OfficeLocationView"];
        view.markerTintColor = [UIColor darkGrayColor];

        
        return view;
    }
}
@end
