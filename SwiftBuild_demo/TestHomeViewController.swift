//
//  TestHomeViewController.swift
//  SwiftBuild_demo
//
//  Created by zhangzhenwei on 2022/7/14.
//

import UIKit
import MMSUIBaseFoundation
import MMFrameManager
import MMBaseUtility
import SVGAPlayer

@objc class TestHomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.contentView.backgroundColor = . green
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    var tableView: UITableView?
    fileprivate lazy var svgaPlyerView = createSvgaPlyerView()

    
    private func createSvgaPlyerView() -> SVGAPlayer {
        let svgaPlayerView = SVGAPlayer(frame: CGRect(x: 10, y: 60, width: 270, height: 99))
        svgaPlayerView.contentMode = .scaleAspectFill
        svgaPlayerView.clearsAfterStop = false
        svgaPlayerView.loops = 1
        return svgaPlayerView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


        let parser = SVGAParser()
        if let url = URL(string: "https://s.momocdn.com/s1/u/cfcjefjej/card_recv2.svga") {
            parser.parse(with: url) { [weak self] (videoItem) in
                if let weakSelf = self {

                    print("========parser success")
                }
            } failureBlock: { (error) in
                if let error = error {
                    print(error)
                }
            }
        }
        
        
        
        
        self.view.backgroundColor = .brown
        // Do any additional setup after loading the view.
        myname("111", 2)
        
        let model = TestModel()
        model.age = 20
        print(model.age)
        createScrollLabel()
        
        let headerview = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 60))
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.tableView?.backgroundColor = .red
        self.tableView?.separatorStyle = .none
        self.tableView?.isScrollEnabled = false
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.rowHeight = 50
        self.view.addSubview(self.tableView!)
        
        DispatchQueue.main.asyncAfter(deadline: .now()+3) {
            UIView.animate(withDuration: 2) {
                self.tableView?.setContentOffset(CGPoint(x: 0, y: -60), animated: false)
            } completion: { finish in
                self.tableView?.tableHeaderView = headerview
                self.tableView?.setContentOffset(.zero, animated: false)
            }
        }
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            self.tableView?.tableHeaderView = nil;
            self.tableView?.setContentOffset(CGPoint(x: 0, y: -60), animated: false)
            UIView.animate(withDuration: 2) {
                self.tableView?.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            } completion: { finish in
//                self.tableView?.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            }
        }
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("========11111=\(scrollView.contentOffset.y)=\(Date.timeIntervalSinceReferenceDate)")
    }
    
    
    func createScrollLabel() {
        
      let label =  MMSScrollLabel()
    }
    
    func myname(_ name: String?, _ sex: Int?, age: Int = 0) {
        
        let label = UILabel(frame: CGRect(x: 10, y: 50, width: 100, height: 40))
        label.backgroundColor = UIColor.red
        label.text = "哈哈哈"
        label.sizeToFit()
        label.font = UIFont.systemFont(ofSize: 15)
        self.view.addSubview(label)
        
        let type = ((sex == 1) ? "有性别": (name == nil ? "zhangsan" : "lisi"))
        let myAge = sex ?? 0
        let testAge = ((myAge+1) > 5) ? "大于5岁" : "小于5岁"
        print("=========type=\(testAge)")
    }
/*
 
 xcodebuild -workspace 'SwiftBuild_demo.xcworkspace' \
 -scheme 'SwiftBuild_demo' \
 -configuration 'Debug' \
 clean build \
 OTHER_SWIFT_FLAGS="-Xfrontend -debug-time-compilation" |
     awk '/CompileSwift normal/,/Swift compilation/{print; getline; print; getline; print}' |
     grep -Eo "^CompileSwift.+\.swift|\d+\.\d+ seconds" |
     sed -e 'N;s/\(.*\)\n\(.*\)/\2 \1/' |
     sed -e "s|CompileSwift normal x86_64 $(pwd)/||" |
     sort -rn |
     head -3
 
    xcodebuild -workspace 'SwiftBuild_demo.xcworkspace' \
    -scheme 'SwiftBuild_demo' \
    -configuration 'Debug' \
    -sdk 'iphonesimulator' \
    clean build \
    OTHER_SWIFT_FLAGS="-Xfrontend -debug-time-compilation" |
        awk '/CompileSwift normal/,/Swift compilation/{print; getline; print; getline; print}' |
        grep -Eo "^CompileSwift.+\.swift|\d+\.\d+ seconds" |
        sed -e 'N;s/\(.*\)\n\(.*\)/\2 \1/' |
        sed -e "s|CompileSwift normal x86_64 $(pwd)/||" |
        sort -rn |
        head -3
    
    
    
    
    xcodebuild -workspace 'SwiftBuild_demo.xcworkspace' \
    -scheme 'SwiftBuild_demo' \
    -configuration 'Debug' \
    clean build \
    OTHER_SWIFT_FLAGS="-Xfrontend -debug-time-function-bodies" |
      grep -o "^\d*.\d*ms\t[^$]*$" |
      awk '!visited[$0]++' |
      sed -e "s|$(pwd)/||" |
      sort -rn |
      head -5

    16226.04ms Library/Styles/UpdateDraftStyles.swift:31:3
    10551.24ms Kickstarter-iOS/Views/RewardCardContainerView.swift:171:16 instance method configureBaseGradientView()
    10547.41ms Kickstarter-iOS/Views/RewardCardContainerView.swift:172:7
    8639.30ms Kickstarter-iOS/Views/Controllers/AddNewCardViewController.swift:396:67
    8233.27ms KsApi/models/templates/ProjectTemplates.swift:94:5
 */
    
    public static func contentLayout(_ feedContents: [String]?,
                              itemID: String?,
                              forward: (isFoward: Bool, hasDeleted: Bool) = (false, false),
                              isDetail: Bool = false,
                              maxWidth: CGFloat = 200,
                              customSetting:(isCustom: Bool, number: UInt) = (false, 2)){

        guard let contents = feedContents else { return }
        let att = NSMutableAttributedString(string: "")
        var tempString = ""
        
        for model in contents {
            let text = model
            if text.isEmpty {
                continue
            }
                        
            var attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 20)]
           
            let attbutedString = NSAttributedString(string: text,
                                                    attributes: attributes)
            
            att.append(attbutedString)
            
            tempString += text
        }

        
        var identifier = ""
        if let itemId = itemID, !itemId.isEmpty {
            identifier += (itemId + (isDetail ? "_detail":""))
        }
         if !identifier.isEmpty {
            identifier += "layoutAttr"
        }
       
        print("=======\(identifier)")
         
    }

}
