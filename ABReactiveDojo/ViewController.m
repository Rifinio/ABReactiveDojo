//
//  ViewController.m
//  ABReactiveDojo
//
//  Created by Adil BOUGAMZA on 02/06/2016.
//  Copyright © 2016 Adil Bougamza. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonnull, nonatomic, strong) NSArray <NSString *>* objectsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"UI Objects";

    _objectsArray = [[NSArray alloc] initWithObjects:@"TextField",@"DatePicker", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableView Delegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objectsArray.count;
}

#pragma mark TableView DataSource Delegates

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"CellId";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }

    cell.textLabel.text = [self.objectsArray objectAtIndex:indexPath.row];

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *selectedObject = [self.objectsArray objectAtIndex:indexPath.row];
    NSString *className = [NSString stringWithFormat:@"%@ReactiveViewController",selectedObject];

    [self.navigationController pushViewController:[self getViewControllerForElement:className] animated:YES];
}

-(ABReactiveViewController *) getViewControllerForElement:(NSString *)element
{
    // return a view controller out of the ui element string
    Class theClass = NSClassFromString(element);
    return (ABReactiveViewController *) [[theClass alloc] init];
}

@end
