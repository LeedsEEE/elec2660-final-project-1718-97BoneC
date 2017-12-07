//
//  TechnicalDetailViewController.h
//  FPESeals
//
//  Created by Christopher Bone on 15/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CylinderProperty.h"

@interface TechnicalDetailViewController : UIViewController

// For Navigation (Segue)
@property (strong, nonatomic) CylinderProperty *property;

@end
