//
//  PHPhotoCollectionFooterView.h
//  Photos
//
//  Created by Mark Adams on 10/9/12.
//  Copyright (c) 2012 thoughtbot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PHPhotoCollectionFooterView : UICollectionReusableView

@property (assign, nonatomic) NSUInteger numberOfPhotos;
@property (weak, nonatomic) IBOutlet UILabel *numberOfPhotosLabel;

@end
