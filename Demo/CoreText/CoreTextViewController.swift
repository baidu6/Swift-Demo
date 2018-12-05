
//
//  CoreTextViewController.swift
//  Demo
//
//  Created by 王云 on 2018/8/15.
//  Copyright © 2018年 王云. All rights reserved.
//

import UIKit
import RealmSwift

class ReadModel: Object {
    
    @objc dynamic var bookID = 0
    @objc dynamic var record: ReadRecordModel? = nil
    let chapterList = List<ChapterModel>()
    
    override class func primaryKey() -> String? { return "bookID" }
}

class ReadRecordModel: Object {
    
    @objc dynamic var bookID = ""
    
    @objc dynamic var chapterModel: ChapterModel? = nil
    
    var page = RealmOptional<Int>()
    
    override class func primaryKey() -> String? { return "bookID" }
}

class ChapterModel: Object {
    
    @objc dynamic var bookID = ""
    @objc dynamic var chapterID = ""
    @objc dynamic var name = "第一章"
    @objc dynamic var lastChapterID = ""
    @objc dynamic var nextChapterID = ""
    @objc dynamic var content = ""
//    @objc dynamic var test = ""

    var pageCount = RealmOptional<Int>()
    
//    @objc dynamic var attributes: [String: Any]? = nil
    
//    @objc dynamic var rangeArray =
//    @objc dynamic var attribute =
}

class CoreTextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        let realm = try! Realm()

        
//        let record = ReadRecordModel()
//        record.bookID = 1
//        record.page = 0
//        
        let chapterModel = ChapterModel()
//        chapterModel.test = "test"
        
        let read = ReadModel()
//        read.bookID = 1
        
        let record = ReadRecordModel()
        record.page = RealmOptional.init(90)
        try! realm.write {
            read.record = record
        }
        
//
//        read.bookID = 1
        try! realm.write {
            read.chapterList.append(chapterModel)
        }
