//
//  CylinderProperties.m
//  FPESeals
//
//  Created by Christopher Bone on 17/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import "CylinderProperties.h"


@implementation CylinderProperties

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        // Generating Cylinder Property Objects
        
        // Blank (Spacer Filler) Property
        self.Blank = [[CylinderProperty alloc] init];
        self.Blank.propertyTitle = @"Blank";
        self.Blank.isInput = NO;
        self.Blank.propertyImageName = @"";
        self.Blank.propertyDescription = @"";
        self.Blank.propertyUnitsMet = @"";
        self.Blank.propertyUnitsImp = @"";
        
        // Actual Properties
        CylinderProperty *BoreDiameter = [[CylinderProperty alloc] init];
        BoreDiameter.propertyTitle = @"Bore Diameter";
        BoreDiameter.isInput = YES;
        BoreDiameter.propertyImageName = @"";
        BoreDiameter.propertyDescription = @"Bore Diameter is the cross-sectional length of the cylinder. It is measured by taking the distance between two points on the internal circumference, or similarly two points on the external circumference of the piston.";
        BoreDiameter.propertyUnitsMet = @"   millimetres";
        BoreDiameter.propertyUnitsImp = @"";
        
        CylinderProperty *RodDiameter = [[CylinderProperty alloc] init];
        RodDiameter.propertyTitle = @"Rod Diameter";
        RodDiameter.isInput = YES;
        RodDiameter.propertyImageName = @"";
        RodDiameter.propertyDescription = @"Rod Diameter is the cross-sectional length of the hydraulic rod. This value is measured by taking the distance between two points along the rod's external circumference. Note: This is not the value measured from the thread!";
        RodDiameter.propertyUnitsMet = @"   millimetres";
        RodDiameter.propertyUnitsImp = @"";
        
        CylinderProperty *StrokeLength = [[CylinderProperty alloc] init];
        StrokeLength.propertyTitle = @"Stroke Length";
        StrokeLength.isInput = YES;
        StrokeLength.propertyImageName = @"Stroke Length.png";
        StrokeLength.propertyDescription = @"Stroke Length is typical characterised as the difference between open and closed centres of a hydrualic ram and therefore measured as such.";
        StrokeLength.propertyUnitsMet = @"   millimetres";
        StrokeLength.propertyUnitsImp = @"";
        
        CylinderProperty *InputPressure = [[CylinderProperty alloc] init];
        InputPressure.propertyTitle = @"Pressure";
        InputPressure.isInput = YES;
        InputPressure.propertyImageName = @"Pressure.png";
        InputPressure.propertyDescription = @"This variable refers to the input pressure of the oil into cylinder, as supplied by an external source. Usually at a typical working value, this property can really only be measured via the use of an external pressure gauge, which is then connected into source of oil.";
        InputPressure.propertyUnitsMet = @"bar";
        InputPressure.propertyUnitsImp = @"";
        
        CylinderProperty *InputFlow = [[CylinderProperty alloc] init];
        InputFlow.propertyTitle = @"Oil Flow";
        InputFlow.isInput = YES;
        InputFlow.propertyImageName = @"Oil Flow.png";
        InputFlow.propertyDescription = @"Oil Flow is defined as the rate of oil passing a given point, under a certain time. Similar to pressure, this value will be set by an external source and impacts the rate at which the cylinder will move as well as what sealing components are required.";
        InputFlow.propertyUnitsMet = @"   litres per min";
        InputFlow.propertyUnitsImp = @"";
        
        
        CylinderProperty *BoreArea = [[CylinderProperty alloc] init];
        BoreArea.propertyTitle = @"Bore Side Area";
        BoreArea.isInput = NO;
        BoreArea.propertyImageName = @"Bore Side Area.png";
        BoreArea.propertyDescription = @"Bore Side Area, or Full Bore Area as its sometimes refered to. Is the the working area given by a certain bore diameter, upon which the pressure of the system will act against.";
        BoreArea.propertyUnitsMet = @"millimetres squared";
        BoreArea.propertyUnitsImp = @"";
        
        CylinderProperty *RodArea = [[CylinderProperty alloc] init];
        RodArea.propertyTitle = @"Rod Side Area";
        RodArea.isInput = NO;
        RodArea.propertyImageName = @"Rod Side Area.png";
        RodArea.propertyDescription = @"Rod Side Area, or Annular Area as its sometimes refered to. Is the area upon which the pressure of the system acts on to contract the ram. Its value is calulted by removing the area of the rod from that of the bore to give a value representing the ring as shown.";
        RodArea.propertyUnitsMet = @"millimetres squared";
        RodArea.propertyUnitsImp = @"";
        
        CylinderProperty *BoreVolume = [[CylinderProperty alloc] init];
        BoreVolume.propertyTitle = @"Bore Side Volume";
        BoreVolume.isInput = NO;
        BoreVolume.propertyImageName = @"Bore Side Volume.png";
        BoreVolume.propertyDescription = @"Bore Side Volume is defined as the stroke length times a given bore area and so represents the maximum volume of liquid a cylinder will hold when fully extended. Similary, therefore, it also represents the amount of oil needed to fully extend a hydraulic ram.";
        BoreVolume.propertyUnitsMet = @"litres";
        BoreVolume.propertyUnitsImp = @"";
        
        CylinderProperty *RodVolume = [[CylinderProperty alloc] init];
        RodVolume.propertyTitle = @"Rod Side Volume";
        RodVolume.isInput = NO;
        RodVolume.propertyImageName = @"Rod Side Volume.png";
        RodVolume.propertyDescription = @"Rod Side Volume is defined as the stroke length times a given rod area and so represent the maximum volume of a liquid a cylinder will hold when fully contracted. Similary, therefore, its also represents the amount of oil needed to fully contract a hydraulic ram.";
        RodVolume.propertyUnitsMet = @"litres";
        RodVolume.propertyUnitsImp = @"";
        
        CylinderProperty *ForwardForce = [[CylinderProperty alloc] init];
        ForwardForce.propertyTitle = @"Bore Side Force";
        ForwardForce.isInput = NO;
        ForwardForce.propertyImageName = @"Bore Side Force.png";
        ForwardForce.propertyDescription = @"Bore Side Force, or Extension Force as it may be known. Is the maximum force a hydraulic ram will provide when undergoing extension. As defined by the bore side area and working pressure.";
        ForwardForce.propertyUnitsMet = @"Newtons";
        ForwardForce.propertyUnitsImp = @"";
        
        CylinderProperty *ReverseForce = [[CylinderProperty alloc] init];
        ReverseForce.propertyTitle = @"Rod Side Force";
        ReverseForce.isInput = NO;
        ReverseForce.propertyImageName = @"Rod Side Force.png";
        ReverseForce.propertyDescription = @"Rod Side Force, or Annular Force as it may be known. Is the maximum force a hydrualic ram will provide when undergoing contraction. As defined by the the rod side area and working pressure.";
        ReverseForce.propertyUnitsMet = @"Newtons";
        ReverseForce.propertyUnitsImp = @"";
        
#pragma mark Constructing Cylinder Property Arrays
        
        self.cylinderPropertiesInput = [[NSMutableArray alloc] init];        // Generating Array
        
        [self.cylinderPropertiesInput addObject:BoreDiameter];       // Index 0
        [self.cylinderPropertiesInput addObject:RodDiameter];        // Index 1
        [self.cylinderPropertiesInput addObject:StrokeLength];       // Index 2
        [self.cylinderPropertiesInput addObject:InputPressure];      // Index 3
        [self.cylinderPropertiesInput addObject:InputFlow];          // Index 4

        
        
        self.cylinderPropertiesOuput = [[NSMutableArray alloc] init];       // Generating Array
        
        [self.cylinderPropertiesOuput addObject:BoreArea];           // Index 0
        [self.cylinderPropertiesOuput addObject:RodArea];            // Index 1
        [self.cylinderPropertiesOuput addObject:BoreVolume];         // Index 2
        [self.cylinderPropertiesOuput addObject:RodVolume];          // Index 3
        [self.cylinderPropertiesOuput addObject:ForwardForce];       // Index 4
        [self.cylinderPropertiesOuput addObject:ReverseForce];       // Index 5

        
        
    }
    return self;
}

@end
