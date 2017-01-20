//
//  JLGCDTestViewController.m
//  JLConcurrencyTest
//
//  Created by Julian Song on 17/1/20.
//
//

#import "JLGCDTestViewController.h"

@interface JLGCDTestViewController ()
@property(nonatomic,strong)UIButton *globalQueueAndAsyncBtn;
@property(nonatomic,strong)UIButton *globalQueueAndSyncBtn;

@property(nonatomic,strong)UIButton *concurrentQueueAndSyncBtn;
@property(nonatomic,strong)UIButton *concurrentQueueAndAsyncBtn;

@property(nonatomic,strong)UIButton *serialQueueAndSyncBtn;
@property(nonatomic,strong)UIButton *serialQueueAndAsyncBtn;

@property(nonatomic,strong)UIButton *applayBtn;
@end

@implementation JLGCDTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.globalQueueAndSyncBtn = [[UIButton alloc] init];
    [self.globalQueueAndSyncBtn setTitle:@"Global Queue And Sync" forState:UIControlStateNormal];
    
    self.globalQueueAndSyncBtn.backgroundColor = self.view.tintColor;
    self.globalQueueAndSyncBtn.layer.cornerRadius = 4;
    [self.globalQueueAndSyncBtn addTarget:self action:@selector(globalQueueAndSync) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.globalQueueAndSyncBtn];
    
    self.globalQueueAndAsyncBtn = [[UIButton alloc] init];
    [self.globalQueueAndAsyncBtn setTitle:@"Global Queue And Async" forState:UIControlStateNormal];
    self.globalQueueAndAsyncBtn.backgroundColor = self.view.tintColor;
    self.globalQueueAndAsyncBtn.layer.cornerRadius = 4;
    [self.globalQueueAndAsyncBtn addTarget:self action:@selector(globalQueueAndAsync) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.globalQueueAndAsyncBtn];
    
    
    self.concurrentQueueAndSyncBtn = [[UIButton alloc] init];
    [self.concurrentQueueAndSyncBtn setTitle:@"Concurrent Queue And Sync" forState:UIControlStateNormal];
    self.concurrentQueueAndSyncBtn.backgroundColor = self.view.tintColor;
    self.concurrentQueueAndSyncBtn.layer.cornerRadius = 4;
    [self.concurrentQueueAndSyncBtn addTarget:self action:@selector(concurrentQueueAndSync) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.concurrentQueueAndSyncBtn];
    
    self.concurrentQueueAndAsyncBtn = [[UIButton alloc] init];
    [self.concurrentQueueAndAsyncBtn setTitle:@"Concurrent Queue And Async" forState:UIControlStateNormal];
    self.concurrentQueueAndAsyncBtn.backgroundColor = self.view.tintColor;
    self.concurrentQueueAndAsyncBtn.layer.cornerRadius = 4;
    [self.concurrentQueueAndAsyncBtn addTarget:self action:@selector(concurrentQueueAndAsync) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.concurrentQueueAndAsyncBtn];
    
    self.serialQueueAndSyncBtn = [[UIButton alloc] init];
    [self.serialQueueAndSyncBtn setTitle:@"Serial Queue And Sync" forState:UIControlStateNormal];
    self.serialQueueAndSyncBtn.backgroundColor = self.view.tintColor;
    self.serialQueueAndSyncBtn.layer.cornerRadius = 4;
    [self.serialQueueAndSyncBtn addTarget:self action:@selector(serialQueueAndSync) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.serialQueueAndSyncBtn];
    
    self.serialQueueAndAsyncBtn = [[UIButton alloc] init];
    [self.serialQueueAndAsyncBtn setTitle:@"Serial Queue And Async" forState:UIControlStateNormal];
    self.serialQueueAndAsyncBtn.backgroundColor = self.view.tintColor;
    self.serialQueueAndAsyncBtn.layer.cornerRadius = 4;
    [self.serialQueueAndAsyncBtn addTarget:self action:@selector(serialQueueAndAsync) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.serialQueueAndAsyncBtn];
    
    self.applayBtn = [[UIButton alloc] init];
    [self.applayBtn setTitle:@"Dispatch Applay" forState:UIControlStateNormal];
    self.applayBtn.backgroundColor = self.view.tintColor;
    self.applayBtn.layer.cornerRadius = 4;
    [self.applayBtn addTarget:self action:@selector(gcdApplay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.applayBtn];

}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.globalQueueAndSyncBtn.frame = CGRectMake(10,74,CGRectGetWidth(self.view.bounds) - 20,40);
    self.globalQueueAndAsyncBtn.frame = CGRectMake(10,124,CGRectGetWidth(self.view.bounds) - 20,40);
    self.concurrentQueueAndSyncBtn.frame = CGRectMake(10,174,CGRectGetWidth(self.view.bounds) - 20,40);
    self.concurrentQueueAndAsyncBtn.frame = CGRectMake(10,224,CGRectGetWidth(self.view.bounds) - 20,40);
    
    self.serialQueueAndSyncBtn.frame = CGRectMake(10,274,CGRectGetWidth(self.view.bounds) - 20,40);
    self.serialQueueAndAsyncBtn.frame = CGRectMake(10,324,CGRectGetWidth(self.view.bounds) - 20,40);
    self.applayBtn.frame = CGRectMake(10,374,CGRectGetWidth(self.view.bounds) - 20,40);
}

