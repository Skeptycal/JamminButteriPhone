//
//  ProductListViewController.h
//  JamminButter
//
//  Created by Will Chilcutt on 12/10/12.
//  Copyright (c) 2012 Will Chilcutt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductListViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSMutableArray *productArray;
    int selectedRow;
}
@property (weak, nonatomic) IBOutlet UICollectionView *productCollectionView;

@end
