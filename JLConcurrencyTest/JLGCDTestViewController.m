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
@property(nonatomic,strong)UIButton *semaphoresBtn;
@property(nonatomic,strong)UIButton *groupBtn;
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

    self.semaphoresBtn = [[UIButton alloc] init];
    [self.semaphoresBtn setTitle:@"Dispatch Semaphore" forState:UIControlStateNormal];
    self.semaphoresBtn.backgroundColor = self.view.tintColor;
    self.semaphoresBtn.layer.cornerRadius = 4;
    [self.semaphoresBtn addTarget:self action:@selector(gcdSemaphores) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.semaphoresBtn];
    
    self.groupBtn = [[UIButton alloc] init];
    [self.groupBtn setTitle:@"Dispatch Group" forState:UIControlStateNormal];
    self.groupBtn.backgroundColor = self.view.tintColor;
    self.groupBtn.layer.cornerRadius = 4;
    [self.groupBtn addTarget:self action:@selector(gcdGroup) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.groupBtn];
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
    
    self.semaphoresBtn.frame = CGRectMake(10,424,CGRectGetWidth(self.view.bounds) - 20,40);
    
    self.groupBtn.frame = CGRectMake(10,474,CGRectGetWidth(self.view.bounds) - 20,40);
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
     //   NSLog(@"result is %@",result);
   // });
    NSLog(@"result is %@",result);
}

- (void)gcdSemaphores
{
    NSArray *testArray = @[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n"];
    dispatch_queue_t aque = dispatch_queue_create("com.my.gcdSemaphores", DISPATCH_QUEUE_CONCURRENT);
    dispatch_semaphore_t a_semaphore = dispatch_semaphore_create(2);
    
    for (NSString *str in testArray) {
        dispatch_async(aque, ^{
            dispatch_semaphore_wait(a_semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@"Semaphores    %@",str);
            sleep(4);
            dispatch_semaphore_signal(a_semaphore);
        });
    }
    NSLog(@"Semaphores all task had add to the queue");
}

- (void)gcdGroup
{
    dispatch_queue_t aque = dispatch_queue_create("com.my.gcdGroup", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t a_group = dispatch_group_create();
    dispatch_async(aque, ^{
        dispatch_group_async(a_group, aque, ^{
            NSLog(@"Group network request 1 start");
            sleep(2);
            NSLog(@"Group network request 1 end");
        });
        
        dispatch_group_async(a_group, aque, ^{
            NSLog(@"Group network request 2 start");
            sleep(4);
            NSLog(@"Group network request 2 end");
        });
        
        dispatch_group_async(a_group, aque, ^{
            NSLog(@"Group network request 3 start");
            sleep(2);
            NSLog(@"Group network request 3 end");
        });
        dispatch_group_wait(a_group, DISPATCH_TIME_FOREVER);
        NSLog(@"Group all request was done");
    });
    
}
@end
