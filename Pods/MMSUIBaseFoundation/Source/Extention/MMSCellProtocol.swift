//
//  MMSCellProtocol.swift
//  MMSUIBaseFoundation
//
//  Created by Zero.D.Saber on 2021/5/25.
//

import Foundation

public protocol MMSCellProtocol: AnyObject {
    
    associatedtype T
    
    /// cell重用id
    static func cellIdentifier() -> String
    
    /// 绑定数据
    func bindModel(_ model: T)
}

public extension MMSCellProtocol {
    
    static func cellIdentifier() -> String {
        return "\(Self.self)"
    }
    
    func bindModel(_ model: T) {
        print("MMSCellProtocol -> \(#function) 默认实现")
    }
}

extension UITableViewCell: MMSCellProtocol {
    public typealias T = Any
    
    
}

extension UICollectionViewCell: MMSCellProtocol {
    public typealias T = Any
}
