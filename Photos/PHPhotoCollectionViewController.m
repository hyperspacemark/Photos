//
//  PHPhotoCollectionViewController.m
//  Photos
//
//  Created by Mark Adams on 10/8/12.
//  Copyright (c) 2012 thoughtbot. All rights reserved.
//

#import "PHPhotoCollectionViewController.h"
#import "PHPhotoCell.h"
#import "PHPhotoCollectionFooterView.h"

@interface PHPhotoCollectionViewController ()

@property (strong, nonatomic) ALAssetsLibrary *assetsLibrary;
@property (strong, nonatomic) NSArray *photos;

@end

#pragma mark -

@implementation PHPhotoCollectionViewController

#pragma mark - Initialization

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];

    if (!self)
        return nil;

    _assetsLibrary = [[ALAssetsLibrary alloc] init];

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadPhotos];
}

- (void)didReceiveMemoryWarning
{
    NSLog(@"Received memory warning");
}

#pragma mark - Asset Loading

- (void)loadPhotos
{
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop)
    {

        if (!group)
            return;

        [self loadPhotosInGroup:group];
        *stop = YES;

    } failureBlock:^(NSError *error) {

        NSLog(@"Error enumerating asset groups: %@, %@", error, error.userInfo);

    }];
}

- (void)loadPhotosInGroup:(ALAssetsGroup *)assetsGroup
{
    __block NSMutableArray *photos = [NSMutableArray arrayWithCapacity:assetsGroup.numberOfAssets];
    
    [assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {

        if (!result)
            return;

        [photos addObject:result];

    }];

    [self reloadCollectionViewWithPhotos:[photos copy]];
}

- (void)reloadCollectionViewWithPhotos:(NSArray *)photos
{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{

        self.photos = photos;
        [self.collectionView reloadData];

    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"PhotoCell";
    PHPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    ALAsset *asset = [self.photos objectAtIndex:indexPath.row];
    cell.contentView.layer.contents = (id)asset.thumbnail;

    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader])
        return nil;
    
    static NSString *viewIdentifier = @"PhotoCollectionFooter";
    PHPhotoCollectionFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:viewIdentifier forIndexPath:indexPath];
    footerView.numberOfPhotosLabel.attributedText = [self attributedNumberOfPhotosString];

    return footerView;
}

- (NSString *)numberOfPhotosString
{
    return [NSString stringWithFormat:@"%i Photos", self.photos.count];
}

- (NSAttributedString *)attributedNumberOfPhotosString
{
    NSString *originalString = [self numberOfPhotosString];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:originalString];
    NSCharacterSet *nonNumericalCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSString *trimmedString = [originalString stringByTrimmingCharactersInSet:nonNumericalCharacterSet];
    NSRange numericRange = [originalString rangeOfString:trimmedString];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20.0f] range:numericRange];

    return attributedString;
}

@end
