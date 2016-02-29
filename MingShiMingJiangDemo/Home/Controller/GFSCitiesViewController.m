//
//  GFSCitiesViewController.m
//  MingShiMingJiangDemo
//
//  Created by 管复生 on 16/2/29.
//  Copyright © 2016年 GFS. All rights reserved.
//

#import "GFSCitiesViewController.h"
#import "GFSCity.h"
@interface GFSCitiesViewController()
/**
 *  所有城市
 */
@property(nonatomic,strong)NSMutableArray *cities;
/**
 *  所有城市拼音分组
 */
@property(nonatomic,strong)NSMutableArray *cityPinyinSort;
/**
 *  所有城市与首字母的键值对
 */
@property(nonatomic,strong)NSMutableDictionary *cityDicts;
@end
@implementation GFSCitiesViewController

#pragma mark- lifeCycle
- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
}
#pragma mark TableViewDataSource and Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cityPinyinSort.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.cityDicts objectForKey:_cityPinyinSort[section]]count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = [indexPath section];
    NSUInteger row = [indexPath row];
    
    static NSString *GroupedTableIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             GroupedTableIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:GroupedTableIdentifier];
    }
    
    NSMutableArray *array=[_cityDicts objectForKey:[_cityPinyinSort objectAtIndex:section]];
    
    //给Label附上城市名称  key 为：C_Name
    cell.textLabel.text = [array objectAtIndex:row];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0];
    
    return cell;

}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    // 组标题
//    NSString *header = _cityPinyinSort[section];
//    return header.uppercaseString;
    return _cityPinyinSort[section];
}
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //返回省份的数组
    
    return _cityPinyinSort;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

#pragma mark- setter and getter
- (NSMutableArray *)cities
{
    if (!_cities) {
        // 从plist加载
        NSArray *cityStrArray = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"citiesArray" ofType:@"plist"]];
        
        NSMutableArray *cityArray = [NSMutableArray array];
        for (NSString *cityStr in cityStrArray) {
            
            GFSCity *city = [GFSCity city];
            city.name = cityStr;
            
            [cityArray addObject:city];
        }
        _cities = cityArray;
    }
    return _cities;
}
- (NSMutableArray *)cityPinyinSort
{
    if (!_cityPinyinSort) {
        // 用来储存对应分组的字典
        NSMutableDictionary *cityDic=[[NSMutableDictionary alloc]init];
        NSMutableArray *arr = nil;
        NSString *pinyin = nil;
        for (GFSCity *city in self.cities) {
            
            pinyin = [city.pinyin substringToIndex:1];;
            //如果包含key
            if([[cityDic allKeys]containsObject:pinyin]){
                // 取出对应数组
                arr=[cityDic objectForKey:pinyin];
                // 添加符合的city
                [arr addObject:city.name];
                // 更新
                [cityDic setObject:arr forKey:pinyin];
                
            }else{
                
                arr= [[NSMutableArray alloc]initWithObjects:city.name, nil];
                [cityDic setObject:arr forKey:pinyin];
                
            }
        }
        // 赋值
        self.cityDicts = cityDic;
        // 根据字母取出分组
        NSMutableArray *array = [NSMutableArray array];
        _cityPinyinSort = [array arrayByAddingObjectsFromArray:[[cityDic allKeys] sortedArrayUsingSelector:@selector(compare:)]];;
    }
    return _cityPinyinSort;
}
@end
