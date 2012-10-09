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

- (void)setNumberOfPhotos:(NSUInteger)numberOfPhotos
{
    _numberOfPhotos = numberOfPhotos;
    self.numberOfPhotosLabel.attributedText = [self attributedStringForString:[self numberOfPhotosString]];
}

- (NSString *)numberOfPhotosString
{
    return [NSString stringWithFormat:@"%i Photos", self.numberOfPhotos];
}

- (NSAttributedString *)attributedStringForString:(NSString *)string
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSCharacterSet *nonNumericalCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSString *trimmedString = [string stringByTrimmingCharactersInSet:nonNumericalCharacterSet];
    NSRange numericRange = [string rangeOfString:trimmedString];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:20.0f] range:numericRange];

    return attributedString;
}

@end
