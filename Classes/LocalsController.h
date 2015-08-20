//
//  LocalsController.h
//  LokaleWyborcze
//
//  Created by Bitcats on 19/08/15.
//  Copyright (c) 2015 TWalenciak. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LocalsProvider.h"

@interface LocalsController : UICollectionViewController<LocalsProviderDelegate>

@property (nonatomic) LocalsProvider *localsProvider;

@end
