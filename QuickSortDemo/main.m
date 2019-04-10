//
//  main.m
//  QuickSortDemo
//
//  Created by ZfRee on 2019/4/10.
//  Copyright © 2019年 ZfRee. All rights reserved.
//

#import <Foundation/Foundation.h>

//直接插入排序 结果为：从小到大
void insertSort(NSMutableArray *arrayM){
    
    NSInteger i, j, temp;
    
    for (i = 0; i < arrayM.count; i++) {
        temp = [arrayM[i] integerValue];
        
        for (j = i; j > 0 && [arrayM[j - 1] integerValue] > temp; j--) {
            arrayM[j] = arrayM[j - 1];
        }
        arrayM[j] = @(temp);
    }
}

//找出分割点
NSInteger partition(NSMutableArray *arrayM, NSInteger low, NSInteger high){
    
    {//优化1：三数取中法
        NSInteger mid = (low + high) / 2;
        if (arrayM[low] > arrayM[high]) {
            [arrayM exchangeObjectAtIndex:low withObjectAtIndex:high];
        }
        if (arrayM[mid] > arrayM[high]) {
            [arrayM exchangeObjectAtIndex:mid withObjectAtIndex:high];
        }
        //第二个if完成后 就找出了3个元素中最大的
        
        //把“认为合理的mid”放在low的位置
        if (arrayM[mid] > arrayM[low]) {
            [arrayM exchangeObjectAtIndex:mid withObjectAtIndex:low];
        }
    }
    
    NSInteger point = [arrayM[low] integerValue];//基准点
    
    while (low < high) {
        
        //不出while循环之前point不变
        while (low < high && [arrayM[high] integerValue] >= point) {
            high--;//右边跳过当前元素 不需要移动
        }
        arrayM[low] = arrayM[high];//优化2 不exchange直接赋值
        
        while (low < high && [arrayM[low] integerValue] <= point) {
            low++;//左边跳过当前元素 不需要移动
        }
        arrayM[high] = arrayM[low];//优化2 不exchange直接赋值
    }
    
    arrayM[low] = @(point);//优化2 基准点的值放到正确位置
    
    return low;
}

//快速排序（基本）
void quickSort(NSMutableArray *arrayM, NSInteger low, NSInteger high){
    
    NSInteger threshold = 5;//分水岭
    
    if (high - low > threshold) {
        NSInteger point = partition(arrayM, low, high);
        //分治递归
        quickSort(arrayM, 0, point - 1);
        quickSort(arrayM, point + 1, high);
    }
    else{
        insertSort(arrayM);//优化3 数据规模小使用直接插入排序
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSMutableArray *arrayM = @[@(5),@(2),@(6),@(0),@(3),@(9),@(1),@(7),@(4),@(8)].mutableCopy;
//        NSMutableArray *arrayM = @[@(88),@(22),@(66),@(0),@(33),@(99),@(11),@(77),@(44),@(88)].mutableCopy;
        
        quickSort(arrayM, 0, arrayM.count - 1);
        NSLog(@"排序后的结果为：%@",arrayM);
    }
    return 0;
}

