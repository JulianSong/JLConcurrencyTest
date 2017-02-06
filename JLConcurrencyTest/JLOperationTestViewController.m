//
//  JLOperationTestViewController.m
//  JLConcurrencyTest
//
//  Created by Julian Song on 17/2/4.
//
//

#import "JLOperationTestViewController.h"

@interface JLOperationTestViewController ()
@property(nonatomic,strong)UIButton *invocationOperationBtn;
@property(nonatomic,strong)UIButton *blockOperationBtn;
@property(nonatomic,strong)UIButton *dependencyOperationesBtn;
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
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.invocationOperationBtn.frame = CGRectMake(10,74,CGRectGetWidth(self.view.bounds) - 20,40);
    self.blockOperationBtn.frame = CGRectMake(10,124,CGRectGetWidth(self.view.bounds) - 20,40);
    self.dependencyOperationesBtn.frame = CGRectMake(10,174,CGRectGetWidth(self.view.bounds) - 20,40);
//    self.dispatchSignalSourceBtn.frame = CGRectMake(10,224,CGRectGetWidth(self.view.bounds) - 20,40);
    
//    self.dispatchProcessSourceBtn.frame = CGRectMake(10,224,CGRectGetWidth(self.view.bounds) - 20,40);
}

- (void)task
{
    NSLog(@"invocationOpt");
}

- (void)invocationOperation
{
    NSInvocationOperation * invocationOpt = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(task) object:nil];
    [invocationOpt setCompletionBlock:^{
        NSLog(@"invocationOpt was done");
    }];
    [invocationOpt start];
}

- (void)blockOperation
{
    NSBlockOperation *blockOpt = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOpt 1");
        sleep(2);
    }];
    [blockOpt addExecutionBlock:^{
        NSLog(@"blockOpt 2");
    }];
    [blockOpt setCompletionBlock:^{
        NSLog(@"blockOpt was done");
    }];
    [blockOpt start];
}

- (void)dependencyOperationes
{
    NSBlockOperation *blockOpt1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOpt1");
        sleep(2);
        
    }];

    NSBlockOperation *blockOpt2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOpt2");
        sleep(2);
    }];
    NSBlockOperation *blockOpt3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOpt3");
    }];
    
    [blockOpt3 addDependency:blockOpt1];
    [blockOpt3 addDependency:blockOpt2];
    
    [blockOpt1 start];
    [blockOpt2 start];
    [blockOpt3 start];
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
