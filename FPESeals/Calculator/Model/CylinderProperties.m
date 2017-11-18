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
        
        CylinderProperty *BlankFiller = [[CylinderProperty alloc] init];
        BlankFiller.propertyTitle = @"";
        BlankFiller.propertyImageName = @"";
        BlankFiller.propertyDescription = @"";
        
        CylinderProperty *BoreDiameter = [[CylinderProperty alloc] init];
        BoreDiameter.propertyTitle = @"Bore Diameter";
        BoreDiameter.propertyImageName = @"";
        BoreDiameter.propertyDescription = @"This Is Bore Diameter";
        
        CylinderProperty *RodDiameter = [[CylinderProperty alloc] init];
        RodDiameter.propertyTitle = @"Rod Diameter";
        RodDiameter.propertyImageName = @"";
        RodDiameter.propertyDescription = @"This is Rod Diameter";
        
        CylinderProperty *StrokeLength = [[CylinderProperty alloc] init];
        StrokeLength.propertyTitle = @"Stroke Length";
        StrokeLength.propertyImageName = @"";
        StrokeLength.propertyDescription = @"This is Stroke Length";
        
        CylinderProperty *InputPressure = [[CylinderProperty alloc] init];
        InputPressure.propertyTitle = @"Input Pressure";
        InputPressure.propertyImageName = @"";
        InputPressure.propertyDescription = @"This is Input Pressure";
        
        CylinderProperty *InputFlow = [[CylinderProperty alloc] init];
        InputFlow.propertyTitle = @"Input Flow";
        InputFlow.propertyImageName = @"";
        InputFlow.propertyDescription = @"This is Input Flow";
        
        CylinderProperty *BoreArea = [[CylinderProperty alloc] init];
        BoreArea.propertyTitle = @"Bore Side Area";
        BoreArea.propertyImageName = @"";
        BoreArea.propertyDescription = @"This is Bore Side Area";
        
        CylinderProperty *RodArea = [[CylinderProperty alloc] init];
        RodArea.propertyTitle = @"Rod Side Area";
        RodArea.propertyImageName = @"";
        RodArea.propertyDescription = @"This is Rod Side Area";
        
        CylinderProperty *BoreVolume = [[CylinderProperty alloc] init];
        BoreVolume.propertyTitle = @"Bore Side Volume";
        BoreVolume.propertyImageName = @"";
        BoreVolume.propertyDescription = @"This is Bore Side Volume";
        
        CylinderProperty *RodVolume = [[CylinderProperty alloc] init];
        RodVolume.propertyTitle = @"Rod Side Volume";
        RodVolume.propertyImageName = @"";
        RodVolume.propertyDescription = @"This is Rod Side Volume";
        
        CylinderProperty *ForwardForce = [[CylinderProperty alloc] init];
        ForwardForce.propertyTitle = @"Forward Force";
        ForwardForce.propertyImageName = @"";
        ForwardForce.propertyDescription = @"This is Forward Stroke Force";
        
        CylinderProperty *ReverseForce = [[CylinderProperty alloc] init];
        ReverseForce.propertyTitle = @"Reverse Force";
        ReverseForce.propertyImageName = @"";
        ReverseForce.propertyDescription = @"This is Reverse Stroke Force";
        
#pragma mark Constructing Cylinder Property Array
        
        self.cylinderProperties = [[NSMutableArray alloc] init];        // Generating Array
        
        [self.cylinderProperties addObject:BoreDiameter];       // Index 0
        [self.cylinderProperties addObject:RodDiameter];        // Index 1
        [self.cylinderProperties addObject:StrokeLength];       // Index 2
        [self.cylinderProperties addObject:InputPressure];      // Index 3
        [self.cylinderProperties addObject:InputFlow];          // Index 4
        [self.cylinderProperties addObject:BlankFiller];        // Index 5 -
        [self.cylinderProperties addObject:BoreArea];           // Index 6
        [self.cylinderProperties addObject:RodArea];            // Index 7
        [self.cylinderProperties addObject:BoreVolume];         // Index 8
        [self.cylinderProperties addObject:RodVolume];          // Index 9
        [self.cylinderProperties addObject:ForwardForce];       // Index 10
        [self.cylinderProperties addObject:ReverseForce];       // Index 11
        [self.cylinderProperties addObject:BlankFiller];        // Index 12 -
        
        
    }
    return self;
}

@end
