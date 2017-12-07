//
//  Catalogue.h
//  FPESeals
//
//  Created by Christopher Bone on 23/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>     // So class can have a UIImage property

@interface Catalogue : NSObject

@property (strong, nonatomic) NSString *Name;   // For Label and Sharing
@property (strong, nonatomic) NSString *URL;    // URL to get Catalogue Data
@property (strong, nonatomic) UIImage *Image;   // Image for Collection View

@end
