//
//  JLGCDSourceTestViewController.m
//  JLConcurrencyTest
//
//  Created by Julian Song on 17/1/23.
//
//

#import "JLGCDSourceTestViewController.h"

@interface JLGCDSourceTestViewController ()
@property(nonatomic,strong)UIButton *dispatchSourcesAddBtn;
@property(nonatomic,strong)UIButton *dispatchSourcesOrBtn;
@property(nonatomic,strong)UIButton *dispatchTimeerSourcBtn;
@property(nonatomic,strong)UIButton *dispatchSignalSourceBtn;

@end

@implementation JLGCDSourceTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dispatchSourcesAddBtn = [[UIButton alloc] init];
    [self.dispatchSourcesAddBtn setTitle:@"Dispatch source data add" forState:UIControlStateNormal];
    
    self.dispatchSourcesAddBtn.backgroundColor = self.view.tintColor;
    self.dispatchSourcesAddBtn.layer.cornerRadius = 4;
    [self.dispatchSourcesAddBtn addTarget:self action:@selector(dispatchSourcesAdd) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dispatchSourcesAddBtn];
    
    self.dispatchSourcesOrBtn = [[UIButton alloc] init];
    [self.dispatchSourcesOrBtn setTitle:@"Dispatch source data or" forState:UIControlStateNormal];
    self.dispatchSourcesOrBtn.backgroundColor = self.view.tintColor;
    self.dispatchSourcesOrBtn.layer.cornerRadius = 4;
    [self.dispatchSourcesOrBtn addTarget:self action:@selector(dispatchSourcesOr) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dispatchSourcesOrBtn];
    
    self.dispatchTimeerSourcBtn = [[UIButton alloc] init];
    [self.dispatchTimeerSourcBtn setTitle:@"Dispatch timer source" forState:UIControlStateNormal];
    self.dispatchTimeerSourcBtn.backgroundColor = self.view.tintColor;
    self.dispatchTimeerSourcBtn.layer.cornerRadius = 4;
    [self.dispatchTimeerSourcBtn addTarget:self action:@selector(dispatchTimerSource) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dispatchTimeerSourcBtn];
    
    self.dispatchSignalSourceBtn = [[UIButton alloc] init];
    [self.dispatchSignalSourceBtn setTitle:@"Dispatch signal source" forState:UIControlStateNormal];
    self.dispatchSignalSourceBtn.backgroundColor = self.view.tintColor;
    self.dispatchSignalSourceBtn.layer.cornerRadius = 4;
    [self.dispatchSignalSourceBtn addTarget:self action:@selector(dispatchSignalSource) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.dispatchSignalSourceBtn];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.dispatchSourcesAddBtn.frame = CGRectMake(10,74,CGRectGetWidth(self.view.bounds) - 20,40);
    self.dispatchSourcesOrBtn.frame = CGRectMake(10,124,CGRectGetWidth(self.view.bounds) - 20,40);
    self.dispatchTimeerSourcBtn.frame = CGRectMake(10,174,CGRectGetWidth(self.view.bounds) - 20,40);
    self.dispatchSignalSourceBtn.frame = CGRectMake(10,224,CGRectGetWidth(self.view.bounds) - 20,40);
}

- (void)dispatchSourcesAdd
{
    dispatch_queue_t  myQueue = dispatch_queue_create("com.my.dispatchSourcesAdd",NULL);
    
    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_ADD,
                                                      0, 0, myQueue);
    dispatch_source_set_event_handler(source, ^{
        long value = dispatch_source_get_data(source);
        long mask = dispatch_source_get_mask(source);
        uintptr_t handle = dispatch_source_get_handle(source);
        NSLog(@"value is %ld",value);
        NSLog(@"mask is %ld",mask);
    });
    
    
    dispatch_resume(source);
    dispatch_source_merge_data(source, 1);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        //sleep(2);
        dispatch_source_merge_data(source, 2);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        //sleep(5);
        dispatch_source_merge_data(source, 3);
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        //sleep(5);
        dispatch_source_merge_data(source, 4);
    });
    
}

- (void)dispatchSourcesOr
{
    dispatch_queue_t  myQueue = dispatch_queue_create("com.my.dispatchSourcesOr",NULL);

    dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_DATA_OR,
                                                      0, 0, myQueue);
    dispatch_source_set_event_handler(source, ^{
        long value = dispatch_source_get_data(source);
        long mask = dispatch_source_get_mask(source);
        uintptr_t handle = dispatch_source_get_handle(source);
        NSLog(@"value is %ld",value);
        NSLog(@"mask is %ld",mask);
    });
    

    dispatch_resume(source);
    dispatch_source_merge_data(source, 1);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        //sleep(2);
        dispatch_source_merge_data(source, 2);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        //sleep(5);
        dispatch_source_merge_data(source, 3);
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        //sleep(5);
        dispatch_source_merge_data(source, 4);
    });
    
}

- (void)dispatchTimerSource
{
    dispatch_queue_t  myQueue = dispatch_queue_create("com.my.dispatchTimerSource",NULL);
    
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,
                                                      0, 0, myQueue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL,0),5ull * NSEC_PER_SEC,5);
    
    dispatch_source_set_cancel_handler(timer, ^{
        NSLog(@"timer was cancel");
    });
    
    dispatch_source_set_event_handler(timer, ^{
        long value = dispatch_source_get_data(timer);
        long mask = dispatch_source_get_mask(timer);
        NSLog(@"value is %ld",value);
        NSLog(@"mask is %ld",mask);
    });
    
    dispatch_resume(timer);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_source_cancel(timer);
    });
}

- (void)dispatchSignalSource
{
    //点击按钮后
    dispatch_queue_t  myQueue = /* dispatch_get_main_queue(); */ dispatch_queue_create("com.my.dispatchSignalSource",NULL);
    
    dispatch_source_t signalSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_SIGNAL,
                                                     SIGSTOP, 0, myQueue);
    if (signalSource) {
        dispatch_source_set_event_handler(signalSource, ^{
            long value = dispatch_source_get_data(signalSource);
            long mask = dispatch_source_get_mask(signalSource);
            NSLog(@"value is %ld",value);
            NSLog(@"mask is %ld",mask);
        });
        
        dispatch_resume(signalSource);
    }
}
@end
