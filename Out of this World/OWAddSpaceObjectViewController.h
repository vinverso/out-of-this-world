//
//  OWAddSpaceObjectViewController.h
//  Out of this World
//
//  Created by Vincent Inverso on 2/14/14.
//  Copyright (c) 2014 Vincent Inverso. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWSpaceObject.h"

@protocol OWAddSpaceObjectViewControllerDelegate <NSObject>

@required
-(void)addSpaceObject:(OWSpaceObject*)spaceObj;
-(void)didCancel;

@end


@interface OWAddSpaceObjectViewController : UIViewController

@property (weak, nonatomic) id <OWAddSpaceObjectViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *nickname;
@property (strong, nonatomic) IBOutlet UITextField *diameter;
@property (strong, nonatomic) IBOutlet UITextField *temp;
@property (strong, nonatomic) IBOutlet UITextField *numOfMoons;
@property (strong, nonatomic) IBOutlet UITextField *fact;



- (IBAction)cancel:(UIButton *)sender;
- (IBAction)addPlanet:(UIButton *)sender;




@end
