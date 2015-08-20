//
//  LocalsController.m
//  LokaleWyborcze
//
//  Created by Bitcats on 19/08/15.
//  Copyright (c) 2015 TWalenciak. All rights reserved.
//

#import "LocalsController.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

#import "MapLocalController.h"

#import "LocalsProvider.h"
#import "LocalCell.h"
#import "Local.h"

@interface LocalsController ()

@property (nonatomic) Local *selectedLocal;

@end

@implementation LocalsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _localsProvider = [[LocalsProvider alloc]init];
    _localsProvider.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_localsProvider reloadData];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator
{
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    [self.collectionView.collectionViewLayout invalidateLayout];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSArray *indexPaths = [self.collectionView indexPathsForSelectedItems];
    if ([indexPaths count] > 0) {
        NSIndexPath *selected = indexPaths[0];
        Local *localToPresent = self.localsProvider.dataArray[selected.row];
        MapLocalController *destController = (MapLocalController *)segue.destinationViewController;
        destController.presentedLocal = localToPresent;
    }
}

- (void)localsProviderDidReceivedData:(LocalsProvider *)provider
{
    [self.collectionView reloadData];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LocalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LocalsCell" forIndexPath:indexPath];
    
    // needed for proper autolayout (without console errors)
    // http://stackoverflow.com/questions/27197813/autolayout-is-complaining-about-leading-trailing-space-for-uiimageview
    cell.contentView.frame = cell.bounds;
    
    Local *local = [self.localsProvider.dataArray objectAtIndex:indexPath.row];
    
    cell.name.text = local.address;
    
    NSString *imageUrl = [local imgLink];
    
    NSURL *imgURL = [NSURL URLWithString:imageUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:imgURL];
    
    cell.uid = local.uid;
    cell.imageView.image = nil;
    
    __weak LocalCell *weakCell = cell;
    
    
    [cell.imageView setImageWithURLRequest:request
                          placeholderImage:nil
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                       if (weakCell.uid == cell.uid) {
                                           weakCell.imageView.image = image;
                                       }
                                       
                                   } failure:nil];
    
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.localsProvider.dataArray count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellWidth = collectionView.frame.size.width / 2.f;
    return CGSizeMake(cellWidth, 70);
}

@end
