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
#import "CoreDataManager.h"
#import "FavoritesTableViewController.h"

@interface ViewController () <UIAlertViewDelegate>

@property (nonatomic, weak) IBOutlet UIImageView *image;
@property (nonatomic, weak) IBOutlet UILabel *text;
@property (nonatomic, weak) IBOutlet UILabel *dateCreated;
@property (nonatomic, weak) IBOutlet UILabel *userInformation;
@property (nonatomic, weak) IBOutlet UIButton *sortButton;
@property (nonatomic, weak) IBOutlet UIButton *favoriteButton;
@property (nonatomic, weak) IBOutlet UIButton *listButton;
@property (nonatomic, weak) IBOutlet UIButton *deleteButton;
@property (strong) Object *object;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.smaatoContent) {
        
        _sortButton.hidden = _favoriteButton.hidden = _listButton.hidden = YES;
        
        if ([_smaatoContent.type isEqualToString: @"img"]) {
            
            [self layoutWithImage: [UIImage imageWithData: _smaatoContent.image] userInfo: [NSString stringWithFormat: @"Name: %@ , Country: %@",
                                                                                            _smaatoContent.name, _smaatoContent.country] creadted: [_smaatoContent.created intValue]];
            
        } else {
            
            [self layoutWithText: _smaatoContent.text userInfo: [NSString stringWithFormat: @"Name: %@ , Country: %@",
                                                                 _smaatoContent.name, _smaatoContent.country] crated: [_smaatoContent.created intValue]];
        }
        
        
    } else {
        
        _deleteButton.hidden = YES;
        
        [self sortTouchedUp];
        
    }
}


#pragma mark - 
#pragma mark - Layout

- (void)layoutWithText:(NSString *)text userInfo:(NSString *)userInfo crated:(NSTimeInterval)created {
    
    _image.hidden = YES;
    _text.hidden = NO;
    _text.text = text;
    
    [self layoutUserInfo: userInfo created: created];
}

- (void)layoutWithImage:(UIImage *)image userInfo:(NSString *)userInfo creadted:(NSTimeInterval)created {
    
    [_image setImage: image];
    _image.hidden = NO;
    _text.hidden = YES;
    [self layoutUserInfo: userInfo created: created];
    
    
}

- (void)layoutUserInfo:(NSString *)userInfo created:(NSTimeInterval)created {
    
    _userInformation.text = userInfo;
    _dateCreated.text = [Helper timeFromSeconds: created withFormat: @"dd-MM-yyyy 'at' HH:mm"];
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
                        
                        [self layoutWithImage: image userInfo: [NSString stringWithFormat: @"Name: %@ , Country: %@",
                                                                _object.user.name, _object.user.country] creadted:_object.created];
                        
                    }];
                    
                } else {
                    
                    [self layoutWithText: _object.data.text userInfo: [NSString stringWithFormat: @"Name: %@ , Country: %@",
                                                                       _object.user.name, _object.user.country]crated: _object.created];
                }
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
    
    if ([[CoreDataManager manager] saveObject: self.object withImage: UIImagePNGRepresentation(_image.image)]) {
     
        [[[UIAlertView alloc] initWithTitle: @"Message"
                                    message: @"Object saved with success!"
                                   delegate: nil cancelButtonTitle: @"OK"
                          otherButtonTitles: nil] show];
    } else {
        [[[UIAlertView alloc] initWithTitle: @"Message"
                                    message: @"Something weird happened please try again!"
                                   delegate: nil cancelButtonTitle: @"OK"
                          otherButtonTitles: nil] show];

    }
}

- (IBAction)deleteFavorite {
    
    
    if ([[CoreDataManager manager] deleteObject: _smaatoContent.created]) {
        
        [[[UIAlertView alloc] initWithTitle: @"Message"
                                    message: @"Favorite removed with success!"
                                   delegate: self cancelButtonTitle: @"OK"
                          otherButtonTitles: nil] show];

    } else {
        
        [[[UIAlertView alloc] initWithTitle: @"Message"
                                    message: @"Something weird happened please try again!"
                                   delegate: nil cancelButtonTitle: @"OK"
                          otherButtonTitles: nil] show];

    }
    
}

#pragma mark -
#pragma mark - Error Handling

- (void)error {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
       UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Message"
                                                           message: @"Something went wrong please try again!"
                                                          delegate: self
                                                 cancelButtonTitle:
                                 @"OK" otherButtonTitles: @"Try!", nil];
        
        alertView.tag = 10;
        
        [alertView show];
    });
}

#pragma mark -
#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1 && alertView.tag == 10) {
        [self sortTouchedUp];
    } else {
        [self.navigationController popViewControllerAnimated: YES];
    }
}

@end
