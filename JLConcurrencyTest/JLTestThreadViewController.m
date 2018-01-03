   //
//  ViewController.m
//  ThreadTest
//
//  Created by Julian Song on 16/12/26.
//  Copyright © 2016年  reserved.
//

#import "JLTestThreadViewController.h"

@interface JLTestThreadViewController ()<UITableViewDataSource>

@property(nonatomic,strong)NSThread *backThread;

@property(nonatomic,strong)NSThread *backThread2;

@property(nonatomic,strong)UIButton *starBtn;
@property(nonatomic,strong)UIButton *cancelBtn;
@property(nonatomic,strong)UIButton *exiteBtn;

@property(nonatomic,strong)UITableView *leftTableView;
@property(nonatomic,strong)UITableView *rightTableView;

@property(nonatomic,strong)NSMutableArray *leftData;
@property(nonatomic,strong)NSMutableArray *rightData;
@end

@implementation JLTestThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.leftData = [NSMutableArray new];
    self.rightData = [NSMutableArray new];
    
    self.leftTableView = [[UITableView alloc] init];
    self.leftTableView.contentInset = UIEdgeInsetsMake(64,0,0,0);
    self.leftTableView.dataSource = self;
    [self.view addSubview:self.leftTableView];
    
    self.rightTableView = [[UITableView alloc] init];
    self.rightTableView.contentInset = UIEdgeInsetsMake(64,0,0,0);
    self.rightTableView.dataSource = self;
    [self.view addSubview:self.rightTableView];
    
    
    self.backThread  = [[NSThread alloc] initWithTarget:self selector:@selector(threadMainRoutine) object:nil];
    [self.backThread setName:@"数列计算线程"];
    
    self.backThread2  = [[NSThread alloc] initWithTarget:self selector:@selector(backTask) object:nil];
    [self.backThread2 setName:@"数列计算线程2"];
    
    self.starBtn = [[UIButton alloc] init];
    [self.starBtn setTitle:@"Start" forState:UIControlStateNormal];
    self.starBtn.backgroundColor = [UIColor greenColor];
    [self.starBtn addTarget:self.backThread2 action:@selector(start) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.starBtn];
    
    self.cancelBtn = [[UIButton alloc] init];
    [self.cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    self.cancelBtn.backgroundColor = [UIColor redColor];
    [self.cancelBtn addTarget:self.backThread action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    
    self.exiteBtn = [[UIButton alloc] init];
    [self.exiteBtn setTitle:@"Exit" forState:UIControlStateNormal];
    self.exiteBtn.backgroundColor = [UIColor grayColor];
    [self.exiteBtn addTarget:self action:@selector(exitBackThread) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.starBtn];
    [self.view addSubview:self.cancelBtn];
    [self.view addSubview:self.exiteBtn];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (UIStatusBarStyle )preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)threadMainRoutine
{
    BOOL moreWorkToDo = YES;
    BOOL exitNow = NO;
    NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
    
    // Add the exitNow BOOL to the thread dictionary.
    NSMutableDictionary* threadDict = [[NSThread currentThread] threadDictionary];
    [threadDict setValue:[NSNumber numberWithBool:exitNow] forKey:@"ThreadShouldExitNow"];
    
    // Install an input source.
    //[self myInstallCustomInputSource];
    
    while (moreWorkToDo && !exitNow)
    {
        // Do one chunk of a larger body of work here.
        // Change the value of the moreWorkToDo Boolean when done.
        
        // Run the run loop but timeout immediately if the input source isn't waiting to fire.
        [runLoop runUntilDate:[NSDate date]];
        
        // Check to see if an input source handler changed the exitNow value.
        exitNow = [[threadDict valueForKey:@"ThreadShouldExitNow"] boolValue];
    }
}


- (void)backTask
{

    
    
   for (NSInteger i = 0; i < 20; i ++) {
        NSLog(@"i is %ld",(long)i);
        [self performSelectorOnMainThread:@selector(mainLeftTask:) withObject:@(i) waitUntilDone:NO];
        
        sleep(1);
        if (i % 5 == 3) {
            [self performSelectorOnMainThread:@selector(mainRightTask:) withObject:@(i) waitUntilDone:NO];
        }
        if (self.rightData.count == 5) {
//            [NSThread exit];
        }
    }
    
    NSDate *date =[NSDate dateWithTimeIntervalSinceNow:4];
    NSLog(@"%@",date);
    [[NSRunLoop currentRunLoop] runUntilDate:date];
    NSLog(@"run loop exit");
}

- (void)exitBackThread
{
    [self performSelector:@selector(stopBackThread:) onThread:self.backThread withObject:nil waitUntilDone:NO];
}

- (void)stopBackThread:(id)data
{
    if ([NSThread currentThread] == self.backThread) {
        NSLog(@"backThread线程被杀");
        //[NSThread exit];
    }else{
        NSLog(@"主线程被杀");
    }
}

- (void)mainLeftTask:(id)number
{
    [self.leftData insertObject:number atIndex:0];
    
    [self.leftTableView beginUpdates];
    [self.leftTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    [self.leftTableView endUpdates];
    
    //[self.leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.leftData.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)mainRightTask:(id)number
{
    [self.rightData insertObject:number atIndex:0];
    
    [self.rightTableView beginUpdates];
    [self.rightTableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
    [self.rightTableView endUpdates];
    
    //[self.rightTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.leftData.count - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.leftTableView.frame = CGRectMake(0,0,CGRectGetWidth(self.view.bounds) / 2,CGRectGetHeight(self.view.bounds)-50);
    
    self.rightTableView.frame = CGRectMake(CGRectGetWidth(self.view.bounds) / 2,0,CGRectGetWidth(self.view.bounds) / 2,CGRectGetHeight(self.view.bounds) - 50);
    
    CGFloat width = CGRectGetWidth(self.view.bounds) /3;
    self.starBtn.frame = CGRectMake(0,CGRectGetHeight(self.view.bounds) - 50,width,50);
    self.cancelBtn.frame = CGRectMake(width,CGRectGetHeight(self.view.bounds) - 50,width,50);
    self.exiteBtn.frame = CGRectMake(width * 2,CGRectGetHeight(self.view.bounds) - 50,width,50);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTableView) {
        return self.leftData.count;
    }
    return self.rightData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CELL"];
    }
    if (tableView == self.leftTableView) {
        cell.textLabel.text = [self.leftData[indexPath.row] description];
    }else{
        cell.textLabel.text = [self.rightData[indexPath.row] description];
    }
    
    return cell;
}
@end
