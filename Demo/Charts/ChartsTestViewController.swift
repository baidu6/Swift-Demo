//
//  ChartsTestViewController.swift
//  Demo
//
//  Created by 王云 on 2018/7/30.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
import Charts

class ChartsTestViewController: UIViewController {
    
    var lineView: LineChartView!
    
    var lineView2: LineChartView!
    
    var circleColors: [UIColor]!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        oneChartViewTest()
        twoChartViewTest()

    }
    
    func twoChartViewTest() {
        lineView2 = LineChartView(frame: CGRect(x: 30, y: 400, width: SCREEN_WIDTH - 60, height: 260))
        lineView2.backgroundColor = UIColor.lightGray
        view.addSubview(lineView2)
        
        var entries1 = [ChartDataEntry]()
        var entries2 = [ChartDataEntry]()
        for i in 0..<20 {
            let y = arc4random()%100
            let entry = ChartDataEntry(x: Double(i), y: Double(y))
            entries1.append(entry)
        }
        
        for j in 0..<10 {
            let y = arc4random()%50
            let entry = ChartDataEntry(x: Double(j), y: Double(y))
            entries2.append(entry)
        }
        
        
        let dataSet1 = LineChartDataSet(values: entries1, label: "图例一")
        let dataSet2 = LineChartDataSet(values: entries2, label: "图例二")
        
        //设置线条颜色
        dataSet1.colors = [.red]
        //线条大小
        dataSet1.lineWidth = 2
        
        //修改折点的颜色，大小
        dataSet1.circleColors = [.yellow]   //外圆颜色
        dataSet1.circleHoleColor = .red //内圆颜色
        dataSet1.circleRadius = 6   //外圆半径
        dataSet1.circleHoleRadius = 2   //内圆半径
//        dataSet1.drawCirclesEnabled = false //内外圆都不显示
//        dataSet1.drawCircleHoleEnabled = false  //不显示内圆
        
        //使用虚线表示
        dataSet1.lineDashLengths = [4, 2]
        
        //曲线平滑显示
        dataSet1.mode = .horizontalBezier
        
        //修改线条上的文字
        dataSet1.valueColors = [.blue]
        dataSet1.valueFont = UIFont.systemFont(ofSize: 13)
//        dataSet1.drawValuesEnabled = false  //不显示线条上的文字
        
        //线条上文字格式化显示
        let formatter = NumberFormatter()
        formatter.positiveSuffix = "%"
        dataSet1.valueFormatter = DefaultValueFormatter(formatter: formatter)
        
        //绘制填充色背景
        dataSet1.drawFilledEnabled = true
        dataSet1.fillColor = .white
        dataSet1.fillAlpha = 0.5
        
        //渐变色填充
        dataSet2.drawFilledEnabled = true
        let gradientColors = [UIColor.orange.cgColor, UIColor.white.cgColor] as CFArray
        let colorLocations: [CGFloat] = [1.0, 0.0]
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: colorLocations)
        dataSet2.fill = Fill(linearGradient: gradient!, angle: 90.0)
        
        //设置选中后十字线样式
        dataSet2.highlightColor = .red
        dataSet2.highlightLineWidth = 3
        dataSet2.highlightLineDashLengths = [4, 2]
