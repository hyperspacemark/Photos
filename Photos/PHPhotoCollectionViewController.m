//
//  PHPhotoCollectionViewController.m
//  Photos
//
//  Created by Mark Adams on 10/8/12.
//  Copyright (c) 2012 thoughtbot. All rights reserved.
//

#import "PHPhotoCollectionViewController.h"

@interface PHPhotoCollectionViewController ()

@end

@implementation PHPhotoCollectionViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];

    if (!self)
        return nil;

    

    return self;
}

- (void)didReceiveMemoryWarning
{
    NSLog(@"Received memory warning");
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5000;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"PhotoCell";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];

    if (!cell)
        NSLog(@"Dropped cell");

    return cell;
}

@end
