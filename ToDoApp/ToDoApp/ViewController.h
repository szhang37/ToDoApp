//
//  ViewController.h
//  ToDoApp
//
//  Created by Shi Zhang on 10/26/18.
//  Copyright © 2018 Shi Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

