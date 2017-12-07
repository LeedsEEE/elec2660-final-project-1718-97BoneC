//
//  CatalogueViewController.m
//  FPESeals
//
//  Created by Christopher Bone on 16/11/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import "CatalogueViewController.h"
#import "CatalogueViewCell.h"   // Custom Collection View Cell
#import "Catalogues.h"          // The data model of Catalogues
#import "Catalogue.h"           // The Catalogue Model
#import "WebViewController.h"   // Next ViewController For Segue

@interface CatalogueViewController ()

@property (strong, nonatomic) Catalogues *list;     // Data Model

@end

@implementation CatalogueViewController

static NSString * const reuseIdentifier = @"CatalogueCell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.list = [[Catalogues alloc] init];

}

- (void)didReceiveMemoryWarning {       [super didReceiveMemoryWarning];        }


#pragma mark - Navigation

// Preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Ensuring correct segue
    if ([[segue identifier] isEqualToString:@"viewPDF"]) {
        
        // Getting index of selecteded cell
        CatalogueViewCell *selectedCell = sender;
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:selectedCell];
        
        // Getting desired (selected) Catalogue
        Catalogue *selectedCatalogue = [self.list.avaliableCatalogues objectAtIndex:indexPath.row];
        
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
    return self.list.avaliableCatalogues.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Custom cell type (see class file)
    CatalogueViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Corresponding catalogue
    Catalogue *tempCatalogue = [self.list.avaliableCatalogues objectAtIndex:indexPath.row];
    
    // Setting cell data
    cell.cellTitleLabel.text = tempCatalogue.Name;
    cell.cellImageOutlet.image = tempCatalogue.Image;
    
    // Fine turning the visual layout
    cell.cellImageOutlet.layer.cornerRadius = 5;
    cell.cellImageOutlet.layer.borderWidth = 2;
    cell.cellImageOutlet.layer.borderColor = [[UIColor blackColor] CGColor];
    
    return cell;
}


#pragma mark UICollectionView Delegate Methods

/*
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // Temporary Catalogue Instance
    Catalogue *tempCatalogue = [[Catalogue alloc] init];
    
    // Getting associated Catalogue
    tempCatalogue = [self.list.avaliableCatalogues objectAtIndex:indexPath.row];
    
    // Getting URL of associated catalogue URL
    NSString *urlToShow = tempCatalogue.URL;
    
    // Advice from: https://stackoverflow.com/questions/40057071/method-openurloptionscompletionhandler-compatibility-in-objective-c
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlToShow] options:@{} completionHandler:nil];
    
} */


@end
