//
//  EarthquakeDetailViewController.h
//  earthquakeMonitor
//
//  Created by Luis Jonathan Godoy Marín on 26/02/15.
//  Copyright (c) 2015 Peps & Goms. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface EarthquakeDetailViewController:UIViewController <MKMapViewDelegate>{
    IBOutlet UIView *topView;
    IBOutlet UILabel *titleLabel;
    IBOutlet MKMapView *earthquakeMapView;
    
    IBOutlet UILabel *magnitudeTitleLabel;
    IBOutlet UILabel *magnitudeValueLabel;
    IBOutlet UILabel *dateTitleLabel;
    IBOutlet UILabel *dateValueLabel;
    IBOutlet UILabel *depthTitleLabel;
    IBOutlet UILabel *depthValueLabel;
}

@property NSDictionary *data;

-(IBAction)back:(id)sender;


@end
