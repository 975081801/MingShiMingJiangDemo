//
//  GFSHomeCollectionViewController.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/2/29.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSHomeCollectionViewController.h"
#import "GFSButton.h"
#import "GFSCitiesViewController.h"
@interface GFSHomeCollectionViewController ()<UISearchBarDelegate>
@property(nonatomic,weak)UISearchBar *centerSearcher;
@end

@implementation GFSHomeCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏按钮
    [self setupNavBarButton];
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    self.view.backgroundColor = [UIColor grayColor];
}
/**
 *  设置导航栏按钮
 */
- (void)setupNavBarButton
{
    // 左边按钮(自定义)
    GFSButton *leftButton = [[GFSButton alloc]init];
    leftButton.frame = CGRectMake(0, 0, 40, 40);
//    leftButton.backgroundColor = [UIColor grayColor];
    [leftButton setTitle:@"广州" forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    // 中间搜索
    UISearchBar *centerSearcher = [[UISearchBar alloc]init];
    // 图标
    centerSearcher.placeholder = @"搜索你想要的";
    centerSearcher.contentMode = UIViewContentModeLeft;
    // 位置和尺寸
    centerSearcher.frame = CGRectMake(0, 0, 80, 40);
    
    self.navigationItem.titleView = centerSearcher;
    self.centerSearcher = centerSearcher;
    
}
/**
 *  定位地址点击事件
 *
 *  @param button 按钮
 */
- (void)leftButtonClicked:(GFSButton *)button
{
    UIViewController *cities = [[GFSCitiesViewController alloc]init];
    
    [self.navigationController pushViewController:cities animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UISearchBarDelegate
/** 搜索框结束编辑（退出键盘） */
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    // 如果正在dissmis，就不要执行后面代码
    if (self.isBeingDismissed) return;
    
    // 更换背景
//    searchBar.backgroundImage = [UIImage imageNamed:@""];
    // 隐藏取消按钮
    [searchBar setShowsCancelButton:NO animated:YES];
    
    // 清空文字
    searchBar.text = nil;
    // 移除搜索结果界面
//    [self.SearchVc.view removeFromSuperview];
}

/** 搜索框开始编辑（弹出键盘） */
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    // 更换背景
//    searchBar.backgroundImage = [UIImage imageNamed:@""];
    // 显示取消按钮
    [searchBar setShowsCancelButton:YES animated:YES];
    
}

/** 点击了取消 */
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar endEditing:YES];
}

/** 搜索框的文字发生改变的时候调用 */
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    // 弹出搜索界面
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
