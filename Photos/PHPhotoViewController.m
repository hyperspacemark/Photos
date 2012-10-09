//
//  PHPhotoViewController.m
//  Photos
//
//  Created by Mark Adams on 10/9/12.
//  Copyright (c) 2012 thoughtbot. All rights reserved.
//

#import "PHPhotoViewController.h"

@interface PHPhotoViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) UIImage *fullScreenImage;

@end

#pragma mark -

@implementation PHPhotoViewController

#pragma mark - Getters

- (UIImage *)fullScreenImage
{
    if (!_fullScreenImage)
        _fullScreenImage = [UIImage imageWithCGImage:self.photoAsset.defaultRepresentation.fullScreenImage];

    return _fullScreenImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    ALAssetRepresentation *assetRepresentation = self.photoAsset.defaultRepresentation;
    self.fullScreenImage = [UIImage imageWithCGImage:assetRepresentation.fullScreenImage];
    self.imageView.image = self.fullScreenImage;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    ALAssetRepresentation *assetRepresentation = self.photoAsset.defaultRepresentation;
    self.imageView.image = [UIImage imageWithCGImage:assetRepresentation.fullResolutionImage scale:assetRepresentation.scale orientation:assetRepresentation.orientation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.fullScreenImage = nil;
}

#pragma mark - Sharing (is caring)

- (IBAction)share:(UIBarButtonItem *)sender
{
    NSArray *items = (@[ self.fullScreenImage ]);
    UIActivityViewController *avc = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGRect scrollBounds = self.scrollView.bounds;
    CGRect imageViewFrame = self.imageView.frame;

    if (CGRectGetWidth(imageViewFrame) < CGRectGetWidth(scrollBounds))
        imageViewFrame.origin.x = (CGRectGetWidth(scrollBounds) - CGRectGetWidth(imageViewFrame)) / 2;
    else
        imageViewFrame.origin.x = 0.0f;

    if (CGRectGetHeight(imageViewFrame) < CGRectGetHeight(scrollBounds))
        imageViewFrame.origin.y = (CGRectGetHeight(scrollBounds) - CGRectGetHeight(imageViewFrame)) / 2;
    else
        imageViewFrame.origin.y = 0.0f;

    self.imageView.frame = imageViewFrame;

    NSLog(@"Scroll View Content Size: %@", NSStringFromCGSize(self.scrollView.contentSize));
    NSLog(@"Image View Frame Size: %@", NSStringFromCGRect(self.imageView.frame));
}


@end
