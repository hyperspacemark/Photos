//
//  PHPhotoCollectionFooterView.m
//  Photos
//
//  Created by Mark Adams on 10/9/12.
//  Copyright (c) 2012 thoughtbot. All rights reserved.
//

#import "PHPhotoCollectionFooterView.h"

@interface PHPhotoCollectionFooterView ()

@property (weak, nonatomic) IBOutlet UILabel *numberOfPhotosLabel;

@end

#pragma mark -

@implementation PHPhotoCollectionFooterView

- (void)setNumberOfDisplayedPhotos:(NSUInteger)numberOfPhotos
{
    _numberOfDisplayedPhotos = numberOfPhotos;
    self.numberOfPhotosLabel.attributedText = [self attributedNumberOfPhotosString];
}

- (NSString *)numberOfPhotosString
{
    return [NSString stringWithFormat:@"%i Photos", self.numberOfDisplayedPhotos];
}

- (NSAttributedString *)attributedNumberOfPhotosString
{
    NSString *originalString = [self numberOfPhotosString];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:originalString];
    NSCharacterSet *nonNumericalCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSString *trimmedString = [originalString stringByTrimmingCharactersInSet:nonNumericalCharacterSet];
    NSRange numericRange = [originalString rangeOfString:trimmedString];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:self.numberOfPhotosLabel.font.pointSize] range:numericRange];

    return attributedString;
}

@end
