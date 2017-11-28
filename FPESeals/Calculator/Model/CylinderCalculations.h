//
//  CylinderCalculations.h
//  FPESeals
//
//  Created by Christopher Bone on 21/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CylinderCalculations : NSObject

@property (nonatomic, strong) NSMutableArray *inputVariables;


                    // Index 0 = Bore Diameter
                    // Index 1 = Rod Diameter
                    // Index 2 = Stroke Length
                    // Index 3 = Pressure
                    // Index 4 = Oil Flow

@property (strong, nonatomic) NSArray *CalculatedValues;

@property (nonatomic) BOOL units;       // False = Metric,  True = Imperial

- (void) calculateValues;

- (NSMutableArray *)getData;
@end
