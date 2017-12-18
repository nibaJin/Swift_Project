//
//  RefreshTableView.swift
//  JiuHuarSalesOrder
//
//  Created by jin fu on 2017/12/14.
//  Copyright © 2017年 jin fu. All rights reserved.
//

import UIKit

let footerRefreshViewHeight: CGFloat = 44

protocol PullRefreshDelegate: NSObjectProtocol{
    func loadDataFromHead(_ isHead:Bool) -> Void
}

class RefreshTableView: UITableView {
    weak var pullingDelegate: PullRefreshDelegate?

    var r_contentInset: UIEdgeInsets = UIEdgeInsetsMake(0, 0, footerRefreshViewHeight, 0) {
        didSet {
            orginInsert = r_contentInset
            
            contentInset = UIEdgeInsetsMake(r_contentInset.top, r_contentInset.left, r_contentInset.bottom+footerRefreshViewHeight, r_contentInset.right)
        }
    }
    
    var haveMore: Bool = false {
        didSet {
            if haveMore {
                contentInset = UIEdgeInsetsMake(orginInsert.top, orginInsert.left, orginInsert.bottom + footerRefreshViewHeight, orginInsert.right)
                footerRefreshView.isHidden = false
            } else {
                contentInset = orginInsert
                footerRefreshView.isHidden = true
            }
        }
    }
    
    private let contentOffsetObserve = "contentOffset"
    
    private let contentSizeObserve = "contentSize"
    
    private let panState = "state"
    
    private var footerRefreshView: UIView!

    private var orginInsert: UIEdgeInsets = .zero
    
    enum FooterRefreshState: Int {
        case FooterRefrshNomal
        case FooterRefreshing
    }
    
    private var footerRefrshState: FooterRefreshState = .FooterRefrshNomal
    
    private var footer_y: CGFloat = 0{
        willSet {
            if let footerReView = footerRefreshView {
                footerReView.frame = CGRect.init(origin: CGPoint.init(x: footerReView.frame.origin.x, y: CGFloat(newValue)), size: CGSize.init(width: footerReView.frame.size.width, height: footerReView.frame.size.height))
            }
        }
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        }
        configRefreshHeaderView()
        configrefreshFooterView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
        }
        configRefreshHeaderView()
        configrefreshFooterView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    deinit {
        dg_removePullToRefresh()
        removeObserver(self, forKeyPath: contentOffsetObserve)
        removeObserver(self, forKeyPath: contentSizeObserve)
        panGestureRecognizer.removeObserver(self, forKeyPath: panState)
        dLog("deinit")
    }
}

// header refresh
extension RefreshTableView {
    private func configRefreshHeaderView () {
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        dg_addPullToRefreshWithActionHandler({[weak self] in
            if let strongSelf = self, let delegate = strongSelf.pullingDelegate {
                delegate.loadDataFromHead(true)
            }
            }, loadingView: loadingView)
        dg_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
        dg_setPullToRefreshBackgroundColor(backgroundColor!)
    }
    
    private func beginHeaderRefresh() {}
    
    func endheaderRefresh() {
        dg_stopLoading()
    }
}

// footer refresh
extension RefreshTableView {
    private func configrefreshFooterView() {
        orginInsert = contentInset
        contentInset = UIEdgeInsetsMake(orginInsert.top, orginInsert.left, orginInsert.bottom + footerRefreshViewHeight, orginInsert.right)
        let footerReView = UIView.init(frame: CGRect.init(origin: CGPoint.init(x: 0, y: contentSize.height), size: CGSize.init(width: mainWidth, height: footerRefreshViewHeight)))
        footerReView.backgroundColor = UIColor.white
        let label = UILabel.init(frame: footerReView.bounds)
        label.textAlignment = .center
        label.text = "加载中..."
        footerReView.addSubview(label)
        footerRefreshView = footerReView
        addSubview(footerRefreshView)
        addObserves()
    }
    
    private func addObserves() {
        addObserver(self, forKeyPath: contentOffsetObserve, options: [.new,.old], context: nil)
        addObserver(self, forKeyPath: contentSizeObserve, options: [.new,.old], context: nil)
        panGestureRecognizer.addObserver(self, forKeyPath: panState, options: [.new,.old], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == contentSizeObserve {
            scrollViewContentSizeDidChange(change: change)
        }
        
        if let footerReView = footerRefreshView , footerReView.isHidden {
            return
        }
        
        if keyPath == contentOffsetObserve {
            scrollViewContentOffsetDidChange(change: change)
        } else if keyPath == panState {
            scrollViewPanStateDidChange(change: change)
        }
    }
    
    private func scrollViewContentSizeDidChange(change: [NSKeyValueChangeKey : Any]?) {
        footer_y = contentSize.height
    }
    
    private func scrollViewContentOffsetDidChange(change: [NSKeyValueChangeKey : Any]?) {
        if footer_y == 0 {
            return
        }
        
        if footerRefrshState == .FooterRefreshing {
            return
        }
        
        if contentInset.top + contentSize.height > frame.height,
            contentOffset.y >= contentSize.height - frame.height + contentInset.bottom  {
            if let change = change {
                let old: CGPoint = change[NSKeyValueChangeKey.oldKey] as! CGPoint
                let new: CGPoint = change[NSKeyValueChangeKey.newKey] as! CGPoint
                if new.y <= old.y {return}
            }
            
            beginFooterRefresh()
        }
    }
    
    private func scrollViewPanStateDidChange(change: [NSKeyValueChangeKey : Any]?) {
        
    }
    
    private func beginFooterRefresh() {
        dLog("11111111111")
        footerRefrshState = .FooterRefreshing
        
        if let delegate = self.pullingDelegate {
            delegate.loadDataFromHead(false)
        }
    }
    
    func endFooterRefrsh() {
        footerRefrshState = .FooterRefrshNomal
    }
}
