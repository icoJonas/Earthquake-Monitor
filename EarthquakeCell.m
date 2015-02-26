//
//  EarthquakeCell.m
//  earthquakeMonitor
//
//  Created by Luis Jonathan Godoy Marín on 25/02/15.
//  Copyright (c) 2015 Peps & Goms. All rights reserved.
//

#import "EarthquakeCell.h"
#import "DatabaseConstants.h"

@implementation EarthquakeCell

- (void)awakeFromNib
{
    // Initialization code
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, [[UIScreen mainScreen] bounds].size.width, self.frame.size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
}

#pragma mark -
#pragma mark Public methods

-(void)setupCellWithData:(NSDictionary *)d
{
    placeValueLabel.text = [d objectForKey:DB_EARTHQUAKE_PLACE];
    magnitudeValueLabel.text = [NSString stringWithFormat:@"%.2f",[[d objectForKey:DB_EARTHQUAKE_MAGNITUDE] floatValue]];
    backgroundEarthquakeCell.backgroundColor = [ColorCodeHelper colorForMagnitude:[[d objectForKey:DB_EARTHQUAKE_MAGNITUDE] floatValue]];
}

@end