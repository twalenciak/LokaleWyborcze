//
//  LocalsProvider.h
//  LokaleWyborcze
//
//  Created by Bitcats on 19/08/15.
//  Copyright (c) 2015 TWalenciak. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LocalsProviderDelegate;


@interface LocalsProvider : NSObject

@property (nonatomic) id<LocalsProviderDelegate>delegate;

@property (nonatomic) NSArray *dataArray;

- (void)reloadData;

@end

@protocol LocalsProviderDelegate <NSObject>

- (void)localsProviderDidReceivedData:(LocalsProvider *)provider;

@end
