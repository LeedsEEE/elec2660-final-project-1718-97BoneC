//
//  Catalogues.m
//  FPESeals
//
//  Created by Christopher Bone on 23/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import "Catalogues.h"
#import "Catalogue.h"


@implementation Catalogues

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        // Generating available catalogues
        Catalogue *CFPR = [[Catalogue alloc] init];
        CFPR.Name = @"Composite & Flexiseal Product Range";
        CFPR.URL = @"http://www.fpeseals.co.uk/brochures/RD_FPE_Composite%20&%20Flexiseal%20Product%20Range%20-%20Issue%203.pdf";
        CFPR.Image = [UIImage imageNamed:@"CFPR.png"];
        
        Catalogue *IKC = [[Catalogue alloc] init];
        IKC.Name = @"Industrial Kit Catalogue";
        IKC.URL = @"http://www.fpeseals.co.uk/brochures/RD_FPE_Industrial%20Kit%20Catalogue%20-%20Issue%204.pdf";
        IKC.Image = [UIImage imageNamed:@"IKC.png"];
        
        Catalogue *MSPR = [[Catalogue alloc] init];
        MSPR.Name = @"Master Seal Product Range";
        MSPR.URL = @"http://www.fpeseals.co.uk/brochures/RD_FPE_Master%20Seal%20Product%20Range%20-%20Issue%203.pdf";
        MSPR.Image = [UIImage imageNamed:@"MSPR.png"];
        
        Catalogue *CP = [[Catalogue alloc] init];
        CP.Name = @"Cylinder Parts Catalogue";
        CP.URL = @"http://www.fpeseals.co.uk/brochures/FPE_Cylinder%20Parts%20-%20Issue%202.pdf";
        CP.Image = [UIImage imageNamed:@"CP.png"];
        
        Catalogue *MKC = [[Catalogue alloc] init];
        MKC.Name = @"Mobile Kit     Catalogue";
        MKC.URL = @"http://www.fpeseals.co.uk/brochures/RD_FPE_Mobile%20Kit%20Catalogue.pdf";
        MKC.Image = [UIImage imageNamed:@"MKC.png"];
        
        Catalogue *BDGC = [[Catalogue alloc] init];
        BDGC.Name = @"Bulldog Gasket Catalogue";
        BDGC.URL = @"http://www.fpeseals.co.uk/brochures/2013BulldogGasketeCatalog.pdf";
        BDGC.Image = [UIImage imageNamed:@"GreySquare.png"];
        
        Catalogue *BDHC = [[Catalogue alloc] init];
        BDHC.Name = @"Bulldog Hydraulic Catalogue";
        BDHC.URL = @"http://www.fpeseals.co.uk/brochures/2011BulldogHydraulicCatalog.pdf";
        BDHC.Image = [UIImage imageNamed:@"GreySquare.png"];
        
        // Initialise array
        self.avaliableCatalogues = [[NSMutableArray alloc] init];
        
        // Add Catalogues to the array
        [self.avaliableCatalogues addObject:CFPR];      // Index 0
        [self.avaliableCatalogues addObject:MSPR];
        [self.avaliableCatalogues addObject:IKC];
        [self.avaliableCatalogues addObject:CP];
        [self.avaliableCatalogues addObject:MKC];
        [self.avaliableCatalogues addObject:BDGC];
        [self.avaliableCatalogues addObject:BDHC];      // Index 6
        
    }
    return self;
}

@end
