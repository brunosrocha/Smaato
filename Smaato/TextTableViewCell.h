//
//  TextTableViewCell.h
//  Smaato
//
//  Created by Bruno Rocha on 2/23/16.
//  Copyright © 2016 Bruno. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *userLabel;
@property (nonatomic, weak) IBOutlet UILabel *descriptionLabel;

@end
