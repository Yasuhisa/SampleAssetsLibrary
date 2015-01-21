//
//  AssetDetailViewController.m
//  SampleAssetsLibrary
//
//  Created by yasuhisa.arakawa on 2015/01/21.
//  Copyright (c) 2015年 Classmethod, Inc. All rights reserved.
//

#import "AssetDetailViewController.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface AssetDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *assetImage;

@end

@implementation AssetDetailViewController

#pragma mark - Lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ALAssetRepresentation *representation = [self.selectedAsset defaultRepresentation];
    
    // アセットライブラリから復元した画像は Orientation が予期しないものになっていることがあるので、明示的に指定します。
    UIImage *image = [UIImage imageWithCGImage:[representation fullScreenImage]
                                         scale:[representation scale]
                                   orientation:(UIImageOrientation)ALAssetOrientationUp];
    self.assetImage.image = image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
