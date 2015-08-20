//
//  MapLocalController.m
//  LokaleWyborcze
//
//  Created by Bitcats on 20/08/15.
//  Copyright (c) 2015 TWalenciak. All rights reserved.
//

#import "MapLocalController.h"

@implementation MapLocalController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.presentedLocal) {
        CLLocationCoordinate2D location = self.presentedLocal.location;
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(location, 2000, 2000);
        viewRegion = [self.mapView regionThatFits:viewRegion];
        [self.mapView setRegion:viewRegion];
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
        [annotation setCoordinate:location];
        [self.mapView addAnnotation:annotation];
    }
}

@end
