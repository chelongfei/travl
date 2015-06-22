//
//  ViewController.m
//  TextKitDemo
//
//  Created by qianfeng on 15-5-28.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

//TextKit 是苹果在ios7推出的文本布局系统，是建立在CoreText之上的，对CoreText进行了面向对象的封装
//目的是让大家更容易的使用CoreText

#import "ViewController.h"

//textKit底层使用CoreText，所有coreText的定义也可以在TextKit中使用
#import <CoreText/CoreText.h>

#define TEXT @"Lorem ipsum dolor sit er elit lamet, consectetaur        北京时间9月10日凌晨1点，苹果秋季新品发布会在美国库伯提诺市弗林特剧院举行，苹果发布新一代iPhone和首款可穿戴智能设备Apple Watch。两块钱你买不了吃亏，买不了上当!"

@interface ViewController ()
@property(nonatomic)UIImageView *imageView; //显示图片
@property(nonatomic)UITextView *textView;   //显示文本内容


//NSTextStoray存储需要显示的文本内容，由于继承自NSMutableAttributedString所以可以给它保存的内容设置字体属性，譬如字体，颜色等
@property(nonatomic)NSTextStorage *textStorage;

//NSTextContainer 指定文本需要绘制的区域，类似画布
@property(nonatomic)NSTextContainer *textContainer;

//NSLayoutManager:把各个组件粘合起来来形成文本系统供textView使用
//他的工作是：把NSTextStorage中保存的字符根据字体来转换为字形
//根据NSTextContainer指定的区域，把字形逐行进行填充
@property(nonatomic)NSLayoutManager *layoutManager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    self.imageView.image = [UIImage imageNamed:@"Mole01.png"];
    [self.view addSubview:self.imageView];
    
    //使用字符串初始化NSTextStorage
    self.textStorage = [[NSTextStorage alloc]initWithString:TEXT];
    
    //设置文本属性,当设置文本属性的时候必须在beginEditing和endEditing之间进行
    [self.textStorage beginEditing];
    
    //key:NSFontAttributeName 指定使用的字体属性,使用Helvetica字体
    //NSTextEffectAttributeName：指定使用凸题印刷效果
    NSDictionary *attrDic = @{NSFontAttributeName:[UIFont fontWithName:@"Helvetica" size:20],NSTextEffectAttributeName:NSTextEffectLetterpressStyle};
    
    //给文本指定属性
    [self.textStorage addAttributes:attrDic range:NSMakeRange(0, TEXT.length)];
    
    //使用红色和下划线来标示字符
    [self strockWordUsingRedColorWithUnderLine:@"北京"];
    [self strockWordUsingRedColorWithUnderLine:@"iPhone"];
    
    [self.textStorage endEditing];
    
    //CGRectInset,缩小一个矩形，左右，上下分别缩小20个像素
    CGRect rect = CGRectInset(self.view.bounds, 20, 20);
    
    //指定一个size的大小作为绘制区域
    self.textContainer = [[NSTextContainer alloc]initWithSize:rect.size];
    
    //生成NSLayoutManager把组件联合起来
    self.layoutManager = [[NSLayoutManager alloc]init];
    [self.textStorage addLayoutManager:self.layoutManager];
    [self.layoutManager addTextContainer:self.textContainer];
//    addTextContainer
//    {
//        self.textContainer.layoutManager = self.layoutManager;
//    }

    //生成UITextView，跟上面的组件发生关联
    self.textView = [[UITextView alloc]initWithFrame:rect textContainer:self.textContainer];
    
    //给绘制区域指定一个排斥路径，该路经内不允许绘制
    UIBezierPath *exclusionPath = [self getExclusionPath];
    self.textContainer.exclusionPaths = @[exclusionPath];
    
    //把textView存放到imageView下面
    [self.view insertSubview:self.textView belowSubview:self.imageView];
}

-(UIBezierPath*)getExclusionPath
{
    CGRect rect = self.imageView.frame;
    //由imageView的坐标是相对与self.view的，而我们需要的是imageView在textView上的坐标，所有需要坐标转换
    //
    CGRect rectInTextView = [self.textView convertRect:rect fromView:self.view];
    //[AView convertRect:rect fromView:BView];
    //把BView上的一个rect转换为AView上的坐标
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rectInTextView];
    
    return path;
}


-(void)strockWordUsingRedColorWithUnderLine:(NSString*)word
{
    //使用正则表达式来匹配字符
    //构建正则表达式
    //+*[]^$
    NSRegularExpression *regular = [[NSRegularExpression alloc]initWithPattern:word options:0 error:nil];
    
    //使用正则表达是来匹配
   NSArray *resultArray = [regular matchesInString:TEXT options:0 range:NSMakeRange(0, TEXT.length)];
    for (NSTextCheckingResult *result in resultArray) {
        //指定文本使用的属性1:颜色2:下划线
        NSDictionary *attributeDic = @{NSForegroundColorAttributeName:[UIColor redColor],(NSString*)kCTUnderlineStyleAttributeName:[NSNumber numberWithInt:kCTUnderlineStyleDouble]};
        //result中由匹配到的range，区域范围
        [self.textStorage addAttributes:attributeDic range:result.range];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
