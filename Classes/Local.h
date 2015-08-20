//
//  Local.h
//  LokaleWyborcze
//
//  Created by Bitcats on 19/08/15.
//  Copyright (c) 2015 TWalenciak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Local : NSObject

@property (nonatomic) NSInteger uid;
@property (nonatomic) NSInteger localNum;

@property (nonatomic) NSString *address;
@property (nonatomic) CLLocationCoordinate2D location;

@property (nonatomic, readonly) NSString *imgLink;

- (instancetype)initWithJSONDictionary:(NSDictionary *)jsonDict;

@end