- (void)globalQueueAndSync
{
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), ^{
        sleep(2);
        NSLog(@"Global_Queue_And_Sync task 1");
    });
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), ^{
        sleep(5);
        NSLog(@"Global_Queue_And_Sync task 2");
    });
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), ^{
        sleep(3);
        NSLog(@"Global_Queue_And_Sync task 3");
    });
    
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), ^{
        sleep(2);
        NSLog(@"Global_Queue_And_Sync task 4");
    });
}

- (void)globalQueueAndAsync
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), ^{
        sleep(2);
        NSLog(@"Global_Queue_And_Async task 1");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), ^{
        sleep(5);
        NSLog(@"Global_Queue_And_Async task 2");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), ^{
        sleep(3);
        NSLog(@"Global_Queue_And_Async task 3");
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH,0), ^{
        sleep(2);
        NSLog(@"Global_Queue_And_Async task 4");
    });
}

- (void)concurrentQueueAndSync
{
    dispatch_queue_t aque = dispatch_queue_create("com.my.concurrentQueueAndSync", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(aque, ^{
        NSLog(@"Concurrent_Queue_And_Sync task 1 start");
        sleep(2);
        NSLog(@"Concurrent_Queue_And_Sync task 1 end");
    });
    
    dispatch_sync(aque, ^{
        NSLog(@"Concurrent_Queue_And_Sync task 2 start");
        sleep(5);
        NSLog(@"Concurrent_Queue_And_Sync task 2 end");
    });
    
    dispatch_sync(aque, ^{
        NSLog(@"Concurrent_Queue_And_Sync task 3 start");
        sleep(3);
        NSLog(@"Concurrent_Queue_And_Sync task 3 end");
    });
}

- (void)concurrentQueueAndAsync
{
    dispatch_queue_t aque = dispatch_queue_create("com.my.concurrentQueueAndAsync", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(aque, ^{
        NSLog(@"Concurrent_Queue_And_Async task 1 start");
        sleep(2);
        NSLog(@"Concurrent_Queue_And_Async task 1 end");
    });
    
    dispatch_async(aque, ^{
        NSLog(@"Concurrent_Queue_And_Async task 2 start");
        sleep(5);
        NSLog(@"Concurrent_Queue_And_Async task 2 end");
    });
    
    dispatch_async(aque, ^{
        NSLog(@"Concurrent_Queue_And_Async task 3 start");
        sleep(3);
        NSLog(@"Concurrent_Queue_And_Async task 3 end");
    });
}

- (void)serialQueueAndSync
{
    dispatch_queue_t aque = dispatch_queue_create("com.my.serialQueueAndSync", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(aque, ^{
        NSLog(@"Serial_Queue_And_Sync task 1 start");
        sleep(2);
        NSLog(@"Serial_Queue_And_Sync task 1 end");
    });
    
    dispatch_sync(aque, ^{
        NSLog(@"Serial_Queue_And_Sync task 2 start");
        sleep(5);
        NSLog(@"Serial_Queue_And_Sync task 2 end");
    });
    
    dispatch_sync(aque, ^{
        NSLog(@"Serial_Queue_And_Sync task 3 start");
        sleep(3);
        NSLog(@"Serial_Queue_And_Sync task 3 end");
    });
}

- (void)serialQueueAndAsync
{
    dispatch_queue_t aque = dispatch_queue_create("com.my.serialQueueAndAsync", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(aque, ^{
        NSLog(@"Serial_Queue_And_Async task 1 start");
        sleep(2);
        NSLog(@"Serial_Queue_And_Async task 1 end");
    });
    
    dispatch_async(aque, ^{
        NSLog(@"Serial_Queue_And_Async task 2 start");
        sleep(5);
        NSLog(@"Serial_Queue_And_Async task 2 end");
    });
    
    dispatch_async(aque, ^{
        NSLog(@"Serial_Queue_And_Async task 3 start");
        sleep(3);
        NSLog(@"Serial_Queue_And_Async task 3 end");
    });
}

- (void)gcdApplay
{
    NSArray *testArray = @[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n"];
    NSMutableArray *result = [[NSMutableArray alloc] init];
    dispatch_queue_t aque = dispatch_queue_create("com.my.gcdApplay", DISPATCH_QUEUE_CONCURRENT);
    //dispatch_async(aque, ^{
        dispatch_apply(testArray.count, aque, ^(size_t i) {
            NSString *str = testArray[i];
            NSLog(@"Apply task on CONCURRENT queue %@ %ld start",str,i);
            [result insertObject:[NSString stringWithFormat:@"%@_%ld",str,i] atIndex:i];
            NSLog(@"Apply task on CONCURRENT queue %@ %ld end",str,i);
        });
    ///});
    NSLog(@"result is %@",result);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end