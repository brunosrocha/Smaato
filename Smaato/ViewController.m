//
//  ViewController.m
//  Smaato
//
//  Created by Bruno Rocha on 2/17/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

#import "ViewController.h"
#import "SMTNetwork.h"
#import "Object.h"
#import "NSArray+RandomObject.h"
#import "UIImageView+URLImage.h"
#import "Helper.h"

@interface ViewController () <UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *image;
@property (nonatomic, weak) IBOutlet UILabel *text;
@property (nonatomic, weak) IBOutlet UILabel *dateCreated;
@property (nonatomic, weak) IBOutlet UILabel *userInformation;
@property (strong) Object *object;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self sortTouchedUp];
    
}

#pragma mark -
#pragma mark - IBAction Methods

- (IBAction)sortTouchedUp {
    
    NSString *url = @"http://private-d847e-demoresponse.apiary-mock.com/questions";
    
    void (^resultBlock)() = ^() {
        
        if (_object.isContentValid) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
            
                if ([_object.type isEqualToString: @"img"]) {
                    
                    [_image loadFromURL: [NSURL URLWithString: _object.data.url]  response:^(UIImage *image) {
                        
                        [_image setImage: image];
                        
                    }];
                    
                    _image.hidden = NO;
                    _text.hidden = YES;
                    
                } else {
                    
                    _image.hidden = YES;
                    _text.hidden = NO;
                    _text.text = _object.data.text;
                }
                
                _userInformation.text = [NSString stringWithFormat: @"Name: %@ , Country: %@",
                                         _object.user.name, _object.user.country];
                
                _dateCreated.text = [Helper timeFromSeconds: _object.created withFormat: @"dd-MM-yyyy 'at' HH:mm"];
                
            });
            
        } else {
            [self error];
        }
        
    };
    
    [[SMTNetwork instance] requestWithURL: url method: GET parameters: nil success:^(NSArray *data, NSURLResponse *response) {
        
        NSMutableArray *mArray = [NSMutableArray array];
        
        if (data.count) {
            
            for (NSDictionary *dictionary in data) {
                Object *object = [[Object alloc] initWithDictionary: dictionary];
                [mArray addObject: object];
            }
            
            Object *object = [mArray randomObject];
            
            self.object = object;
            
            resultBlock();
            
        } else {
            
            [self error];
        }
        
        
    } failure:^(NSError *error) {
        [self error];
    }];
    
}

- (IBAction)favoriteButtonTouchedUp {
    
    
}

#pragma mark -
#pragma mark - Error Handling

- (void)error {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[[UIAlertView alloc] initWithTitle: @"Message" message: @"Something went wrong please try again!" delegate: self cancelButtonTitle: @"OK" otherButtonTitles: @"Try!", nil] show];
    });
}

#pragma mark -
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        [self sortTouchedUp];
    }
}


@end
