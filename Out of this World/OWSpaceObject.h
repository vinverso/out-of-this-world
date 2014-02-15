//
//  OWSpaceObject.h
//  Out of this World
//
//  Created by Vincent Inverso on 2/11/14.
//  Copyright (c) 2014 Vincent Inverso. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWSpaceObject : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) float gravitationalForce;
@property (nonatomic) float diamater;
@property (nonatomic) float yearLength;
@property (nonatomic) float dayLength;
@property (nonatomic) float temperature;
@property (nonatomic) int numberOfMoons;
@property (strong, nonatomic) NSString * nickName;
@property (strong, nonatomic) NSString * interestFact;

@property (strong, nonatomic) UIImage * spaceImage;

-(id)initWithData:(NSDictionary*)data andImage:(UIImage*)image;

@end
