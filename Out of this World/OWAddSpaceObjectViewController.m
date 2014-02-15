//
//  OWAddSpaceObjectViewController.m
//  Out of this World
//
//  Created by Vincent Inverso on 2/14/14.
//  Copyright (c) 2014 Vincent Inverso. All rights reserved.
//

#import "OWAddSpaceObjectViewController.h"

@interface OWAddSpaceObjectViewController ()

@end

@implementation OWAddSpaceObjectViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIImage * img = [UIImage imageNamed:@"world-1024x1024.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:img];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(UIButton *)sender
{
    [self.delegate didCancel];
    
    
}

- (IBAction)addPlanet:(UIButton *)sender
{
    [self.delegate addSpaceObject:[self returnNewSpaceObject]];
    
    
}


-(OWSpaceObject *)returnNewSpaceObject
{
    OWSpaceObject * obj = [[OWSpaceObject alloc] init];
    obj.name = self.name.text;
    obj.nickName = self.nickname.text;
    obj.diamater = [self.diameter.text floatValue];
    obj.temperature = [self.temp.text floatValue];
    obj.numberOfMoons = [self.numOfMoons.text floatValue];
    obj.interestFact = self.fact.text;
    obj.spaceImage = [UIImage imageNamed:@"world-1024x1024.jpg"];
    
    return obj;
}



@end
