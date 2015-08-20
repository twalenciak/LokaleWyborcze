//
//  Local.m
//  LokaleWyborcze
//
//  Created by Bitcats on 19/08/15.
//  Copyright (c) 2015 TWalenciak. All rights reserved.
//

#import "Local.h"

#define IMAGE_URL_FORMAT @"http://sip.geopoz.pl/mapa_geopoz/data/wizualizacja/lokale_wyborcze/%d/ikona.gif"

@implementation Local

- (instancetype)initWithJSONDictionary:(NSDictionary *)jsonDict
{
    self = [super init];
    
    _uid = [[jsonDict objectForKey:@"id"]integerValue];
    
    NSDictionary *properties = [jsonDict objectForKey:@"properties"];
    
    _address = [properties objectForKey:@"adres"];
    _localNum = [[properties objectForKey:@"nr_lokalu"]integerValue];
    
    NSArray *coords = [[jsonDict objectForKey:@"geometry"]objectForKey:@"coordinates"];
    if ([coords count] == 2) {
        double lon = [coords[0]doubleValue];
        double lat = [coords[1]doubleValue];
        _location = CLLocationCoordinate2DMake(lat, lon);
    }
    return self;
}

- (NSString *)imgLink
{
    return [NSString stringWithFormat:IMAGE_URL_FORMAT, (int)_localNum];
}

@end
