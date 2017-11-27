//
//  CylinderCalculations.h
//  FPESeals
//
//  Created by Christopher Bone on 21/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CylinderCalculations : NSObject

@property (nonatomic) float boreDiameter;
@property (nonatomic) float rodDiameter;
@property (nonatomic) float strokeLength;
@property (nonatomic) float inputPressure;
@property (nonatomic) float inputFlow;

@property (strong, nonatomic) NSArray *dataOut;
- (NSArray *)getData;
@end
