//
//  WebViewController.m
//  FPESeals
//
//  Created by Christopher Bone on 06/12/2017.
//  Copyright © 2017 University Of Leeds. All rights reserved.
//

#import "WebViewController.h"


@interface WebViewController () <UIWebViewDelegate,WKUIDelegate>
@property (strong, nonatomic) IBOutlet WKWebView *PDFViewer;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self intialiseWebViewer];
    
    NSLog(@"%@", self.catalogueURLString);
    NSURL *catalogueURL = [NSURL URLWithString:self.catalogueURLString];
    NSURLRequest *requestURL = [[NSURLRequest alloc] initWithURL:catalogueURL];
    [self.PDFViewer loadRequest:requestURL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)intialiseWebViewer
{
    CGRect webViewFrame = self.view.bounds;
    self.PDFViewer = [[WKWebView alloc] initWithFrame:webViewFrame];
    self.PDFViewer.UIDelegate = self;
    [self.view addSubview:self.PDFViewer];
    // Advice from: https://stackoverflow.com/questions/30737254/wkwebview-added-as-subview-is-not-resized-on-rotation-in-swift
    [self.PDFViewer setAutoresizingMask:UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth];
    
}


@end
