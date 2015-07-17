//
//  ViewController.m
//  StackView-iOS-Developers-Group
//
//  Created by Micah Baize on 7/13/15.
//  Copyright © 2015 Micah Baize. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

typedef NS_ENUM (NSInteger, SolarSystemEnum) {
    Sun,
    Mercury,
    Venus,
    Earth,
    Mars,
    Jupiter,
    Saturn,
    Uranus,
    Neptune
};

@property (weak, nonatomic) IBOutlet UILabel *currentSolarSystemObjectName;
@property (weak, nonatomic) IBOutlet UIImageView *currentSolarSystemObjectImage;
@property (weak, nonatomic) IBOutlet UIButton *previousSolarSystemObjectImage;
@property (weak, nonatomic) IBOutlet UILabel *previousSolarSystemObjectName;
@property (weak, nonatomic) IBOutlet UILabel *nextSolarSystemObjectName;
@property (weak, nonatomic) IBOutlet UIButton *nextSolarSystemObjectImage;

@property (nonatomic, strong) NSArray *solarSystemImageArray;
@property (nonatomic, strong) NSArray *solarSystemNameArray;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *practiceButton;

@property (nonatomic) SolarSystemEnum currentSolarSystemObject;


- (IBAction)openPracticeScreen:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
   
    self.solarSystemNameArray = @[@"Sun", @"Mercury", @"Venus", @"Earth", @"Mars", @"Jupiter", @"Saturn", @"Uranus", @"Neptune"];
    self.solarSystemImageArray = @[[UIImage imageNamed:@"Sun"], [UIImage imageNamed:@"Mercury"], [UIImage imageNamed:@"Venus"], [UIImage imageNamed:@"Earth"], [UIImage imageNamed:@"Mars"], [UIImage imageNamed:@"Jupiter"], [UIImage imageNamed:@"Saturn"], [UIImage imageNamed:@"Uranus"], [UIImage imageNamed:@"Neptune"]];
    
//    dispatch_async(dispatch_get_main_queue(), ^{
//        self.previousSolarSystemObjectName.alpha = 1;
//        self.previousSolarSystemObjectImage.alpha = 1;
//        self.nextSolarSystemObjectName.alpha = 1;
//        self.nextSolarSystemObjectImage.alpha = 1;
//        
//    });
    //Only predetermine the images/names on the first loading of the view
    
    
    if (!self.currentSolarSystemObject) {
        self.currentSolarSystemObject = Sun;
        self.previousSolarSystemObjectName.text = @"";
    }
    [self loadNamesAndImages];


    UITapGestureRecognizer *previousSolarObjectRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadPreviousSolarSystemObject)];
    [self.previousSolarSystemObjectName addGestureRecognizer:previousSolarObjectRecognizer];
    [self.previousSolarSystemObjectImage addGestureRecognizer:previousSolarObjectRecognizer];
    
    UITapGestureRecognizer *nextSolarObjectRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadNextSolarSystemObject)];
    [self.nextSolarSystemObjectName addGestureRecognizer:nextSolarObjectRecognizer];
    [self.nextSolarSystemObjectImage addGestureRecognizer:nextSolarObjectRecognizer];
    
    UITapGestureRecognizer *practiceScreenRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openPracticeScreen)];
    [self.currentSolarSystemObjectImage addGestureRecognizer:practiceScreenRecognizer];
    
    
    }

- (IBAction)openPracticeScreen {
    [self performSegueWithIdentifier:@"showPracticeScreen" sender:nil];
}

- (void)loadPreviousSolarSystemObject {
    --self.currentSolarSystemObject;
    [self loadNamesAndImages];
//    if (self.currentSolarSystemObject == Sun) {
//        [self hideUnnecessaryLabelsAndImageViews];
//    }
//    if (self.currentSolarSystemObject == Uranus) {
//        [self showNecessaryLabelsAndImageViews];
//    }
    
}

- (void)loadNextSolarSystemObject {
    ++self.currentSolarSystemObject;
    [self loadNamesAndImages];
//    if (self.currentSolarSystemObject == Neptune) {
//        [self hideUnnecessaryLabelsAndImageViews];
//    }
//    if (self.currentSolarSystemObject == Mercury) {
//        [self showNecessaryLabelsAndImageViews];
//    }
    
}

- (void)loadNamesAndImages {
    self.currentSolarSystemObjectName.text = self.solarSystemNameArray[(int)self.currentSolarSystemObject];
    self.currentSolarSystemObjectImage.image = self.solarSystemImageArray[(int)self.currentSolarSystemObject];
    if (self.currentSolarSystemObject != Sun) {
        self.previousSolarSystemObjectName.text = [NSString stringWithFormat:@"< %@", self.solarSystemNameArray[(int)self.currentSolarSystemObject - 1]];
        [self.previousSolarSystemObjectImage setImage:self.solarSystemImageArray[self.currentSolarSystemObject - 1] forState:UIControlStateNormal];// = self.solarSystemImageArray[(int)self.currentSolarSystemObject -1];
        [self.previousSolarSystemObjectImage setContentMode:UIViewContentModeScaleAspectFit];
    }
    if (self.currentSolarSystemObject != Neptune) {
        self.nextSolarSystemObjectName.text = [NSString stringWithFormat:@"%@ >", self.solarSystemNameArray[(int)self.currentSolarSystemObject + 1]];
        [self.nextSolarSystemObjectImage setImage:self.solarSystemImageArray[(int)self.currentSolarSystemObject + 1] forState: UIControlStateNormal];
        [self.nextSolarSystemObjectImage setContentMode:UIViewContentModeScaleAspectFit];
    }

    [self hideUnnecessaryLabelsAndImageViews];
    [self showNecessaryLabelsAndImageViews];
    

}

- (void) hideUnnecessaryLabelsAndImageViews {
    
    //Changes alpha and not hidden property, since the latter effectively removes it from the stackview, affecting the layout
        if (self.currentSolarSystemObject == Sun) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.previousSolarSystemObjectName.alpha = 0;
                self.previousSolarSystemObjectImage.alpha = 0;
//                self.nextSolarSystemObjectImage.alpha = 1;
//                self.nextSolarSystemObjectName.alpha = 1;
            });
        }
        else if (self.currentSolarSystemObject == Neptune) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.nextSolarSystemObjectName.alpha = 0;
                self.nextSolarSystemObjectImage.alpha = 0;
            });

        }
}


- (void) showNecessaryLabelsAndImageViews {

    if (self.currentSolarSystemObject == Mercury) {
        dispatch_async(dispatch_get_main_queue(), ^{

        self.previousSolarSystemObjectName.alpha = 1;
        self.previousSolarSystemObjectImage.alpha = 1;
        });

    }
    else if (self.currentSolarSystemObject == Uranus) {
        dispatch_async(dispatch_get_main_queue(), ^{

        self.nextSolarSystemObjectName.alpha = 1;
        self.nextSolarSystemObjectImage.alpha = 1;
        });

    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
