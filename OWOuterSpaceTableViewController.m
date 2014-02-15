//
//  OWOuterSpaceTableViewController.m
//  Out of this World
//
//  Created by Vincent Inverso on 2/11/14.
//  Copyright (c) 2014 Vincent Inverso. All rights reserved.
//

#import "OWOuterSpaceTableViewController.h"
#import "AstronomicalData.h"
#import "OWSpaceObject.h"
#import "OWViewController.h"
#import "OWSpaceDataViewController.h"


@interface OWOuterSpaceTableViewController ()

@end




@implementation OWOuterSpaceTableViewController

#define ADDED_SPACE_OBJECTS_KEY @"Added space objects array";

#pragma mark  - Lazy Instantiation of Properties ///////////////////////

-(NSMutableArray *) planets
{
    if (!_planets) {
        _planets = [[NSMutableArray alloc] init];
    }
    return _planets;
}

-(NSMutableArray *) addedSpaceObjects
{
    if (!_addedSpaceObjects) {
        _addedSpaceObjects = [[NSMutableArray alloc] init];
    }
    return _addedSpaceObjects;
}

/////////////////////////////////////////////////////////////////////


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (NSMutableDictionary * planetData in [AstronomicalData allKnownPlanets]) {
        
        NSString *imgName = @"world-1024x1024.jpg";
        OWSpaceObject * planet = [[OWSpaceObject alloc] initWithData:planetData andImage:[UIImage imageNamed:imgName]];
        [self.planets addObject:planet];
    }
    NSArray *myPlanetsAsPropertyLists = [[NSUserDefaults standardUserDefaults] arrayForKey:@"Added space objects array"];
    
    //here we load the persistent data into addedSpaceObjects
    for (NSDictionary *d in myPlanetsAsPropertyLists) {
        OWSpaceObject * o = [self spaceObjectForDictionary:d];
        [self.addedSpaceObjects addObject:o];
    }
}



//this method allows us to access the next controller and its attirbutes based on which nextViewController we're
//segueing to
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([sender isKindOfClass:[UITableViewCell class]])
    {
        if ([segue.destinationViewController isKindOfClass:[OWViewController class]])
        {
            OWViewController * nextViewController = segue.destinationViewController;
            NSIndexPath *path = [self.tableView indexPathForCell:sender];
            OWSpaceObject *selectedObject;
            
            if (path.section == 0) {
                selectedObject = self.planets[path.row];
            }
            else if (path.section == 1) {
                selectedObject = self.addedSpaceObjects[path.row];
            }
            nextViewController.spaceObject = selectedObject;
        }
    }
    if ([sender isKindOfClass:[NSIndexPath class]])
    {
        if ([segue.destinationViewController isKindOfClass:[OWSpaceDataViewController class]])
        {
            OWSpaceDataViewController * targetVC = segue.destinationViewController;
            NSIndexPath *path = sender;
            OWSpaceObject * obj;
            if (path.section == 0) {
                obj = self.planets[path.row];
            }
            else if (path.section == 1) {
                obj = self.addedSpaceObjects[path.row];
            }
            targetVC.spaceObject = obj;
        }
    }
    if ([segue.destinationViewController isKindOfClass:[OWAddSpaceObjectViewController class]]) {
        OWAddSpaceObjectViewController * nextVC = segue.destinationViewController;
        nextVC.delegate = self;
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




#pragma mark - OWAddSpaceObjectViewcontrollerDelegate ////////////////////////////////////////

-(void) didCancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(void) addSpaceObject:(OWSpaceObject *)spaceObj
{
    
    [self.addedSpaceObjects addObject:spaceObj];
    
    //save to NSUserDefaults here
    NSMutableArray *spaceObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"Added space objects array"] mutableCopy];
    
    if(!spaceObjectsAsPropertyLists) {
        spaceObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    }
    
    [spaceObjectsAsPropertyLists addObject:[self spaceObjectAsAPropertyList:spaceObj]];
    [[NSUserDefaults standardUserDefaults] setObject:spaceObjectsAsPropertyLists forKey:@"Added space objects array"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
}


#pragma mark - Helper Methods /////////////////////////////////////////////////////////////

-(OWSpaceObject *) spaceObjectForDictionary: (NSDictionary *)dict
{
    OWSpaceObject * spaceObject = [[OWSpaceObject alloc] initWithData:dict andImage:[UIImage imageNamed:@"world-1024x1024.jpg"]];
    return spaceObject;
}


-(NSDictionary *) spaceObjectAsAPropertyList: (OWSpaceObject*) obj
{
    NSData * img = UIImagePNGRepresentation(obj.spaceImage);
    
    NSDictionary * d = @{PLANET_NAME : obj.name,
                         PLANET_GRAVITY : @(obj.gravitationalForce),
                         PLANET_DIAMETER : @(obj.diamater),
                         PLANET_YEAR_LENGTH : @(obj.yearLength),
                         PLANET_DAY_LENGTH : @(obj.dayLength),
                         PLANET_TEMPERATURE : @(obj.temperature),
                         PLANET_NUMBER_OF_MOONS : @(obj.numberOfMoons),
                         PLANET_NICKNAME : obj.nickName,
                         PLANET_INTERESTING_FACT : obj.interestFact,
                         PLANET_IMAGE : img};
    
    return d;
}




#pragma mark - Table view data source /////////////////////////////////////////////////////////

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if ([self.addedSpaceObjects count]){
        return 2;
    }
    else {
        return 1;
    }
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 1){
        return [self.addedSpaceObjects count];
    }
    else {
        return [self.planets count];
    }
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (indexPath.section == 1){
        OWSpaceObject * p = [self.addedSpaceObjects objectAtIndex:indexPath.row];
        cell.textLabel.text = p.name;
        cell.detailTextLabel.text = p.nickName;
        cell.imageView.image = p.spaceImage;
    }
    else {
        OWSpaceObject * planet = [self.planets objectAtIndex:indexPath.row];
        cell.textLabel.text = planet.name;
        cell.detailTextLabel.text = planet.nickName;
        cell.imageView.image = planet.spaceImage;
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor colorWithWhite:.5 alpha:1.0];
    
    return cell;
}



#pragma mark UITableView Delegate ///////////////////////////////////////////////////////////

-(void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier: @"push to space data" sender:indexPath];
}




// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        return YES;
    }
    else {
        return NO;
    }
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.addedSpaceObjects removeObjectAtIndex:indexPath.row];
        NSMutableArray *newSavedSpaceObjectData = [[NSMutableArray alloc] init];
        
        for (OWSpaceObject * obj in self.addedSpaceObjects) {
            [newSavedSpaceObjectData addObject:[self spaceObjectAsAPropertyList:obj]];
        }
        [[NSUserDefaults standardUserDefaults] setObject:newSavedSpaceObjectData forKey:@"Added space objects array"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



@end
