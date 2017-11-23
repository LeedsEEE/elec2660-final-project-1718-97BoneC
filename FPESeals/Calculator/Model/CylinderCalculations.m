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
@property (nonatomic) float boreArea;
@property (nonatomic) float rodArea;
@property (nonatomic) float boreVolume;
@property (nonatomic) float rodVolume;
@property (nonatomic) float forwardForce;
@property (nonatomic) float reverseForce;

@end

@implementation CylinderCalculations

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.boreDiameter = 0;  // Setting diameter and therefore area, volume and force to 0
        self.rodDiameter = 0;   // Setting diamater and therefore area, volume and force to 0
        self.strokeLength = 0;  // Setting stroke length and therefore volume to 0
        self.inputPressure = 0; // Setting input pressure and therefore force to 0
    }
    return self;
}


// General theme is that when a certain property is supplied data, a cascade of properties are calculated.

#pragma mark Inputting Data
// Inputting Diameter
- (void)setBoreDiameter:(float)boreDiameter
{
    _boreDiameter = boreDiameter;
    [self setBoreArea];
}

- (void)setRodDiameter:(float)rodDiameter
{
    _rodDiameter = rodDiameter;
    [self setRodArea];
}

- (void)setStrokeLength:(float)strokeLength
{
    _strokeLength = strokeLength;
    [self setBoreVolume];
    [self setRodVolume];
}

- (void)setInputPressure:(float)inputPressure
{
    _inputPressure = inputPressure;
    [self setForwardForce];
    [self setReverseForce];
}

- (void)setInputFlow:(float)inputFlow
{
#warning Not Finished
    _inputFlow = inputFlow;
}

#pragma mark Calculating Data
// Calculating Area
- (void)setBoreArea
{
    _boreArea = [self areaFromDiameter:self.boreDiameter];
    [self setBoreVolume];
    [self setForwardForce];
}

- (void)setRodArea
{
    _rodArea = [self areaFromDiameter:self.rodDiameter];
    [self setRodVolume];
    [self setReverseForce];
}
// Calculating an area from a given diameter
- (float)areaFromDiameter:(float)diameter
{
    float radius = diameter / 2;
    return (powf(radius, 2)) * M_PI;
}

// Calculating Volume
- (void)setBoreVolume
{
    _boreVolume = [self volumeForArea:self.boreArea andLength:self.strokeLength];
    // No other values needed from bore volume
}

- (void)setRodVolume
{
    _rodVolume = [self volumeForArea:self.rodArea andLength:self.strokeLength];
    // No other values  need from rod volume
}

// Calculating a volume for a given area and length
- (float)volumeForArea:(float)area andLength:(float)length
{
    return area * length;
}

// Calculating Force
- (void)setForwardForce
{
    _forwardForce = [self forceForArea:self.boreArea andPressure:self.inputPressure];
    // No other values needed from Forward Force
}

- (void)setReverseForce
{
    _reverseForce = [self forceForArea:self.rodArea andPressure:self.inputPressure];
    // No other values needed from Reverse Force
}

// Calculating a force from a given area and pressure
- (float)forceForArea:(float)area andPressure:(float)pressure
{
    return area * pressure;
}

- (NSArray *)getData
{
    NSArray *data = [[NSArray alloc] initWithObjects:
                            [NSNumber numberWithFloat:self.boreArea],
                            [NSNumber numberWithFloat:self.rodArea],
                            [NSNumber numberWithFloat:self.boreVolume],
                            [NSNumber numberWithFloat:self.rodVolume],
                            [NSNumber numberWithFloat:self.forwardForce],
                            [NSNumber numberWithFloat:self.reverseForce],
                            nil];
    return data;
}
@end
