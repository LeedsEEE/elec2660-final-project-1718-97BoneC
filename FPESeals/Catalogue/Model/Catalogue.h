//
//  Catalogue.h
//  FPESeals
//
//  Created by Christopher Bone on 23/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Catalogue : NSObject

@property (strong, nonatomic) NSString *Name;
@property (strong, nonatomic) NSString *URL;
@property (strong, nonatomic) UIImage *Image;

@end
