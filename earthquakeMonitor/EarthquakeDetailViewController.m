//
//  EarthquakeDetailViewController.m
//  earthquakeMonitor
//
//  Created by Luis Jonathan Godoy Marín on 26/02/15.
//  Copyright (c) 2015 Peps & Goms. All rights reserved.
//

#import "EarthquakeDetailViewController.h"
#import "DatabaseConstants.h"
#import "EarthquakeAnnotation.h"

@interface EarthquakeDetailViewController ()

@end

@implementation EarthquakeDetailViewController

#pragma mark -
#pragma mark UIViewController overrides

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
    [self setupData];
    [self setupAnnotation];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

#pragma mark -
#pragma mark User Interaction methods

-(IBAction)back:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark Private UI methods

-(void)setupView {
    self.view.frame = [[UIScreen mainScreen] bounds];
    topView.frame = CGRectMake(0, 0, self.view.frame.size.width, 212.0);
    titleLabel.center = CGPointMake(topView.frame.size.width/2, titleLabel.center.y);
    earthquakeMapView.frame = CGRectMake(0, topView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-topView.frame.size.height);
}

-(void)setupData {
    if (self.data != nil) {
        titleLabel.text =  [self.data objectForKey:DB_EARTHQUAKE_PLACE];
        magnitudeValueLabel.text = [NSString stringWithFormat:@"%.2f",[[self.data objectForKey:DB_EARTHQUAKE_MAGNITUDE] floatValue]];
        depthValueLabel.text = [NSString stringWithFormat:@"%.2f KMS",[[self.data objectForKey:DB_EARTHQUAKE_DEPTH] floatValue]];
        NSDate* ts_utc = [NSDate dateWithTimeIntervalSince1970:[[self.data objectForKey:DB_EARTHQUAKE_TIME] floatValue]/1000];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"]];
        [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
        dateValueLabel.text = [dateFormatter stringFromDate:ts_utc];
    }
}

#pragma mark -
#pragma mark MKMapView delegate methods

-(void)setupAnnotation{
    for (id<MKAnnotation> annotation in earthquakeMapView.annotations) {
        [earthquakeMapView removeAnnotation:annotation];
    }
    NSNumber *longitude = [self.data objectForKey:DB_EARTHQUAKE_LATITUDE];
    NSNumber *latitude = [self.data objectForKey:DB_EARTHQUAKE_LONGITUDE];
    CLLocationCoordinate2D eqCoordinate;
    eqCoordinate.latitude = [latitude floatValue];
    eqCoordinate.longitude = [longitude floatValue];
    EarthquakeAnnotation *eqAnnotation = [[EarthquakeAnnotation alloc] initWithPlace:[self.data objectForKey:DB_EARTHQUAKE_PLACE] coordinate:eqCoordinate];
    [earthquakeMapView addAnnotation:eqAnnotation];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(eqCoordinate, 50000, 50000);
    [earthquakeMapView setRegion:viewRegion animated:YES];
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
    if (![annotation isKindOfClass:[EarthquakeAnnotation class]])
    {
        // Return nil (default view) if annotation is
        // anything but your custom class.
        return nil;
    }
    
    static NSString *reuseId = @"earthq";
    
    MKPinAnnotationView *annView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseId];
    if (annView == nil)
    {
        annView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseId];
        annView.animatesDrop = NO;
        annView.canShowCallout = NO;
        annView.calloutOffset = CGPointMake(-5, 5);
    }
    else
    {
        annView.annotation = annotation;
    }
    
    annView.pinColor = MKPinAnnotationColorGreen;
    
    return annView;

}
@end