//
//  ProductDetailViewController.h
//  JamminButter
//
//  Created by Will Chilcutt on 12/10/12.
//  Copyright (c) 2012 Will Chilcutt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailViewController : UIViewController

@property (nonatomic, retain) NSDictionary *selectedProductDictionary;
@property (weak, nonatomic) IBOutlet UITextView *productDescriptionTextView;
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *productPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;

@end
