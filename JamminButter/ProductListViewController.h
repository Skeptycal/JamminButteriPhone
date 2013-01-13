//
//  ProductListViewController.h
//  JamminButter
//
//  Created by Will Chilcutt on 12/10/12.
//  Copyright (c) 2012 Will Chilcutt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSTCollectionView.h"

@interface ProductListViewController : UIViewController <PSUICollectionViewDataSource, PSUICollectionViewDelegate, UISearchBarDelegate>
{
    NSMutableArray *productArray;
    NSMutableArray *productSearchResultsArray;
    int selectedRow;
}
@property (weak, nonatomic) IBOutlet PSUICollectionView *productCollectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *productSearchBar;

@end
