//
//  ProductDetailViewController.m
//  JamminButter
//
//  Created by Will Chilcutt on 12/10/12.
//  Copyright (c) 2012 Will Chilcutt. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProductDetailViewController ()

@end

@implementation ProductDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Loading.."];
    
    [self.view setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];

    [self.productNameLabel setText:[NSString stringWithFormat:@"%@",[self.selectedProductDictionary objectForKey:@"name"]]];
    
    [self.productPriceLabel setText:[NSString stringWithFormat:@"%@",[self.selectedProductDictionary objectForKey:@"price"]]];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.selectedProductDictionary objectForKey:@"image"]]]];
    
    [self.productImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
    {
        [DejalBezelActivityView removeViewAnimated:YES];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];
    
    [self.productDescriptionTextView setText:[NSString stringWithFormat:@"%@",[self.selectedProductDictionary objectForKey:@"description"]]];
    
}

- (IBAction)addToCart:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.selectedProductDictionary objectForKey:@"add_to_cart"]]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
