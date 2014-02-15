//
//  OWSpaceObject.m
//  Out of this World
//
//  Created by Vincent Inverso on 2/11/14.
//  Copyright (c) 2014 Vincent Inverso. All rights reserved.
//

#import "OWSpaceObject.h"
#import "AstronomicalData.h"

@implementation OWSpaceObject

-(id)init
{
    self = [self initWithData:nil andImage:nil];
    return self;
}

-(id)initWithData:(NSDictionary *)data andImage:(UIImage *)image
{
    self = [super init];
    
    self.name = data[PLANET_NAME];
    self.gravitationalForce = [data[PLANET_GRAVITY] floatValue];
    self.diamater = [data[PLANET_DIAMETER] floatValue];
    self.yearLength = [data[PLANET_YEAR_LENGTH] floatValue];
    self.dayLength = [data[PLANET_DAY_LENGTH] floatValue];
    self.temperature = [data[PLANET_TEMPERATURE] floatValue];
    self.numberOfMoons = [data[PLANET_NUMBER_OF_MOONS] intValue];
    self.nickName = data[PLANET_NICKNAME];
    self.interestFact = data [PLANET_INTERESTING_FACT];
    
    self.spaceImage = image;
    
    return self;
}

@end
