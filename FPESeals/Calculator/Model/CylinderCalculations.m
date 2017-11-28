//
//  CylinderCalculations.m
//  FPESeals
//
//  Created by Christopher Bone on 21/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//


// Advice obtained from: https://www.youtube.com/watch?v=ZqKbN_C4Yvg&list=PL9qPUrlLU4jSlonxFqhWKBu2c_sWY-mzg at 35 mins plus

#import "CylinderCalculations.h"

@interface CylinderCalculations ()

// Privately edit the values of the following properties (Create private setter)

@property (nonatomic) double conversionConstant;
@property (nonatomic) double nonStandard;   //.. Units
@property (nonatomic) double standard;      //.. Units

@property (nonatomic) double boreDiameter;      // Inputs   (SI Units)
@property (nonatomic) double rodDiameter;
@property (nonatomic) double strokeLength;
@property (nonatomic) double inputPressure;
@property (nonatomic) double inputFlow;

@property (nonatomic) double boreArea;          // Outputs (SI Units)
@property (nonatomic) double rodArea;
@property (nonatomic) double boreVolume;
@property (nonatomic) double rodVolume;
@property (nonatomic) double forwardForce;
@property (nonatomic) double reverseForce;
@property (nonatomic) double extensionVelocity;
@property (nonatomic) double contractionVelocity;


@property (strong, nonatomic) NSArray *OutputTextMetric;
@property (strong, nonatomic) NSArray *OutputTextImperial;

@end

@implementation CylinderCalculations

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.inputVariables = [[NSMutableArray alloc] initWithObjects:
                                @0.0,       // Bore Diameter
                                @0.0,       // Rod Diameter
                                @0.0,       // Stroke Length
                                @0.0,       // Pressure
                                @0.0,      // Oil Flow
                               nil];
        
        [self calculateValues];     // Sets everything to 0!
        

    }
    return self;
}

- (NSMutableArray *)getData
{
    NSMutableArray *arrayOfData = [[NSMutableArray alloc] init];
    return arrayOfData;
}

# pragma mark Calculating Data
- (void) calculateValues {
    
    [self calculateLengths];        // millimetres or inches to metres
    [self calculatePressures];      // bar or psi to pascal
    [self calculateFlow];           // litres or gallons to metres^3 per min
    
    [self calculateBoreArea];       // metres squared
    [self calculateRodArea];        // metres squared
    [self calculateBoreVolume];     // metres cubed
    [self calculateRodVolume];      // metres cubed
    [self calculateBoreForce];      // newtons
    [self calculateRodForce];       // newtons
    [self calculateExtensionVeloctiy];      // metres per second
    [self calculateContractionVelocity];    // metres per second
    
    [self createCalculationsArray];
    
}

#pragma mark Input Calculations

- (void) calculateLengths {
    
    
    if (self.units == false) {                      // Metric
        self.conversionConstant = pow(10.0, -3);    // millimetres to metres
    }
    else {                                                  // Imperial
        self.conversionConstant = 25.4 * (pow(10.0, -3));   // Inches to millimetres, millimetres to metres
    }
    
    self.nonStandard = [[self.inputVariables objectAtIndex:0] doubleValue];     // Bore Diameter
    self.boreDiameter = self.nonStandard * self.conversionConstant;
    
    self.nonStandard = [[self.inputVariables objectAtIndex:1] doubleValue];           // Rod Diameter
    self.rodDiameter = self.nonStandard * self.conversionConstant;
    
    self.nonStandard = [[self.inputVariables objectAtIndex:2] doubleValue];         // Stroke Length
    self.strokeLength = self.nonStandard * self.conversionConstant;
}

- (void) calculatePressures
{
    if (self.units == false) {                      // Metric
        self.conversionConstant = pow(10.0, 5);    // bar to pascal
    }
    else {                                          // Imperial
        self.conversionConstant = 6894.76;          // psi to pascal
    }
    
    self.nonStandard = [[self.inputVariables objectAtIndex:3] doubleValue];
    self.inputPressure = self.nonStandard * self.conversionConstant;
}

- (void) calculateFlow
{
    if (self.units == false) {                      // Metric
        self.conversionConstant = pow(10.0, -3);    // litres to metres cubed per min
    }
    else {                                                      // Imperial
        self.conversionConstant = 4.54609 * (pow(10.0, -3));    // gallons to litres to metres cubed per min
    }
    
    self.nonStandard = [[self.inputVariables objectAtIndex:4] doubleValue];
    self.inputFlow = self.nonStandard * self.conversionConstant;
}