//        read.record = record

        print(realm.configuration.fileURL?.absoluteString)
        try! realm.write {
            realm.create(ReadModel.self, value: read, update: true)
            let reads = realm.objects(ReadModel.self)
            print(reads.first?.chapterList.first?.content)
        }
        
        
        let string = """
"在36Kr的采访中，陆奇以天时（Timing-When）、地利（Location-Where）和人和（People-Who）来总结自己的选择，他说这是他迈出今日一步的三大原因。
天时方面，他谈到了个人家庭、历史进程和中美格局。
陆奇说自己已经57岁了，持续负重前行、大规模高强度的工作已然不再适合，他核心要考虑的是，在未来5-10年的职业生涯中，做成怎样的事情。
他没有公开谈论家庭的原因，但在私下，今年父亲的离世对他影响不小。向来以工作狂著称的陆奇，开始更多顾及家庭陪伴和天伦之乐。在离职百度后的时间里，他大部分时间选择在上海照顾母亲。
所以YC的工作显然压力要小得多，这是一个投资孵化为一体的组织，已经打响了知名度，在中国还是全新的业务，没有亚历山大的增长KPI给到他。
另一个天时的原因是历史进程。陆奇说当前正处于一个AI为代表的新技术驱动变革的时代，新技术必然要求新机制、新环境，他乐于在变革早期参与到创新生态的培育、设计和推动中。
第三个天时是中美格局。陆奇认为中国正在处在一个大爆发的路口，过去十几年里，中国技术已经在商业模式和用户体验上做出了成绩，对技术创新的诉求愈加强烈，而且这也是他离职微软后坚定寻求中国机会的原因。
而且，中美格局也是地利中的一部分。

无论是工作还是家庭，陆奇都需要往返中美之间，他希望新工作能够允许他更多自由跨越太平洋两岸。他在中国有母亲的牵挂，但女儿们又在美国。
而且中国在AI浪潮里的崛起显然势头汹涌，作为技术出身又关注创新的他，肯定不希望缺席。
最后是人和，陆奇谈到了与YC前后两任CEO的缘分。他跟YC创始人保罗·格雷厄姆是雅虎同事，并在2005年就认识了现任CEO Sam，当时Sam刚接手YC不久。
陆奇一直很认可YC的方法，后来也是他依照YC模式创立必应基金的原因。
而就在新选择开启后，他跟Sam Altman有过长聊，发现大家有着更进一步的共同理念和价值观。
当然，陆奇隐而未宣的是，Sam Altman为了能让YC中国更快推出，也给陆奇开出了条件优渥的offer。而且百度竞业协议的限制，就算是想继续迎接AT的机会，也不是完全没有阻碍。
陆奇还说，他每一次的选择都很理性，喜欢用结构化的方式、综合各种因素，但也希望新工作不能只消耗过往的经验，还希望每天都有新所学，最好还能同时对社会产生公益价值和长远贡献。
不过，陆奇显然只透露了选择YC的原因，而没有说拒绝其他机会的原因。
量子位听说的是，在陆奇离任百度之后，并不缺符合上述条件的机会，他和华为有过绯闻，腾讯也希望他能加入，还有诸如比特大陆一样的新兴势力也盛情邀请，但他最后都拒绝了。
YC对于陆奇来说，并不是一个上佳的选择，因为YC显而易见的下滑口碑，以及在中国会遭遇的竞争态势，都非常直接。
YC上上签
YC创办于2005年，总部位于Google总部所在地硅谷山景城，核心打法是投资+孵化器，为初创公司提供全套解决方案，快速推动初创公司创新。
截至目前为止，YC累计加速的公司超过1900家，总估值规模达到了1千亿美元，总融资规模超过180亿美元，Airbnb、Dropbox和Reddit等公司都入选过YC。
但YC的打法也颇具特色，对于入选项目，YC会选择性提供12万美元的投资，占股7%。
即便在硅谷，这样的“条件”已算苛刻，并且随着AI带来的水涨船高，越拉越多的优质项目不再把YC当做“镀金地”，造成YC近年越来越少能够产出优质项目，口碑日衰一日。
而且来到中国，12万美元占股7%的打法，近乎“压榨”，更何况国内风险投资和项目估值，也比硅谷活跃得多。

此外值得注意的是，这种强势在近年屡屡成为接盘主力的BAT那里，也没有任何话语权。
之前中国也有前往YC镀金的项目渡鸦科技，后来还在陆奇加盟后被百度并购，然而现今结果而言，渡鸦成为了彻头彻尾的败笔。
所以YC中国想要复制在硅谷的传奇经历，还不希望改变打法，几乎是痴心妄想。
但幸运的是，他们找到的YC中国创始人是陆奇，可能口碑和声誉吸引下，启动初期或有助益，然而于长远计，不好说。
也找不到比陆奇更能自带流量的人了，所以于YC和YC中国而言，确实是上上签。
当然，塞翁失马焉知非福。虽然陆奇选择YC并不被看好，但至少Sam Altman手里还有另一家知名的AI机构——OpenAI。据透露，未来陆奇可能会更多参与到OpenAI的发展与合作业务之中。
不过Sam Altman也一向以富有野心和进攻性著称，陆奇向他汇报，想完全独立自主享有更大话语权，显然也不会轻而易举。
但YC很可能是陆奇最后一次职业选择了。
如他自己所言，他已经57岁，他没有更多选择。
只能祝福陆奇再度带来惊喜。
热议陆奇
新动向的宣布，再次让陆奇成为全球焦点。
不仅国内媒体纷纷报道这一事件，TechCrunch、彭博等国外媒体也在关注这一事件，很多人在Twitter上发出祝贺，陆奇履新也迅速成为Hacker News的新头条。

当然Hacker News本身就是YC旗下业务~
YC总裁Sam Altman说，他为陆奇加盟已经努力了十年。早在陆奇选择加入百度之前，他们就聊过这件事。“所以当他离开百度时，我很快就联系到了。”
Altman在19岁时就成为一家创业公司的CEO，后来拿到YC投资。2011年他成为YC的兼职合伙人，2014年只有29岁的Altman出任YC总裁。他说话语速飞快，被认为极具野心和战略思维。
上面也提过，OpenAI也是Sam Altman和伊隆·马斯克2015年联合创办的。
他最终说服陆奇，也在情理之中。
很多人都对陆奇发出祝贺。国外网友借机开始翻出陆奇的履历，细数他之前的工作业绩。同时畅想了一下YC在中国可能会有怎样的发展。
而中国网友表示，陆奇让“中国创业者又有了一个新的选择”。创业黑马董事长牛文文表示：“创业服务业喜迎新代言人”。

微博用户 @汇开心 评论说：（陆奇）来的不是时候，基本饱和且走下坡路了，关键是经济大环境已经很差了……不过互联网+应该还是个方向。
不过也有不少眼尖的人指出，陆奇的选择，似乎是一条别人走过的路。并对大牛们今天仍然纷纷选择创建孵化器表示不解。
@老编辑不上班 的一条微博获得了不少转发，他写道：“大厂真的没窝了吗？真是屈才了”。
知乎用户 @Ender 直言：“Qi的精神我非常佩服。但实在没法叫好。”
YC的鼎盛时期是2011年左右，在美国好多年没孵化出像样的项目，跟它自己大规模扩张和创业时代变化有关系，到中国来，更没法搞了。试想稍微靠谱点的创始人，现在谁还图那点资源去孵化器路演？Qi现在去YC，图啥？跟他当初仓促去百度的决定一样，都令人费解。国内的环境凶险，对美国大平台呆久了的人，不容易。
- 完 -"
"""
        let ranges = CTFrameParser.parserPageRange(string: string, rect: view.bounds, attr: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 15), NSAttributedStringKey.foregroundColor: UIColor.red])
        print(ranges)
        
