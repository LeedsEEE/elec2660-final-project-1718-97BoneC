//
//  CylinderProperty.h
//  FPESeals
//
//  Created by Christopher Bone on 17/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CylinderProperty : NSObject

@property (strong, nonatomic) NSString *propertyTitle;

@property (nonatomic) BOOL isInput;

@property (strong, nonatomic) NSString *propertyImageName;

@property (strong, nonatomic) NSString *propertyDescription;

@property (strong, nonatomic) NSString *propertyUnitsMet;

@property (strong, nonatomic) NSString *propertyUnitsImp;

@end