#pragma mark Output Calculations

- (void) calculateBoreArea
{
    self.boreArea = [self areaFromDiameter:self.boreDiameter];      // Metres squared
}

- (void) calculateRodArea
{
    double rod = [self areaFromDiameter:self.rodDiameter];
    double bore = self.boreArea;
    if (bore > rod && rod != 0)   // Area can't be less than zero
    {
        self.rodArea = (bore - rod);        // Metres squared
    } else {
        self.rodArea = 0.0;
    }
}

// Calculating an area from a given diameter
- (double)areaFromDiameter:(double)diameter
{
    double radius = diameter / 2;
    return (powf(radius, 2)) * M_PI;
}

- (void) calculateBoreVolume
{
    self.boreVolume = self.boreArea * self.strokeLength;    // Metres cubed
}

- (void) calculateRodVolume
{
    self.rodVolume = self.rodArea * self.strokeLength;      // Metres cubed
}

- (void) calculateBoreForce
{
    self.forwardForce = self.inputPressure * self.boreArea;
}

- (void) calculateRodForce
{
    self.reverseForce = self.inputPressure * self.rodArea;
}

- (void) calculateExtensionVeloctiy
{
    double flowRate = (self.inputFlow / 60.0);      // metres cubed per second
    
    if (self.boreArea != 0) {
        self.extensionVelocity = (flowRate / self.boreArea);    // metres per second
    } else {
        self.extensionVelocity = 0;
    }
}

- (void) calculateContractionVelocity
{
    double flowRate = (self.inputFlow / 60.0);      // metres cubed per second
    
    if (self.rodArea != 0) {
        self.contractionVelocity = (flowRate / self.rodArea);    // metres per second
    } else {
        self.contractionVelocity = 0;
    }
}

#pragma mark Outputting Data
- (void) createCalculationsArray{
    
    double BSA = [self UnitsForArea:self.boreArea];
    double RSA = [self UnitsForArea:self.rodArea];
    double BSV = [self UnitsForVolume:self.boreVolume];
    double RSV = [self UnitsForVolume:self.rodVolume];
    double BSF = [self UnitsForForce:self.forwardForce];
    double RSF = [self UnitsForForce:self.reverseForce];
    double EV = [self UnitsForVelocity:self.extensionVelocity];
    double CV = [self UnitsForVelocity:self.contractionVelocity];
    
    self.CalculatedValues = [[NSArray alloc] initWithObjects:
                         [NSNumber numberWithDouble:BSA],
                         [NSNumber numberWithDouble:RSA],
                         [NSNumber numberWithDouble:BSV],
                         [NSNumber numberWithDouble:RSV],
                         [NSNumber numberWithDouble:BSF],
                         [NSNumber numberWithDouble:RSF],
                         [NSNumber numberWithDouble:EV],
                         [NSNumber numberWithDouble:CV],
                         nil];
}

- (double)UnitsForArea:(double)area
{
    if (self.units == false) {                      // Metric
        self.conversionConstant = pow(10.0, 4);    // metres sqare to centimetres sqaure
    }
    else {                                                      // Imperial
        self.conversionConstant = 1550.0;;    // metres sqaure to inches sqaure
    }
    
    return (area * self.conversionConstant);
}

- (double) UnitsForVolume:(double)volume
{
    if (self.units == false) {                      // Metric
        self.conversionConstant = pow(10.0, 3);    // metres cubed to litres
    }
    else {                                            // Imperial
        self.conversionConstant = 61023.75;            // metres cubed to cubic inch
    }
    
    return (volume * self.conversionConstant);
}

- (double) UnitsForForce:(double)force
{
    if (self.units == false) {                      // Metric
        self.conversionConstant = pow(10.0, -3);                // kilo newtons
    }
    else {                                            // Imperial
        self.conversionConstant = 0.224809;            // newtons to pounds (force)
    }
    
    return (force * self.conversionConstant);
}

- (double) UnitsForVelocity:(double)velocity
{
    if (self.units == false) {                      // Metric
        self.conversionConstant = 1;                // metres per second
    }
    else {                                            // Imperial
        self.conversionConstant = 39.3701;            // metres to inches per second
    }
    
    return (velocity * self.conversionConstant);
}


@end
