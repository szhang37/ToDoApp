//
//  ViewController.m
//  ToDoApp
//
//  Created by Shi Zhang on 10/26/18.
//  Copyright © 2018 Shi Zhang. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "ToDoTableViewCell.h"

#import <CoreData/CoreData.h>

@interface ViewController ()

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)initializeFetchedResultsController
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    
    NSSortDescriptor *lastNameSort = [NSSortDescriptor sortDescriptorWithKey:@"lastName" ascending:YES];
    
    [request setSortDescriptors:@[lastNameSort]];
    
    AppDelegate *ad = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *moc = ad.persistentContainer.viewContext;
    
    [self setFetchedResultsController:[[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:moc sectionNameKeyPath:nil cacheName:nil]];
    [[self fetchedResultsController] setDelegate:self];
    
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error]) {
        NSLog(@"Failed to initialize FetchedResultsController: %@\n%@", [error localizedDescription], [error userInfo]);
        abort();
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[_fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
    if ([[_fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo numberOfObjects];
    } else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ToDoTableViewCell *cell = [[ToDoTableViewCell alloc] init];
    NSManagedObject *managedObject = [_fetchedResultsController objectAtIndexPath:indexPath];
    // Configure the cell with data from the managed object.
    cell.listTitle = managedObject.title;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([[_fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo name];
    } else
        return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [_fetchedResultsController sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [_fetchedResultsController sectionForSectionIndexTitle:title atIndex:index];
}

@end
