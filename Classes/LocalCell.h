//
//  LocalCell.h
//  LokaleWyborcze
//
//  Created by Bitcats on 19/08/15.
//  Copyright (c) 2015 TWalenciak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalCell : UICollectionViewCell

@property (nonatomic) NSInteger uid;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