//        let display = DisplayView(frame: CGRect(x: 0, y: 100, width: SCREEN_WIDTH, height: 300))
//        display.content = (string as NSString).substring(with: NSMakeRange(<#T##loc: Int##Int#>, <#T##len: Int##Int#>))
//        view.addSubview(display)
    }

}

class DisplayView: UIView {
    
    var content: String = "" {
        didSet {
            setNeedsDisplay()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        //获取图形上下文
        let context = UIGraphicsGetCurrentContext()
        
        //旋转坐标
        context?.textMatrix = .identity
        context?.translateBy(x: 0, y: self.bounds.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        //创建绘制局域
        var path = CGMutablePath()
        path.addRect(self.bounds)
        
        //设置绘制内容
        let string = NSMutableAttributedString(string: content)
        
        let framesetter = CTFramesetterCreateWithAttributedString(string)
        let frame = CTFramesetterCreateFrame(framesetter, CFRange(location: 0, length: string.length), path, nil)
        
        //开始绘制
        CTFrameDraw(frame, context!)
    
    }
}

//MARK:- 用于配置 绘制的参数，如文字颜色，大小，行间距等
class CTFrameParserConfig: NSObject {
    
    var width: CGFloat = 200
    var fontSize: CGFloat = 16
    var lineSpace: CGFloat = 8
    var textColor: UIColor = UIColor.black
    
}

//MARK:- 用于生成最后绘制界面需要的CTFrameRef实例
class CTFrameParser: NSObject {
    
    static func createFrameWithFramesetter(framesetter: CTFramesetter, config: CTFrameParserConfig, height: CGFloat) -> CTFrame {
        
        let path = CGMutablePath()
        path.addRect(CGRect(x: 0, y: 0, width: config.width, height: height))
        
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, nil)
        
        return frame
    }
    
    static func parserPageRange(string: String, rect: CGRect, attr: [NSAttributedStringKey: Any]) -> [NSRange] {
        
        var rangesArray = [NSRange]()
        
        let attrString = NSMutableAttributedString(string: string, attributes: attr)
        
        let framesetter = CTFramesetterCreateWithAttributedString(attrString)

        let path = CGPath(rect: rect, transform: nil)
        
        var range = CFRangeMake(0, 0)
        
        var rangeOffset = 0
        
        repeat {
            let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(rangeOffset, 0), path, nil)
            
            range = CTFrameGetVisibleStringRange(frame)
            
            rangesArray.append(NSMakeRange(rangeOffset, range.length))
            
            rangeOffset += range.length
            
        } while (range.location + range.length) < attrString.length
        
        return rangesArray
    }
}

//MARK:- 用于保存CTFrameParser生成的CTFrameRef实例，以及CTFrameRef实际绘制需要的高度
class CoreTextData: NSObject {
    
}

//MARK:- 持有CoreTextData类实例，负责将CFFrameRef绘制在界面上
class CTDisplayView: UIView {
    
}
