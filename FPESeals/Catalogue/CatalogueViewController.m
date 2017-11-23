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

@interface CatalogueViewController ()

@property (strong, nonatomic) Catalogues *list;

@end

@implementation CatalogueViewController

static NSString * const reuseIdentifier = @"CatalogueCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.list = [[Catalogues alloc] init];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[CatalogueViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

// Only 1 section in the Collection View
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView { return 1; }

// Number of items is dependant on size of available catalogues
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.list.avaliableCatalogues.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CatalogueViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    Catalogue *tempCatalogue = [[Catalogue alloc] init];
    tempCatalogue = [self.list.avaliableCatalogues objectAtIndex:indexPath.row];
    
    cell.cellTitleLabel.text = tempCatalogue.Name;
    cell.cellImageOutlet.image = tempCatalogue.Image;
    
    return cell;
}


#pragma mark <UICollectionViewDelegate>


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Catalogue *tempCatalogue = [[Catalogue alloc] init];
    tempCatalogue = [self.list.avaliableCatalogues objectAtIndex:indexPath.row];
    
    NSString *urlToShow = tempCatalogue.URL;
    
    // Advice from: https://stackoverflow.com/questions/40057071/method-openurloptionscompletionhandler-compatibility-in-objective-c
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlToShow] options:@{} completionHandler:nil];
    
}


@end
