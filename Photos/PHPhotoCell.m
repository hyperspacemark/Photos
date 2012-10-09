//
//  PHPhotoCell.m
//  Photos
//
//  Created by Mark Adams on 10/8/12.
//  Copyright (c) 2012 thoughtbot. All rights reserved.
//

#import "PHPhotoCell.h"

@implementation PHPhotoCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (!self)
        return nil;

    self.backgroundColor = [UIColor blackColor];

    return self;
}

@end
