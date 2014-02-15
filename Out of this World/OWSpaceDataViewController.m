//
//  OWSpaceDataViewController.m
//  Out of this World
//
//  Created by Vincent Inverso on 2/12/14.
//  Copyright (c) 2014 Vincent Inverso. All rights reserved.
//

#import "OWSpaceDataViewController.h"

@interface OWSpaceDataViewController ()

@end

@implementation OWSpaceDataViewController

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
    self.view.backgroundColor = [UIColor blackColor];
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DataCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    switch (indexPath.row){
        case 0:
            cell.textLabel.text = @"Nickname";
            cell.detailTextLabel.text = self.spaceObject.nickName;
            break;
        case 2:
            cell.textLabel.text = @"Gravitational Force";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", self.spaceObject.gravitationalForce];
            break;
        case 1:
            cell.textLabel.text = @"Diameter (km)";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", self.spaceObject.diamater];
            break;
        case 3:
            cell.textLabel.text = @"Length of a Year (days)";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", self.spaceObject.yearLength];
            break;
        case 4:
            cell.textLabel.text = @"Length of a Day (Hours)";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", self.spaceObject.dayLength];
            break;
        case 5:
            cell.textLabel.text = @"Temperature (c)";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", self.spaceObject.temperature];
            break;
        case 6:
            cell.textLabel.text = @"Diameter (km)";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", self.spaceObject.diamater];
            break;
        case 7:
            cell.textLabel.text = @"Diameter (km)";
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%f", self.spaceObject.diamater];
            break;
        default:
            break;
    }
    
    return cell;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 8;
}










@end
