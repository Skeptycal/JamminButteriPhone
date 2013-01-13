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
#import <QuartzCore/QuartzCore.h>

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

- (NSInteger)collectionView:(PSUICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return productSearchResultsArray.count;
}

- (PSUICollectionViewCell *)collectionView:(PSUICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"productCell";
    
    ProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSDictionary *productDict = [[NSDictionary alloc]initWithDictionary:[productSearchResultsArray objectAtIndex:indexPath.row]];
    
    [cell.productNameLabel setText:[NSString stringWithFormat:@"%@",[productDict objectForKey:@"name"]]];
    
    [cell.productImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[productDict objectForKey:@"image"]]]];
    
    [cell.productPriceLabel setText:[NSString stringWithFormat:@"%@",[productDict objectForKey:@"price"]]];
    
    [cell.layer setBorderColor:[UIColor colorWithRed:213.0/255.0f green:210.0/255.0f blue:199.0/255.0f alpha:1.0f].CGColor];
    [cell.layer setBorderWidth:1.0f];
    [cell.productPriceLabel.layer setBorderColor:[UIColor colorWithRed:213.0/255.0f green:210.0/255.0f blue:199.0/255.0f alpha:1.0f].CGColor];
    [cell.productPriceLabel.layer setBorderWidth:1.0f];
    
    return cell;
}


- (void)collectionView:(PSUICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
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

- (IBAction)showSearch:(id)sender
{
    //if user wants to show the search bar
    if (self.productSearchBar.frame.origin.y < 0) {
        [self.productSearchBar becomeFirstResponder];
        [UIView animateWithDuration:.5 animations:^{
            [self.productCollectionView setFrame:CGRectMake(self.productCollectionView.frame.origin.x, 44, self.productCollectionView.frame.size.width, self.productCollectionView.frame.size.height - self.productSearchBar.frame.size.height)];
            //self.productCollectionView.contentSize = CGSizeMake(self.productCollectionView.contentSize.width, self.productCollectionView.contentSize.height + self.productSearchBar.frame.size.height);
            [self.productSearchBar setFrame:CGRectMake(self.productSearchBar.frame.origin.x, 0, self.productSearchBar.frame.size.width, self.productSearchBar.frame.size.height)];
            NSLog(@"frame = %@, contentsize = %@",NSStringFromCGRect(self.productCollectionView.frame),NSStringFromCGSize(self.productCollectionView.contentSize));
        }];
    }
    //else user wants to hide the search bar
    else
    {
        [self.productSearchBar resignFirstResponder];
        [UIView animateWithDuration:.5 animations:^{
            [self.productCollectionView setFrame:CGRectMake(self.productCollectionView.frame.origin.x, 0, self.productCollectionView.frame.size.width, self.productCollectionView.frame.size.height + self.productSearchBar.frame.size.height)];
           // self.productCollectionView.contentSize = CGSizeMake(self.productCollectionView.contentSize.width, self.productCollectionView.contentSize.height - self.productSearchBar.frame.size.height);
            [self.productSearchBar setFrame:CGRectMake(self.productSearchBar.frame.origin.x, -44, self.productSearchBar.frame.size.width, self.productSearchBar.frame.size.height)];
            NSLog(@"frame = %@, contentsize = %@",NSStringFromCGRect(self.productCollectionView.frame),NSStringFromCGSize(self.productCollectionView.contentSize));

        }];
    }
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    //if searchbar cleared
    //if searchbar cleared
    if([searchBar.text isEqualToString:@""])
    {
        [productSearchResultsArray removeAllObjects];
        [productSearchResultsArray addObjectsFromArray:productArray];
    }
    else
    {
        [productSearchResultsArray removeAllObjects];
        NSMutableArray *foundResultsArray = [[NSMutableArray alloc] init];
        
        for(NSDictionary *product in productArray)
        {
            NSString *productName = [product objectForKey:@"name"];
            if (productName) {
                if([productName rangeOfString:searchBar.text options:NSCaseInsensitiveSearch].location == NSNotFound)
                {
                }
                else
                {
                    [foundResultsArray addObject:product];
                }
            }
        }
        
        [productSearchResultsArray addObjectsFromArray:foundResultsArray];
    }
    [self.productCollectionView reloadData];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)bar {
    
    return YES;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    //if searchbar cleared
    if([searchBar.text isEqualToString:@""])
    {
        [productSearchResultsArray removeAllObjects];
        [productSearchResultsArray addObjectsFromArray:productArray];
    }
    else
    {
        [productSearchResultsArray removeAllObjects];
        NSMutableArray *foundResultsArray = [[NSMutableArray alloc] init];
        
        for(NSDictionary *product in productArray)
        {
            NSString *productName = [product objectForKey:@"name"];
            if (productName) {
                if([productName rangeOfString:searchBar.text options:NSCaseInsensitiveSearch].location == NSNotFound)
                {
                }
                else
                {
                    [foundResultsArray addObject:product];
                }
            }
        }
        
        [productSearchResultsArray addObjectsFromArray:foundResultsArray];
    }
    
    [self.productCollectionView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor scrollViewTexturedBackgroundColor]];
    
    [DejalBezelActivityView activityViewForView:self.view withLabel:@"Loading products.."];
    
    ProductListFlowLayout *flowLayout = [[ProductListFlowLayout alloc]init];

    [flowLayout setItemSize:CGSizeMake(237, 159)];
    [flowLayout setMinimumLineSpacing:10];
    [flowLayout setMinimumInteritemSpacing:10];
    [flowLayout setSectionInset:UIEdgeInsetsMake(10, 41, 0, 10)];
    
    [self.productCollectionView setCollectionViewLayout:flowLayout];

    AFHTTPClient *client = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:JB_URL]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    
    request = [client requestWithMethod:@"GET" path:@"/api/v1/hobo" parameters:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        NSData *data = operation.responseData;
        
        NSMutableDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        productArray = [[NSMutableArray alloc] initWithArray:[dataDict objectForKey:@"products"]];
        productSearchResultsArray = [[NSMutableArray alloc]initWithArray:[dataDict objectForKey:@"products"]];
        [self.productCollectionView reloadData];
        
        [DejalBezelActivityView removeViewAnimated:YES];
        
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
