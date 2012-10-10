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
    UIImage *fullResolutionImage = [UIImage imageWithCGImage:assetRepresentation.fullResolutionImage scale:assetRepresentation.scale orientation:assetRepresentation.orientation];
    self.imageView.image = fullResolutionImage;

    [self resizeImageViewToImage];
    [self centerImageView];
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
    [self centerImageView];
}

#pragma mark UIScrollView Helpers

- (void)resizeImageViewToImage
{
    CGFloat scale = 0.0f;
    CGFloat width = self.imageView.image.size.width;
    CGFloat height = self.imageView.image.size.height;

    CGRect frame = self.imageView.frame;

    if (width > height)
    {
        scale = width / height;
        frame.size.width = CGRectGetWidth(self.scrollView.bounds);
        frame.size.height = frame.size.width / scale;
    }
    else
    {
        scale = height / width;
        frame.size.height = CGRectGetHeight(self.scrollView.bounds);
        frame.size.width = frame.size.height / scale;
    }

    self.imageView.frame = frame;
}

- (void)centerImageView
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
}

@end