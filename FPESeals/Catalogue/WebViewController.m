//
//  WebViewController.m
//  FPESeals
//
//  Created by Christopher Bone on 06/12/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import "WebViewController.h"

// Advice From: https://iostpoint.wordpress.com/2016/08/05/implement-wkwebview-in-ios/

@interface WebViewController () <WKUIDelegate, WKNavigationDelegate>
@property (strong, nonatomic) IBOutlet WKWebView *PDFViewer;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;


@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self intialiseWebViewer];      // WKWebView
    
    [self createURLRequest];        // NSURL Request
    
    [self loadingProgress];         // Activity Indicator
}

- (void)didReceiveMemoryWarning {   [super didReceiveMemoryWarning];    }

- (void)intialiseWebViewer
{
    // Generating WKWebView
    // Initialising with size of view (device)
    self.PDFViewer = [[WKWebView alloc] initWithFrame:self.view.bounds];
    
    // Setting Delegates
    self.PDFViewer.UIDelegate = self;
    self.PDFViewer.navigationDelegate = self;
    
    // Adding View
    [self.view addSubview:self.PDFViewer];
    
    // Advice from: https://stackoverflow.com/questions/30737254/wkwebview-added-as-subview-is-not-resized-on-rotation-in-swift
    [self.PDFViewer setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
}


- (void)createURLRequest
{
    // Getting Catalogue from website (URL)
    NSURL *catalogueURL = [NSURL URLWithString:self.catalogueURLString];
    NSURLRequest *requestURL = [[NSURLRequest alloc] initWithURL:catalogueURL];
    [self.PDFViewer loadRequest:requestURL];
}

- (void)loadingProgress
{
    // Creates and Starts Activity Indicator
    self.loadingIndicator.hidesWhenStopped = YES;
    [self.loadingIndicator startAnimating];
    [self.view addSubview:self.loadingIndicator];
    
}

- (IBAction)shareCatalogue:(id)sender
{
    // Advice from: https://www.grapecity.com/en/blogs/adding-a-share-button-to-an-objective-c-ios-app
    // Preparing data to share
    NSString *catalogue = self.catalogueName;
    NSURL *catalogueURL = [NSURL URLWithString:self.catalogueURLString];
    
    // Array of data to share
    NSArray *activityItems = @[catalogue, catalogueURL];
    
    // Creating Activity View Controller
    UIActivityViewController *shareViewController = [[UIActivityViewController alloc]
                                                     initWithActivityItems:activityItems
                                                     applicationActivities:nil];
    // Any Excluded Activities?
    shareViewController.excludedActivityTypes = @[];
    
    [self presentViewController:shareViewController animated:YES completion:nil];
}

#pragma mark WKWebView Navigation Delegates

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    // Stop Animating Activity Indicator
    [self.loadingIndicator stopAnimating];
}


@end
