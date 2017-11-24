//
//  Office.h
//  FPESeals
//
//  Created by Christopher Bone on 24/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface Office : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) UIImage *image;
@property (nonatomic) float longitude;
@property (nonatomic) float latitude;
@property (strong, nonatomic) NSDictionary *address;
@property (strong, nonatomic) NSString *telephone;
@property (strong, nonatomic) NSString *email;

@end
