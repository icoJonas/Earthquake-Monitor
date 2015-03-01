//
//  earthquakeMonitorMainViewController.m
//  earthquakeMonitor
//
//  Created by Luis Jonathan Godoy Marín on 25/02/15.
//  Copyright (c) 2015 Peps & Goms. All rights reserved.
//

#import "earthquakeMonitorMainViewController.h"
#import "EarthquakeDetailViewController.h"
#import "EarthquakeAnnotation.h"

@interface earthquakeMonitorMainViewController ()

@end

@implementation earthquakeMonitorMainViewController

#pragma mark -
#pragma mark UIViewController overrides

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        earthquakeSyncOperation = [[EarthquakeOperation alloc] init];
        dataSource = [[EarthquakeDataSource alloc] init];
        refreshControl = [[UIRefreshControl alloc]init];
        earthquakes = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
    [self setupTable];
    [self getNewEarthquakes];
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

-(IBAction)changeSelection:(id)sender {
    if (segmentedControl.selectedSegmentIndex == 1) {
        earthquakeTableView.hidden = true;
        earthquakeMapView.hidden = false;
        [self.view bringSubviewToFront:earthquakeMapView];
        [self setupAnnotation];
    } else {
        earthquakeMapView.hidden = true;
        earthquakeTableView.hidden = false;
        [self.view bringSubviewToFront:earthquakeTableView];
    }
}

-(IBAction)refreshData:(id)sender {
    [self getNewEarthquakes];
}

#pragma mark -
#pragma mark Private UI methods

-(void)setupView {
    self.view.frame = [[UIScreen mainScreen] bounds];
    topView.frame = CGRectMake(0, 0, self.view.frame.size.width, 129.0);
    titleLabel.center = CGPointMake(topView.frame.size.width/2, titleLabel.center.y);
    refreshButton.frame = CGRectMake(topView.frame.size.width-refreshButton.frame.size.width, titleLabel.frame.origin.y+titleLabel.frame.size.height, refreshButton.frame.size.width, refreshButton.frame.size.height);
    segmentedControl.frame = CGRectMake(0, topView.frame.size.height-segmentedControl.frame.size.height-2, topView.frame.size.width, segmentedControl.frame.size.height);
    earthquakeMapView.frame = CGRectMake(0, topView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-topView.frame.size.height);
    earthquakeTableView.frame = CGRectMake(0, topView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height-topView.frame.size.height);
    
    earthquakeMapView.hidden = true;
    [self.view bringSubviewToFront:earthquakeTableView];

    [earthquakeTableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
}


#pragma mark -
#pragma mark Private methods

-(void)setupTable
{
    [earthquakeTableView registerNib:[UINib nibWithNibName:@"EarthquakeCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    earthquakeTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [earthquakeTableView setBackgroundColor:[UIColor clearColor]];
}

-(void)getNewEarthquakes {
    [earthquakeSyncOperation performOperationWithDelegate:self];
}

-(void)reloadTable{
    [earthquakes removeAllObjects];
    [earthquakes addObjectsFromArray:[dataSource getLastEarthquakes]];
    titleLabel.text = [dataSource getTitle];
    [refreshControl endRefreshing];
    [earthquakeTableView reloadData];
}


-(void)showEarthquakeDetailController:(NSDictionary *)data
{
    EarthquakeDetailViewController *detailCont = [[EarthquakeDetailViewController alloc] initWithNibName:@"EarthquakeDetailViewController" bundle:nil];
    detailCont.data = data;
    UINavigationController *navCont = [[UINavigationController alloc] initWithRootViewController:detailCont];
    [navCont setNavigationBarHidden:YES];
    navCont.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:navCont animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource protocol methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tb
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [earthquakes count];
}

-(UITableViewCell *)tableView:(UITableView *)tb cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    NSDictionary *data = [earthquakes objectAtIndex:indexPath.row];
    EarthquakeCell *cell =  [tb dequeueReusableCellWithIdentifier:cellIdentifier];
    [cell setupCellWithData:data];
    return cell;
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showEarthquakeDetailController:[earthquakes objectAtIndex:indexPath.row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 102.0;
}

#pragma mark -
#pragma mark MKMapView delegate methods

-(void)setupAnnotation{
    for (id<MKAnnotation> annotation in earthquakeMapView.annotations) {
        [earthquakeMapView removeAnnotation:annotation];
    }
    for (NSDictionary *data in earthquakes) {
        NSNumber *longitude = [data objectForKey:DB_EARTHQUAKE_LATITUDE];
        NSNumber *latitude = [data objectForKey:DB_EARTHQUAKE_LONGITUDE];
        CLLocationCoordinate2D eqCoordinate;
        eqCoordinate.latitude = [latitude floatValue];
        eqCoordinate.longitude = [longitude floatValue];
        EarthquakeAnnotation *eqAnnotation = [[EarthquakeAnnotation alloc] initWithPlace:[data objectForKey:DB_EARTHQUAKE_PLACE] coordinate:eqCoordinate];
        [earthquakeMapView addAnnotation:eqAnnotation];
    }
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

#pragma mark -
#pragma mark EarthquakeOperation delegate methods

-(void)operationFinished {
    NSLog(@"operationFinished");
    [self reloadViewsAnyway];
}

-(void)operationFailedWithError:(NSError *)error{
    NSLog(@"%@",error);
    [self reloadViewsAnyway];
}

-(void)reloadViewsAnyway {
    if (segmentedControl.selectedSegmentIndex == 0) {
        
        double delayInSeconds = 2.0;
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [self reloadTable];
        }
                       );
    } else {
        [self setupAnnotation];
    }
}

@end

