//
//  RootViewController.m
//  MagicalRecordDemo
//
//  Created by 愤怒的振振 on 15-5-9.
//  Copyright (c) 2015年 LiuWeiZhen. All rights reserved.
//

#import "RootViewController.h"
#import "Person.h"
#import "CoreData+MagicalRecord.h"

@interface RootViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *ageField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameFild;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *personArray;
@end

@implementation RootViewController


- (NSMutableArray *)personArray {
    if (_personArray == nil) {
        _personArray = [[NSMutableArray alloc] init];
    }
    return _personArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.personArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    
    Person *person = self.personArray[indexPath.row];
    cell.textLabel.text = person.firstname;
    cell.detailTextLabel.text = person.lastname;
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)add:(id)sender {
    // ruby on rails
    Person *person = [Person MR_createEntity];
    person.age = [NSNumber numberWithInteger:[_ageField.text integerValue]];
    person.firstname = _firstNameField.text;
    person.lastname  = _lastNameFild.text;
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (IBAction)delete:(id)sender {
    // 删除20岁的学生
    NSArray *array = [Person MR_findByAttribute:@"age" withValue:@20];
    for (Person *person in array) {
        [person MR_deleteEntity]; // 内存删除
    }
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (IBAction)update:(id)sender {
    // 把第一个学生的名字改为xxx
    Person *person   = [Person MR_findFirst];
    person.firstname = @"xxx";
    person.lastname  = @"yyy";
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

- (IBAction)fetch:(id)sender {
    NSArray *array = [Person MR_findAll];
    [self.personArray removeAllObjects];
    [self.personArray addObjectsFromArray:array];
    [self.tableView reloadData];
}

@end
