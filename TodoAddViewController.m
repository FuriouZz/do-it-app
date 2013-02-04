//
//  TodoAddViewController.m
//  Todo
//
//  Created by Christophe on 02/02/13.
//  Copyright (c) 2013 FuriouZz. All rights reserved.
//

#import "TodoAddViewController.h"
#import "TodoTextFieldViewCell.h"

@interface TodoAddViewController ()
@property (retain, nonatomic) NSArray *attributes;
@property (retain, nonatomic) NSMutableArray *values;
@end

@implementation TodoAddViewController
@synthesize managedObjectContext = _managedObjectContext;

- (void)dealloc
{
    [_attributes release];
    [_values release];
    [_managedObjectContext release];
    [super dealloc];
}

- (id)initWithManagedObjectContext:(NSManagedObjectContext *) moc
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
//        self.managedObjectContext = moc;
//        NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Todo" inManagedObjectContext:_managedObjectContext];
//        self.attributes = [[entityDescription attributesByName] allKeys];
//
        
        _values = [[NSMutableArray alloc] init];
        
        
        
        self.tableView.scrollEnabled = NO;
        NSDictionary *title = [[NSDictionary alloc] initWithObjectsAndKeys:@"Your task", @"label", @"title", @"property", @"", @"value",  nil];
        NSDictionary *note = [[NSDictionary alloc] initWithObjectsAndKeys:@"Your note", @"label", @"note", @"property", @"", @"value", nil];
        _attributes = [[NSArray alloc] initWithObjects:title, note, nil];

        for(int i = 0; i < _attributes.count; i++){
            [_values insertObject:@"" atIndex:0];
        }
        
        [title release];
        [note release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(doneAction)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                  target:self
                                                                                  action:@selector(cancelAction)];
    self.title = NSLocalizedString(@"todoAdd-TitleLabel", nil);
    self.navigationItem.rightBarButtonItem = doneButton;
    self.navigationItem.leftBarButtonItem  = cancelButton;
    
    [doneButton release];
    [cancelButton release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    TodoTextFieldViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(cell == nil)
    {
        cell = [[TodoTextFieldViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }

    cell.attribute = [_attributes objectAtIndex:indexPath.row];
    cell.indexPath = indexPath;
    cell.delegate = self;
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - TodoTextFieldViewCellDelegate

- (void)textFieldCell:(TodoTextFieldViewCell *)inCell updateTextLabelAtIndexPath:(NSIndexPath *)inIndexPath string:(NSString *)inValue{
    
    //Add current input to values array, remove old object and insert new until entry is finished.
    
    if (_values.count) {
        [_values removeObjectAtIndex:inIndexPath.row];
        [_values insertObject:inValue atIndex:inIndexPath.row];
    }else{
        [_values insertObject:inValue atIndex:inIndexPath.row];
    }
}

#pragma mark - Actions

- (void)doneAction
{
    //[self.delegate todoAddViewControllerDidFinish:self];
}

- (void)cancelAction
{
    [self.delegate todoAddViewControllerDidFinish:self];
}

@end
