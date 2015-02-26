//
//  EarthquakeCell.h
//  earthquakeMonitor
//
//  Created by Luis Jonathan Godoy Marín on 25/02/15.
//  Copyright (c) 2015 Peps & Goms. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ColorCodeHelper.h"

@interface EarthquakeCell : UITableViewCell{
    IBOutlet UIView *backgroundEarthquakeCell;
    IBOutlet UILabel *placeTitleLabel;
    IBOutlet UILabel *placeValueLabel;
    IBOutlet UILabel *magnitudeTitleLabel;
    IBOutlet UILabel *magnitudeValueLabel;
}


-(void)setupCellWithData:(NSDictionary *)d;


@end
