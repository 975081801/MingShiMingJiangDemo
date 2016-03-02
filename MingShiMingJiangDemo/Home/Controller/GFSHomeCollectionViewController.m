//
//  GFSHomeCollectionViewController.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/2/29.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSHomeCollectionViewController.h"
#import "GFSCitiesViewController.h"
#import "GFSHomeCollectionViewCell.h"
#import "GFSCollectionReusableView.h"
@interface GFSHomeCollectionViewController ()<UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,weak)UISearchBar *centerSearcher;

@property(nonatomic,copy)NSString *cityButtonTitle;

@property(nonatomic,strong)NSArray *imageArray;
@property(nonatomic,strong)GFSCollectionReusableView *headerView;
@end

@implementation GFSHomeCollectionViewController

static NSString * const ID = @"bottomcell";
#pragma mark- 初始化和懒加载

- (NSArray *)imageArray
{
    if (!_imageArray) {
        NSMutableArray *array = [NSMutableArray array];
        if (iPhone6Plus) {
            // 加载@3x图
            for (int i = 20; i< 57; i++) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"960_%d",i]];
                // 由于序号不连续  判断是否有图片
                if (image) {// 有图片
                    [array addObject:image];
                }
            }
        }else{
            
            // 加载@2x图
            for (int i = 17; i< 57; i++) {
                UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"640_%d",i]];
                if (image) {// 有图片
                    [array addObject:image];
                }
            }
        }
        _imageArray = array;
    }
    return _imageArray;
}
/**
 *  初始化
 *
 */
- (instancetype)init
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // cell的尺寸
    CGFloat itemW = [UIScreen mainScreen].bounds.size.width * 0.246;
    CGFloat itemH = itemW * 184 / 239  ;
    
    layout.itemSize = CGSizeMake(itemW , itemH);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 2;
    GFSCollectionReusableView *headerView = [[GFSCollectionReusableView alloc]init];
    self.headerView = headerView;
    
//    CGFloat headerViewH = [UIScreen mainScreen].bounds.size.height - 5*itemH - 120;
    layout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, self.headerView.height);
    //是否固定表头
//    layout.sectionHeadersPinToVisibleBounds = YES;
    // 设置cell与CollectionView边缘的间距
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);

    return [super initWithCollectionViewLayout:layout];
}
#pragma mark- lifeCycle
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    // 删除原有的 解决闪现出其他标题
    self.navigationController.navigationItem.titleView = nil;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏按钮
    [self setupNavBarButton];
    
    [self setupBaseView];
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

#pragma mark <UICollectionViewDataSource><UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
//    GFSLog(@"---tupian%ld",self.imageArray.count);
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GFSHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"bottomcell" forIndexPath:indexPath];
    
    cell.image = self.imageArray[indexPath.row];
    
    return cell;
}
/**
 *  添加headerView
 *
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
        GFSCollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reuse" forIndexPath:indexPath ];
    
    return headerView;
}
#pragma mark- setterAndGetter
/**
*  初始化地址
*/
- (NSString *)cityButtonTitle
{
    // 取出当前标题
    _cityButtonTitle = GFSShowCityBtn.currentTitle;
    
    if (!_cityButtonTitle) {
        // 如果没有  设置默认标题
        _cityButtonTitle = @"广州";
    }
    return _cityButtonTitle;
}

#pragma mark- pravitMethods
/**
 *  设置控制器view属性
 */
- (void)setupBaseView
{
    // 垂直方向上永远有弹簧效果
    self.collectionView.alwaysBounceVertical = YES;
    
//    self.collectionView.bounces = NO;
    self.collectionView.backgroundColor = [UIColor grayColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"GFSHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"bottomcell"];
    
    [self.collectionView registerClass:[GFSCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reuse"];
}
/**
 *  设置导航栏按钮
 */
- (void)setupNavBarButton
{
    // 左边按钮(自定义)
    UIButton *leftButton = GFSShowCityBtn;
    
    //    leftButton.backgroundColor = [UIColor grayColor];
    [leftButton setTitle:self.cityButtonTitle forState:UIControlStateNormal];
    leftButton.titleLabel.font = GFSCityFont;
    //    leftButton.contentEdgeInsets = UIEdgeInsetsMake(2, 4, 2, 0);
    [leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    CGSize btnSize = [self.cityButtonTitle sizeWithAttributes:[NSDictionary dictionaryWithObject:GFSCityFont forKey:NSFontAttributeName]];
    leftButton.frame = CGRectMake(0, 0, btnSize.width, 40);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftButton];
    
    
    // 中间搜索
    UISearchBar *centerSearcher = [[UISearchBar alloc]init];
    // 图标
    centerSearcher.placeholder = @"搜索你想要的";
    centerSearcher.contentMode = UIViewContentModeLeft;
    // 位置和尺寸
    centerSearcher.frame = CGRectMake(0, 0, 60, 40);
    
    self.navigationItem.titleView = centerSearcher;
    self.centerSearcher = centerSearcher;
    
}
/**
 *  定位地址点击事件
 *
 *  @param button 按钮
 */
- (void)leftButtonClicked:(GFSShowCityButton *)button
{
    UIViewController *cities = [[GFSCitiesViewController alloc]init];
    
    [self.navigationController pushViewController:cities animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
