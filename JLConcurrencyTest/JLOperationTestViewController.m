//
//  JLOperationTestViewController.m
//  JLConcurrencyTest
//
//  Created by Julian Song on 17/2/4.
//
//

#import "JLOperationTestViewController.h"
#import "JLTestNonconcurrentOperation.h"
#import "JLTestConcurrentOperation.h"
@interface JLOperationTestViewController ()
@property(nonatomic,strong)UIButton *invocationOperationBtn;
@property(nonatomic,strong)UIButton *blockOperationBtn;
@property(nonatomic,strong)UIButton *dependencyOperationesBtn;
@property(nonatomic,strong)UIButton *nonconcurrentOperationesBtn;
@property(nonatomic,strong)UIButton *concurrentOperationesBtn;
@end

@implementation JLOperationTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.invocationOperationBtn = [[UIButton alloc] init];
    [self.invocationOperationBtn setTitle:@"Invocation operation" forState:UIControlStateNormal];
    self.invocationOperationBtn.backgroundColor = self.view.tintColor;
    self.invocationOperationBtn.layer.cornerRadius = 4;
    [self.invocationOperationBtn addTarget:self action:@selector(invocationOperation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.invocationOperationBtn];
    
    self.blockOperationBtn = [[UIButton alloc] init];
    [self.blockOperationBtn setTitle:@"Block operation" forState:UIControlStateNormal];
    self.blockOperationBtn.backgroundColor = self.view.tintColor;
    self.blockOperationBtn.layer.cornerRadius = 4;
    [self.blockOperationBtn addTarget:self action:@selector(blockOperation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.blockOperationBtn];
    
    self.dependencyOperationesBtn = [[UIButton alloc] init];
    [self.dependencyOperationesBtn setTitle:@"Dependency operationes" forState:UIControlStateNormal];
    self.dependencyOperationesBtn.backgroundColor = self.view.tintColor;
    self.dependencyOperationesBtn.layer.cornerRadius = 4;
    [self.dependencyOperationesBtn addTarget:self action:@selector(dependencyOperationes) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dependencyOperationesBtn];
    
    self.nonconcurrentOperationesBtn = [[UIButton alloc] init];
    [self.nonconcurrentOperationesBtn setTitle:@"Nonconcurrent operation" forState:UIControlStateNormal];
    self.nonconcurrentOperationesBtn.backgroundColor = self.view.tintColor;
    self.nonconcurrentOperationesBtn.layer.cornerRadius = 4;
    [self.nonconcurrentOperationesBtn addTarget:self action:@selector(nonconcurrentOperationes) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.nonconcurrentOperationesBtn];
    
    self.concurrentOperationesBtn = [[UIButton alloc] init];
    [self.concurrentOperationesBtn setTitle:@"Concurrent operationes" forState:UIControlStateNormal];
    self.concurrentOperationesBtn.backgroundColor = self.view.tintColor;
    self.concurrentOperationesBtn.layer.cornerRadius = 4;
    [self.concurrentOperationesBtn addTarget:self action:@selector(concurrentOperationes) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.concurrentOperationesBtn];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.invocationOperationBtn.frame = CGRectMake(10,74,CGRectGetWidth(self.view.bounds) - 20,40);
    self.blockOperationBtn.frame = CGRectMake(10,124,CGRectGetWidth(self.view.bounds) - 20,40);
    self.dependencyOperationesBtn.frame = CGRectMake(10,174,CGRectGetWidth(self.view.bounds) - 20,40);
    self.nonconcurrentOperationesBtn.frame = CGRectMake(10,224,CGRectGetWidth(self.view.bounds) - 20,40);
    
    self.concurrentOperationesBtn.frame = CGRectMake(10,274,CGRectGetWidth(self.view.bounds) - 20,40);
}

- (void)task
{
    NSLog(@"invocationOpt");
}

- (void)invocationOperation
{
    /*
     非异步操作
     */
    NSInvocationOperation * invocationOpt = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task) object:nil];
    [invocationOpt setCompletionBlock:^{
        NSLog(@"invocationOpt was done");
    }];
    [invocationOpt start];
}

- (void)blockOperation
{
    /*
     异步操作，不通的block可能会被分配到不通的线程执行，所有block都执行完毕后该NSBlockOperation被标记为执行完毕
     */
    NSBlockOperation *blockOpt = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOpt 1");
        NSLog(@"current tread %@",[NSThread currentThread]);
        sleep(2);
    }];
    [blockOpt addExecutionBlock:^{
        NSLog(@"blockOpt 2");
        NSLog(@"current tread %@",[NSThread currentThread]);
    }];
    [blockOpt setCompletionBlock:^{
        NSLog(@"blockOpt was done");
        NSLog(@"current tread %@",[NSThread currentThread]);
    }];
    [blockOpt start];
}

- (void)dependencyOperationes
{
    /**
     相较于GCD队列OperationQueue可以更方便的指定队列中同时执行的最大任务数量，及指定队列中任务的依赖关系。
     */
    NSOperationQueue *aqueue = [[NSOperationQueue alloc] init];
    NSOperationQueue *bqueue = [[NSOperationQueue alloc] init];
//    queue.maxConcurrentOperationCount = 5;
    NSBlockOperation *blockOpt1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOpt in queue 1");
        NSLog(@"current tread %@",[NSThread currentThread]);
        sleep(2);
    }];
    [blockOpt1 addExecutionBlock:^{
        NSLog(@"blockOpt in queue 2");
        NSLog(@"current tread %@",[NSThread currentThread]);
        sleep(2);
    }];
    
    NSBlockOperation *blockOpt2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOpt in queue 3");
        NSLog(@"current tread %@",[NSThread currentThread]);
    }];
    NSBlockOperation *blockOpt3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOpt in queue 4");
        NSLog(@"current tread %@",[NSThread currentThread]);
    }];
    
    /**
     操作的依赖通过依赖者对被依赖者相关属性的KVO来实现
     */
    [blockOpt3 addDependency:blockOpt1];
    [blockOpt3 addDependency:blockOpt2];
    
    
//    [blockOpt1 start];
//    [blockOpt2 start];
//    [blockOpt3 start];
    
    [aqueue addOperation:blockOpt3];
    [aqueue addOperation:blockOpt2];
    [bqueue addOperation:blockOpt1];
    
}

- (void)nonconcurrentOperationes
{
    /**
     opreation 直接通过 start 执行的时候将会在当前线程同步执行，如果添加到queue中则会异步执行，
     */
    JLTestNonconcurrentOperation *tnOpt = [[JLTestNonconcurrentOperation alloc] init];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:tnOpt];
    [tnOpt start];
}

- (void)concurrentOperationes
{
    /**
     自定义的opreation 直接通过 start 触发并想异步执行的话需要自行实现start方法
     并在start方法中新建线程对main方法进行调用。
     */
    JLTestConcurrentOperation *tnOpt = [[JLTestConcurrentOperation alloc] init];
    [tnOpt start];
}
@end
