//
//  MasterViewController.h
//  JLConcurrencyTest
//
//  Created by Julian Song on 17/1/20.
//
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;


@end

