//
//  MenuViewController.m
//  SampleAssetsLibrary
//
//  Created by yasuhisa.arakawa on 2015/01/21.
//  Copyright (c) 2015年 Classmethod, Inc. All rights reserved.
//

#import "MenuViewController.h"
#import "AssetsLibraryCollectionViewController.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface MenuViewController ()

@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSMutableArray *assets;

@end

@implementation MenuViewController

#pragma mark - Lifecycle methods

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Segue method

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"AssetsLibrary"]) {
        AssetsLibraryCollectionViewController *assetsLibraryView = segue.destinationViewController;
        assetsLibraryView.assets = self.assets;
    }
}

#pragma mark - IBAction method

- (IBAction)tapOpenLibraryButton:(id)sender
{
    // ボタンがタップされたらアセットライブラリを先にロードしておきます。
    [self loadAssetsLibrary];
}

#pragma mark - Private method

- (void)loadAssetsLibrary
{
    ALAuthorizationStatus authorizationStatus = [ALAssetsLibrary authorizationStatus];
    
    if (authorizationStatus == ALAuthorizationStatusNotDetermined ||
        authorizationStatus == ALAuthorizationStatusAuthorized) {
        // 読み込みが許可されているか読み込み許可待ちの状態
        self.assetsLibrary = [ALAssetsLibrary new];
        self.assets = [NSMutableArray array];
        
        [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
            // 各グループから全件取得します。
            if (group) {
                // 画像のみに絞り込みます。
                [group setAssetsFilter:[ALAssetsFilter allPhotos]];
                
                [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
                    if (result) {
                        [self.assets addObject:result];
                    } else {
                        // アセットライブラリのロードが完了したので一覧画面へ遷移します。
                        [self performSegueWithIdentifier:@"AssetsLibrary" sender:self];
                    }
                }];
            }
        } failureBlock:^(NSError *error) {
            NSLog(@"アセットライブラリの読み込みに失敗しました。%@", error);
        }];
    } else {
        NSLog(@"ライブラリへのアクセスが拒否されています。設定アプリから許可して下さい。");
    }
}

@end
