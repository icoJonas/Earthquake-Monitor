//
//  earthquakeMonitorMainViewController.h
//  earthquakeMonitor
//
//  Created by Luis Jonathan Godoy Marín on 25/02/15.
//  Copyright (c) 2015 Peps & Goms. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "EarthquakeOperation.h"
#import "EarthquakeCell.h"

@interface earthquakeMonitorMainViewController:UIViewController <UITableViewDataSource, UITableViewDelegate,EarthquakeOperationDelegate, MKMapViewDelegate>{
    EarthquakeOperation *earthquakeSyncOperation;
    NSMutableArray *earthquakes;
    EarthquakeDataSource *dataSource;
    
    UIRefreshControl *refreshControl;
    IBOutlet UIView *topView;
    IBOutlet UILabel *titleLabel;
    IBOutlet UIButton *refreshButton;
    IBOutlet UISegmentedControl *segmentedControl;

    IBOutlet UITableView *earthquakeTableView;
    IBOutlet MKMapView *earthquakeMapView;
}

-(IBAction)changeSelection:(id)sender;
-(IBAction)refreshData:(id)sender;


@end
