//
//  CatalogueViewController.m
//  FPESeals
//
//  Created by Christopher Bone on 16/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import "CatalogueViewController.h"
#import "CatalogueViewCell.h"           // Custom Collection View Cell
#import "CatalogueData.h"               // The data model of Catalogues
#import "Catalogue.h"                   // The Catalogue Model
#import "WebViewController.h"           // Next ViewController For Segue


// Private Properties
@interface CatalogueViewController ()

@property (strong, nonatomic) CatalogueData *data;     // Data Model

@end


// Methods
@implementation CatalogueViewController

static NSString * const reuseIdentifier = @"CatalogueCell"; // To Identify Cell on Storyboard

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.data = [[CatalogueData alloc] init];  // Intialise Catalogue Data
    //
}

- (void)didReceiveMemoryWarning {       [super didReceiveMemoryWarning];        }


#pragma mark - Navigation

// Preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Ensuring correct segue
    if ([[segue identifier] isEqualToString:@"viewPDF"]) {
        
        // Getting index of selecteded cell
        CatalogueViewCell *selectedCell = sender;   // Only cells will produce 'viewPDF' segue
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:selectedCell];
        
        // Getting desired (selected) Catalogue
        Catalogue *selectedCatalogue = [self.data.avaliableCatalogues objectAtIndex:indexPath.row];
        
        // Next View Controller (PDF Reader)
        WebViewController *DestVC = [segue  destinationViewController];
        DestVC.catalogueURLString = selectedCatalogue.URL;
        DestVC.catalogueName = selectedCatalogue.Name;
    }
}



#pragma mark UICollectionView DataSource Methods

// Only 1 section in the Collection View
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView { return 1; }


// Number of items is dependant on size of available catalogues
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.data.avaliableCatalogues.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Custom cell type (see class file)
    CatalogueViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Corresponding catalogue
    Catalogue *tempCatalogue = [self.data.avaliableCatalogues objectAtIndex:indexPath.row];
    
    // Setting cell data
    cell.cellTitleLabel.text = tempCatalogue.Name;
    cell.cellImageOutlet.image = tempCatalogue.Image;
    
    // Fine turning the visual layout
    cell.cellImageOutlet.layer.cornerRadius = 5;
    cell.cellImageOutlet.layer.borderWidth = 2;
    cell.cellImageOutlet.layer.borderColor = [[UIColor blackColor] CGColor];
    
    return cell;
}

@end
