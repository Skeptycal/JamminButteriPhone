//
//  ProductListFlowLayout.m
//  JamminButter
//
//  Created by Will Chilcutt on 12/23/12.
//  Copyright (c) 2012 Will Chilcutt. All rights reserved.
//

#import "ProductListFlowLayout.h"

@implementation ProductListFlowLayout

-(id)init
{
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
