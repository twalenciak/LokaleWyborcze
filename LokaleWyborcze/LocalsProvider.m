//
//  LocalsProvider.m
//  LokaleWyborcze
//
//  Created by Bitcats on 19/08/15.
//  Copyright (c) 2015 TWalenciak. All rights reserved.
//

#import "LocalsProvider.h"
#import <AFNetworking/AFNetworking.h>
#import "Local.h"
#import <UIKit/UIKit.h>

#define LOCALS_URL @"http://www.poznan.pl/featureserver/featureserver.cgi/wybory_ro_lokale/"

@implementation LocalsProvider

- (void)reloadData
{
    NSURL *url = [NSURL URLWithString:LOCALS_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {

        NSMutableArray *resultModel = [NSMutableArray new];
        
        NSError *err;
        NSDictionary *dictResponse = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                     options:kNilOptions
                                                                       error:&err];
        if (!err) {
            NSArray *dataJSONArray = [dictResponse objectForKey:@"features"];
            
            for (NSDictionary *singleLocalDict in dataJSONArray) {
                Local *newLocal = [[Local alloc]initWithJSONDictionary:singleLocalDict];
                [resultModel addObject:newLocal];
                
            }
            _dataArray = resultModel;
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(localsProviderDidReceivedData:)]) {
                [self.delegate localsProviderDidReceivedData:self];
            }
        } else {
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error parsing API data"
                                                                message:[err localizedDescription]
                                                               delegate:nil
                                                      cancelButtonTitle:@"Ok"
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error receiving API data"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    // 5
    [operation start];
}

@end
