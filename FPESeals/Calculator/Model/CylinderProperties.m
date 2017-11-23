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
        BoreDiameter.propertyDescription = @"This Is Bore Diameter";
        BoreDiameter.propertyUnitsMet = @"   millimetres";
        BoreDiameter.propertyUnitsImp = @"";
        
        CylinderProperty *RodDiameter = [[CylinderProperty alloc] init];
        RodDiameter.propertyTitle = @"Rod Diameter";
        RodDiameter.isInput = YES;
        RodDiameter.propertyImageName = @"";
        RodDiameter.propertyDescription = @"This is Rod Diameter";
        RodDiameter.propertyUnitsMet = @"   millimetres";
        RodDiameter.propertyUnitsImp = @"";
        
        CylinderProperty *StrokeLength = [[CylinderProperty alloc] init];
        StrokeLength.propertyTitle = @"Stroke Length";
        StrokeLength.isInput = YES;
        StrokeLength.propertyImageName = @"";
        StrokeLength.propertyDescription = @"This is Stroke Length";
        StrokeLength.propertyUnitsMet = @"   millimetres";
        StrokeLength.propertyUnitsImp = @"";
        
        CylinderProperty *InputPressure = [[CylinderProperty alloc] init];
        InputPressure.propertyTitle = @"Input Pressure";
        InputPressure.isInput = YES;
        InputPressure.propertyImageName = @"";
        InputPressure.propertyDescription = @"This is Input Pressure";
        InputPressure.propertyUnitsMet = @"bar";
        InputPressure.propertyUnitsImp = @"";
        
        CylinderProperty *InputFlow = [[CylinderProperty alloc] init];
        InputFlow.propertyTitle = @"Input Flow";
        InputFlow.isInput = YES;
        InputFlow.propertyImageName = @"";
        InputFlow.propertyDescription = @"This is Input Flow";
        InputFlow.propertyUnitsMet = @"   litres per min";
        InputFlow.propertyUnitsImp = @"";
        
        
        CylinderProperty *BoreArea = [[CylinderProperty alloc] init];
        BoreArea.propertyTitle = @"Bore Side Area";
        BoreArea.isInput = NO;
        BoreArea.propertyImageName = @"";
        BoreArea.propertyDescription = @"This is Bore Side Area";
        BoreArea.propertyUnitsMet = @"millimetres squared";
        BoreArea.propertyUnitsImp = @"";
        
        CylinderProperty *RodArea = [[CylinderProperty alloc] init];
        RodArea.propertyTitle = @"Rod Side Area";
        RodArea.isInput = NO;
        RodArea.propertyImageName = @"";
        RodArea.propertyDescription = @"This is Rod Side Area";
        RodArea.propertyUnitsMet = @"millimetres squared";
        RodArea.propertyUnitsImp = @"";
        
        CylinderProperty *BoreVolume = [[CylinderProperty alloc] init];
        BoreVolume.propertyTitle = @"Bore Side Volume";
        BoreVolume.isInput = NO;
        BoreVolume.propertyImageName = @"";
        BoreVolume.propertyDescription = @"This is Bore Side Volume";
        BoreVolume.propertyUnitsMet = @"litres";
        BoreVolume.propertyUnitsImp = @"";
        
        CylinderProperty *RodVolume = [[CylinderProperty alloc] init];
        RodVolume.propertyTitle = @"Rod Side Volume";
        RodVolume.isInput = NO;
        RodVolume.propertyImageName = @"";
        RodVolume.propertyDescription = @"This is Rod Side Volume";
        RodVolume.propertyUnitsMet = @"litres";
        RodVolume.propertyUnitsImp = @"";
        
        CylinderProperty *ForwardForce = [[CylinderProperty alloc] init];
        ForwardForce.propertyTitle = @"Forward Force";
        ForwardForce.isInput = NO;
        ForwardForce.propertyImageName = @"";
        ForwardForce.propertyDescription = @"This is Forward Stroke Force";
        ForwardForce.propertyUnitsMet = @"Newtons";
        ForwardForce.propertyUnitsImp = @"";
        
        CylinderProperty *ReverseForce = [[CylinderProperty alloc] init];
        ReverseForce.propertyTitle = @"Reverse Force";
        ReverseForce.isInput = NO;
        ReverseForce.propertyImageName = @"";
        ReverseForce.propertyDescription = @"This is Reverse Stroke Force";
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
