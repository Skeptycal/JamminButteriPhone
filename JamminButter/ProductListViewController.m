//
//  ProductListViewController.m
//  JamminButter
//
//  Created by Will Chilcutt on 12/10/12.
//  Copyright (c) 2012 Will Chilcutt. All rights reserved.
//

#import "ProductListViewController.h"
#import "ProductCollectionViewCell.h"
#import "ProductDetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "AFHTTPClient.h"
#import "ProductListFlowLayout.h"

@interface ProductListViewController ()

@end

@implementation ProductListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return productArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"productCell";
    
    ProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSDictionary *productDict = [[NSDictionary alloc]initWithDictionary:[productArray objectAtIndex:indexPath.row]];
    
    [cell.productNameLabel setText:[NSString stringWithFormat:@"%@",[productDict objectForKey:@"name"]]];
    
    
    
    [cell.productImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[productDict objectForKey:@"image"]]]];
    
    [cell.productPriceLabel setText:[NSString stringWithFormat:@"%@",[productDict objectForKey:@"price"]]];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    selectedRow = indexPath.row;

    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailSegue"])
    {
        ProductDetailViewController *DVC = [segue destinationViewController];
        
        [DVC setSelectedProductDictionary:[productArray objectAtIndex:selectedRow]];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ProductListFlowLayout *flowLayout = [[ProductListFlowLayout alloc]init];
    
    [flowLayout setItemSize:CGSizeMake(237, 159)];
    [flowLayout setMinimumLineSpacing:10];
    [flowLayout setMinimumInteritemSpacing:10];
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 41, 0, 10)];
    
    [self.productCollectionView setCollectionViewLayout:flowLayout];

    AFHTTPClient *client = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:JB_URL]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
    request = [client requestWithMethod:@"GET" path:@"/api/v1/hobo/products" parameters:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSData *data = operation.responseData;
        
        NSMutableDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        productArray = [[NSMutableArray alloc] initWithArray:[dataDict objectForKey:@"products"]];

        [self.productCollectionView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        NSLog(@"error = %@",[error description]);
    }];
    
    [operation start];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
