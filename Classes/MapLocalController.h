//
//  MapLocalController.h
//  LokaleWyborcze
//
//  Created by Bitcats on 20/08/15.
//  Copyright (c) 2015 TWalenciak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Local.h"
#import <MapKit/MapKit.h>

@interface MapLocalController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property (nonatomic) Local *presentedLocal;
@end
