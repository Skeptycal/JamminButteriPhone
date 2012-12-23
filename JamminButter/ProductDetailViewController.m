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

    [self.productNameLabel setText:[NSString stringWithFormat:@"%@",[self.selectedProductDictionary objectForKey:@"name"]]];
    
    [self.productPriceLabel setText:[NSString stringWithFormat:@"%@",[self.selectedProductDictionary objectForKey:@"price"]]];
    
    [self.productImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[self.selectedProductDictionary objectForKey:@"image"]]]];
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
