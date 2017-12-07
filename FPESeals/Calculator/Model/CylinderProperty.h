//
//  CylinderProperty.h
//  FPESeals
//
//  Created by Christopher Bone on 17/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CylinderProperty : NSObject

@property (strong, nonatomic) NSString *propertyTitle;              // Title
@property (strong, nonatomic) NSString *propertyImageName;          // Image
@property (strong, nonatomic) NSString *propertyDescription;        // Description
@property (strong, nonatomic) NSString *propertyUnitsMet;           // Metric Units
@property (strong, nonatomic) NSString *propertyUnitsImp;           // Imperial Units

@end
