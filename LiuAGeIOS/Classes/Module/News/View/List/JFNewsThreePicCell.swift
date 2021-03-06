//
//  JFNewsThreePicCell.swift
//  BaoKanIOS
//
//  Created by jianfeng on 16/1/14.
//  Copyright © 2016年 六阿哥. All rights reserved.
//

import UIKit
import YYWebImage

class JFNewsThreePicCell: UITableViewCell {
    
    @IBOutlet weak var iconView1: UIImageView!
    @IBOutlet weak var iconView2: UIImageView!
    @IBOutlet weak var iconView3: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var befromLabel: UILabel!
    @IBOutlet weak var showNumLabel: UILabel!
    
    var postModel: JFArticleListModel? {
        didSet {
            
            guard let postModel = postModel else { return }
            
            // 防止数据问题出此下策
            if postModel.morepic?.count == 1 {
                iconView1.image = nil
                iconView1.setImage(urlString: postModel.morepic?[0] ?? "", placeholderImage: UIImage(named: "list_placeholder"))
            } else if postModel.morepic?.count == 2 {
                iconView1.image = nil
                iconView2.image = nil
                iconView1.setImage(urlString: postModel.morepic?[0] ?? "", placeholderImage: UIImage(named: "list_placeholder"))
                iconView2.setImage(urlString: postModel.morepic?[1] ?? "", placeholderImage: UIImage(named: "list_placeholder"))
            } else if postModel.morepic?.count == 3 {
                iconView1.image = nil
                iconView2.image = nil
                iconView3.image = nil
                iconView1.setImage(urlString: postModel.morepic?[0] ?? "", placeholderImage: UIImage(named: "list_placeholder"))
                iconView2.setImage(urlString: postModel.morepic?[1] ?? "", placeholderImage: UIImage(named: "list_placeholder"))
                iconView3.setImage(urlString: postModel.morepic?[2] ?? "", placeholderImage: UIImage(named: "list_placeholder"))
            }
            
            articleTitleLabel.text = postModel.title
            timeLabel.text = postModel.newstimeString
            befromLabel.text = postModel.befrom
            showNumLabel.text = postModel.onclick
        }
    }
    
    /**
     计算行高
     */
    func getRowHeight(_ postModel: JFArticleListModel) -> CGFloat {
        self.postModel = postModel
        
        setNeedsLayout()
        layoutIfNeeded()
        
        // sizeclass布局后这里计算不准确，正在找更好的解决办法
        if iPhoneModel.getCurrentModel() == .iPad && iconView1.frame.maxY < 164 {
            return timeLabel.frame.maxY + 15 + 82
        } else {
            return timeLabel.frame.maxY + 15
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 离屏渲染 - 异步绘制
        layer.drawsAsynchronously = true
        
        // 栅格化 - 异步绘制之后，会生成一张独立的图像，cell在屏幕上滚动的时候，本质滚动的是这张图片
        layer.shouldRasterize = true
        
        // 使用栅格化，需要指定分辨率
        layer.rasterizationScale = UIScreen.main.scale
    }
    
}
