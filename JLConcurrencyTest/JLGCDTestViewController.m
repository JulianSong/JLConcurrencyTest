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
@property(nonatomic,strong)UIButton *barrierBtn;
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
    
    self.barrierBtn = [[UIButton alloc] init];
    [self.barrierBtn setTitle:@"Dispatch Barrier" forState:UIControlStateNormal];
    self.barrierBtn.backgroundColor = self.view.tintColor;
    self.barrierBtn.layer.cornerRadius = 4;
    [self.barrierBtn addTarget:self action:@selector(barrier) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.barrierBtn];
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
    self.barrierBtn.frame = CGRectMake(10,524,CGRectGetWidth(self.view.bounds) - 20,40);
}

#pragma mark- 队列分发及死锁问题

- (void)globalQueueAndSync
{
    //sync 分配任务会阻塞当前线程
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
    //sync 分配任务会阻塞当前线程
    dispatch_queue_t aque = dispatch_queue_create("com.my.concurrentQueueAndSync", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(aque, ^{
        NSThread *current = [NSThread  currentThread];
        NSLog(@"current thread is %@",current);
        /*
         输出：current thread is <NSThread: 0x604000065e80>{number = 1, name = main}
         作为优化系统会把sync的block分派到当前线程执行
         因此系统不会retain 目标队列（target queue），如果queue作为宿主的属性必须声明为strong类型。
         且不会对block做Block_copy
         */
        NSLog(@"Concurrent_Queue_And_Sync task 1 start");
        sleep(2);
        NSLog(@"Concurrent_Queue_And_Sync task 1 end");
    });
    
    dispatch_sync(aque, ^{
        NSLog(@"Concurrent_Queue_And_Sync task 2 start");
        sleep(5);
        NSLog(@"Concurrent_Queue_And_Sync task 2 end");
    });
    
    /*
     在同步队列中向当前同步队列异步分派任务会造成死锁。
     */
    dispatch_async(dispatch_get_main_queue(), ^{
        /*
         async时系统会retain 目标队列（target queue），并在block执行完成后释放。
         系统会对block做Block_copy 和Block_release
         */
        NSLog(@"Concurrent_Queue_And_Sync task 3 start");
        sleep(3);
        NSLog(@"Concurrent_Queue_And_Sync task 3 end");
    });
    
    /*
     下面这段代码运行时候会crash并输出 Thread 1: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0)
     在同步队列中向当前同步队列同步分派任务会造成死锁。
     由此可知主队列也是同步队列
     */
    dispatch_sync(dispatch_get_main_queue(), ^{
        
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
        /*
         在异步队列中向当前异步队列同步分派任务不会造成死锁。
         */
        NSLog(@"Concurrent_Queue_And_Async task 3 start");
        dispatch_sync(aque, ^{
            NSLog(@"Concurrent_Queue_And_Sync task 4 start");
            NSLog(@"Concurrent_Queue_And_Sync task 4 end");
        });
        NSLog(@"Concurrent_Queue_And_Async task 3 end");
    });
    
    dispatch_async(aque, ^{
        /*
         在异步队列中向当前异步队列异步分派任务不会造成死锁。
         */
        NSLog(@"Concurrent_Queue_And_Async task 5 start");
        dispatch_async(aque, ^{
            NSLog(@"Concurrent_Queue_And_Async task 6 start");
            NSLog(@"Concurrent_Queue_And_Async task 6 end");
        });
        NSLog(@"Concurrent_Queue_And_Async task 5 end");
    });
}

- (void)serialQueueAndSync
{
    dispatch_queue_t aque = dispatch_queue_create("com.my.serialQueueAndSync", DISPATCH_QUEUE_SERIAL);
    static const void* specificKey = &specificKey;
    int value = 5;
    dispatch_queue_set_specific(aque, specificKey, &value, NULL);
    dispatch_sync(aque, ^{
        NSThread *current = [NSThread  currentThread];
        NSLog(@"current thread is %@",current);
        NSLog(@"Serial_Queue_And_Sync task 1 start");
        sleep(2);
        NSLog(@"Serial_Queue_And_Sync task 1 end");
    });
    
    dispatch_sync(aque, ^{
        NSLog(@"Serial_Queue_And_Sync task 2 start");
        sleep(5);
        NSLog(@"Serial_Queue_And_Sync task 2 end");
    });
    
    dispatch_async(aque, ^{
        NSLog(@"Concurrent_Queue_And_Async task 3 start");
        /*
         下面这段代码运行时候会crash并输出 Thread 1: EXC_BAD_INSTRUCTION (code=EXC_I386_INVOP, subcode=0x0)
         在同步队列中向当前同步队列同步分派任务会造成死锁。
         */
        
        void *getValue = dispatch_get_specific(specificKey);
        /*
         通过在创建queue时候设置 dispatch_queue_set_specific
         在调用block时候 获取 dispatch_get_specific
         来判断当前队列是否与要执行同步分派的任务相同
         */
        if (getValue == NULL) {
            dispatch_sync(aque, ^{
                NSLog(@"Concurrent_Queue_And_Sync task 4 start");
                NSLog(@"Concurrent_Queue_And_Sync task 4 end");
            });
            NSLog(@"Concurrent_Queue_And_Async task 3 end");
        }
        
        const char *label = dispatch_queue_get_label(DISPATCH_CURRENT_QUEUE_LABEL);
        if (label != NULL) {
            NSString *labelString = [NSString stringWithUTF8String:label];
            NSLog(@"label %@",labelString);
            /*
             通过判断当前队列的label也可以防止死锁
             */
        }
       
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

#pragma mark- 同步问题

- (void)gcdSemaphores
{
    NSArray *testArray = @[@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n"];
    dispatch_queue_t customQueue = dispatch_queue_create("com.my.gcdSemaphores.customQueue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t productQueue = dispatch_queue_create("com.my.gcdSemaphores.productQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_semaphore_t a_semaphore = dispatch_semaphore_create(1);
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    dispatch_async(customQueue, ^{
        while (true) {
            NSLog(@"dispatch_semaphore_wait 1 start");
            dispatch_semaphore_wait(a_semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@"dispatch_semaphore_wait 1 end");
          if (resultArray.count>0) {
                NSLog(@"print %@",resultArray.firstObject);
                [resultArray removeObjectAtIndex:0];
            }
            int x = arc4random() % testArray.count;
            sleep(x);
            dispatch_semaphore_signal(a_semaphore);
            NSLog(@"dispatch_semaphore_signal 1");
        }
    });
    
    for (NSString *item in testArray) {
        dispatch_async(productQueue, ^{
            NSLog(@"dispatch_semaphore_wait 2 start");
            dispatch_semaphore_wait(a_semaphore, DISPATCH_TIME_FOREVER);
            NSLog(@"dispatch_semaphore_wait 2 end");
            NSLog(@"add %@",item);
            [resultArray addObject:item];
            int x = arc4random() % testArray.count;
            dispatch_semaphore_signal(a_semaphore);
//            sleep(x);
            NSLog(@"dispatch_semaphore_signal 2");

        });
    }
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

- (void)barrier
{
    __block NSString *brodcast = @"start";
    dispatch_queue_t customQueue = dispatch_queue_create("com.my.gcdSemaphores.customQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t productQueue = dispatch_queue_create("com.my.gcdSemaphores.productQueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(customQueue, ^{
        while (true) {
            dispatch_async(productQueue, ^{
                NSLog(@"brodcast is %@",brodcast);
            });
        }
    });
    
    dispatch_async(customQueue, ^{
        while (true) {
            int x = arc4random() % 10;
            /*
             使用 barrier async 把block添加到queue之后，该block会等到之前所有block全部执行完成后在执行。且阻塞后面添加的block直到该block执行完成。
             barrier async  只能使用在自己创建的异步队列上，如果使用在同步队列或者全局队列则相当于dispatch_async
             适用于属于某个特定共享数据有大量访问但是有小量修改的地方。
             */
            dispatch_barrier_async(productQueue, ^{
                brodcast = [NSNumber numberWithInt:x].description;
                NSLog(@"reset brodcast to %@",brodcast);
//                sleep(x);
            });
            sleep(x);
            
            /*
             使用 barrier sync 把block添加到queue之后，该block会等到之前所有block全部执行完成后在执行。且阻塞后面添加的block直到该block执行完成。
             barrier sync只能使用在自己创建的异步队列上，如果使用在同步队列或者全局队列则相当于dispatch_sync
             因为dispatch_barrier_sync会阻塞其目标队列，因此在当前队列上执行dispatch_barrier_sync 会导致死锁
             因为dispatch_barrier_sync会阻塞当前队列，当其目标队列有大量Block未执行完毕时候会造成当前队列的等待。
             */
//            dispatch_barrier_sync(productQueue, ^{
//
//            });
        }
    });
}
@end
