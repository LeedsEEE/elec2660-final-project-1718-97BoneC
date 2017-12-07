//
//  WebViewController.h
//  FPESeals
//
//  Created by Christopher Bone on 06/12/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebViewController : UIViewController

// For Navigation (Segue)
@property (strong, nonatomic) NSString *catalogueName;
@property (strong, nonatomic) NSString *catalogueURLString;

@end
