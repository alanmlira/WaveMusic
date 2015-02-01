//
//  AMLTableNowViewController.h
//  BrainMusic
//
//  Created by Alan Magalhães Lira on 18/08/13.
//  Copyright (c) 2013 Alan M. Lira. All rights reserved.
//

#import <UIKit/UIKit.h>


@class ALPlayerViewController;

@interface AMLTableNowViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>
{
    IBOutlet UITableView *tableMusicas; //Tabela
    NSString *titulo;
    
}

@property (strong, nonatomic) ALPlayerViewController *playerMusic;
@property (strong, nonatomic) IBOutlet UITableView *tableMusicas;
@property (strong, nonatomic) NSString *titulo;

- (id)initWithPlayerMusic:(ALPlayerViewController *)player andTitle:(NSString *)titulo;

@end