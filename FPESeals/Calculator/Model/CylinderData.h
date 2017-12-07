//
//  CylinderData.h
//  FPESeals
//
//  Created by Christopher Bone on 17/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CylinderProperty.h"

@interface CylinderData : NSObject

@property (strong, nonatomic) NSMutableArray *cylinderPropertiesInput;  // Input Properties
@property (strong, nonatomic) NSMutableArray *cylinderPropertiesOuput;  // Output Properties

@property (strong, nonatomic) CylinderProperty *Blank;  

@end
