//
//  ProductCollectionViewCell.h
//  JamminButter
//
//  Created by Will Chilcutt on 12/10/12.
//  Copyright (c) 2012 Will Chilcutt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSTCollectionView.h"

@interface ProductCollectionViewCell : PSUICollectionViewCell

@property (nonatomic, retain) IBOutlet UILabel *productNameLabel, *productPriceLabel;
@property (nonatomic, retain) IBOutlet UIImageView *productImageView;

@end