//        dataSet2.drawHorizontalHighlightIndicatorEnabled = false    //只显示纵向的十字线
//        dataSet2.drawVerticalHighlightIndicatorEnabled = false  //只显示横向的十字线
        dataSet2.highlightEnabled = false   //不启用十字线
        
        
    
        let chartData = LineChartData(dataSets: [dataSet1, dataSet2])
        lineView2.data = chartData
    }
   
    
    func oneChartViewTest() {
        // 初始化
        lineView = LineChartView()
        lineView.backgroundColor = UIColor.orange
        lineView.frame = CGRect(x: 30, y: 100, width: view.bounds.size.width - 60, height: 260)
        lineView.delegate = self
        view.addSubview(lineView)
        
        // 数据
        var dataEntries = [ChartDataEntry]()
        circleColors = [UIColor]()
        for i in 0..<10 {
            let y = arc4random()%100
            let entry = ChartDataEntry(x: Double(i), y: Double(y))
            dataEntries.append(entry)
            circleColors.append(.purple)
        }
        let chartDataSet = LineChartDataSet(values: dataEntries, label: "例一")
        chartDataSet.circleColors = circleColors
        
        let chartData = LineChartData(dataSets: [chartDataSet])
        lineView.data = chartData
        
        // 基本设置
        lineView.noDataText = "暂无数据"
        lineView.chartDescription?.text = "成绩"
        lineView.chartDescription?.textColor = UIColor.black
        
        lineView.scaleYEnabled = false  //取消y轴缩放
        lineView.scaleXEnabled = false  //取消x轴缩放
        lineView.doubleTapToZoomEnabled = true //双击缩放
        lineView.dragEnabled = true //拖动手势
        lineView.dragDecelerationEnabled = true //拖动后是否有惯性
        lineView.dragDecelerationFrictionCoef = 0.9 //拖动后惯性效果摩擦系数，越小越不明显
        
        lineView.drawBordersEnabled = true  //绘制图形区域边框
        lineView.drawGridBackgroundEnabled = true   //绘制图形区域背景
        lineView.borderColor = UIColor.white
        lineView.borderLineWidth = 2.0
        lineView.gridBackgroundColor = UIColor.white
        
        lineView.legend.textColor = UIColor.white
        lineView.legend.form = .circle
        
        //设置X轴样式
        lineView.xAxis.labelPosition = .bottom  //设置x轴位置，默认上下均有
        //把x轴的坐标文字显示在内侧
//        lineView.xAxis.labelPosition = .bottomInside
        //设置x轴的颜色和线宽
        lineView.xAxis.axisLineWidth = 2
        lineView.xAxis.axisLineColor = .blue
        
        //指定最大最小刻度值
        lineView.xAxis.axisMaximum = 15
        lineView.xAxis.axisMinimum = -15
        
        //指定刻度间的最小间隔
        lineView.xAxis.granularity = 5
        
        //设置刻度文字的样式
        lineView.xAxis.labelTextColor = .black
        lineView.xAxis.labelFont = UIFont.systemFont(ofSize: 13)
        lineView.xAxis.labelRotationAngle = -30 ////刻度文字倾斜角度
        
        //刻度文字格式化
        let formatter = NumberFormatter()
        formatter.positivePrefix = "#"
        lineView.xAxis.valueFormatter = DefaultAxisValueFormatter(formatter: formatter)
        
        //设置对应网格线的样式
        lineView.xAxis.gridColor = .red //x轴对应的网格线的颜色
        lineView.xAxis.gridLineWidth = 2    //x轴对应的网格线的宽度
//        lineView.xAxis.drawGridLinesEnabled = false //不显示网格线
        lineView.xAxis.gridLineDashLengths = [4, 2] //网格线显示虚线
    
        //自定义刻度标签文字
        let xValues = ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月"]
        lineView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xValues)
        
        
        //设置Y轴样式
        //只显示左侧Y轴的刻度文字
        lineView.rightAxis.drawLabelsEnabled = false
        //右侧Y轴刻度文字和轴线都不显示
        lineView.rightAxis.enabled = false
        //值反向排列，默认情况下值是自下而上逐渐变大的
        lineView.leftAxis.inverted = true
        //坐标轴刻度文字显示位置
//        lineView.leftAxis.labelPosition = .insideChart
        //设置Y轴的颜色和线宽
        lineView.leftAxis.axisLineWidth = 2
        lineView.leftAxis.axisLineColor = UIColor.black
        //最大最小刻度
        lineView.leftAxis.axisMaximum = 100
        lineView.leftAxis.axisMinimum = -100
        //刻度之间的最小间距
        lineView.leftAxis.granularity = 50
        //绘制0刻度线
        lineView.leftAxis.drawZeroLineEnabled = true
        //修改0刻度线的样式
        lineView.leftAxis.zeroLineColor = UIColor.yellow
        lineView.leftAxis.zeroLineWidth = 2
        lineView.leftAxis.zeroLineDashLengths = [4, 2]
        //修改刻度文字样式
        lineView.leftAxis.labelFont = UIFont.systemFont(ofSize: 15)
        lineView.leftAxis.labelTextColor = UIColor.white
        //修改网格线样式
        lineView.leftAxis.gridColor = .blue
        lineView.leftAxis.gridLineWidth = 2
        lineView.leftAxis.gridLineDashLengths = [4, 2]
        
        
        lineView.animate(xAxisDuration: 1.0)
        
    }

}

extension ChartsTestViewController: ChartViewDelegate {
    
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let chartDataSet = chartView.data?.dataSets[0] as? LineChartDataSet
        let values = chartDataSet?.values
        let index = values?.index(where: { $0.x == highlight.x })
        chartDataSet?.circleColors = circleColors
        chartDataSet?.circleColors[index!] = .orange
        
        //重新渲染表格
        chartView.data?.notifyDataChanged()
        chartView.notifyDataSetChanged()
        
    }
    
    func chartValueNothingSelected(_ chartView: ChartViewBase) {
        let chartDataSet = chartView.data?.dataSets[0] as? LineChartDataSet
        chartDataSet?.circleColors = circleColors
        
        //重新渲染表格
        chartView.data?.notifyDataChanged()
        chartView.notifyDataSetChanged()
    }
}
