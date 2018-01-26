//
//  DateSearchView.swift
//  SwiftWallet
//
//  Created by yaoliangjun on 2018/1/25.
//  Copyright © 2018年 Jerry Yao. All rights reserved.
//

import UIKit

@objc protocol DateSearchViewDelegate: NSObjectProtocol {
    func dateSearchViewDelegate(_ dateSearchView: DateSearchView, startDate: String?, endDate: String?)
}

class DateSearchView: UIView {

    weak var delegage: DateSearchViewDelegate?
    fileprivate var startDateTextField: UITextField?
    fileprivate var endDateTextField: UITextField?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubView()
    }

    // MARK: - Private Method
    @objc fileprivate func searchBtnClick() {
        if delegage != nil && delegage!.responds(to: #selector(DateSearchViewDelegate.dateSearchViewDelegate(_:startDate:endDate:))) {
            delegage!.dateSearchViewDelegate(self, startDate: startDateTextField!.text, endDate: endDateTextField!.text)
        }
    }

    // 日期选取器值改变的响应事件
    @objc fileprivate func datePickerValueChanged(datePicker: UIDatePicker) {
        let selectedDate = datePicker.date
        let dateStr = NSDate.dateString(date: selectedDate, GlobalEnum.DateFormatter.yyyymmdd.rawValue)

        if startDateTextField!.isFirstResponder {
            startDateTextField?.text = dateStr

        } else if endDateTextField!.isFirstResponder {
            endDateTextField?.text  = dateStr
        }
    }

    // MARK: - Getter / Setter
    fileprivate func setupSubView() {

        let contentView = CommonView()
        self.addSubview(contentView)
        contentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }

        // 起始日期
        let startLabel = UILabel(text: NSLocalizedString("起始日期", comment: ""), textColor: UIColor.white, font: UIFont(12))
        contentView.addSubview(startLabel)
        startLabel.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(10)
            make.centerY.equalTo(contentView)
            make.height.equalTo(20)
        }

        let startDateLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        startDateTextField = UITextField(text: nil, textAlignment: .left, textColor: AppConstants.greyTextColor, placeholder: nil, placeholderColor: GlobalConstants.placeholderColor, font: UIFont(12), backgroundColor: UIColor.white, cornerRadius: 4, leftView: startDateLeftView)
        startDateTextField?.delegate = self
        startDateTextField?.tag = 1000
        startDateTextField?.inputView = datePicker
        contentView.addSubview(startDateTextField!)
        startDateTextField!.snp.makeConstraints { (make) in
            make.left.equalTo(startLabel.snp.right).offset(5)
            make.centerY.equalTo(startLabel)
            make.height.equalTo(25)
            make.width.lessThanOrEqualTo(120)
        }

        // 搜索按钮
        let searchBtn = UIButton(image: UIImage(named: "query_button_normal"), highlightedImage: UIImage(named: "query_button_press"), target: self, selector: #selector(searchBtnClick))
        contentView.addSubview(searchBtn)
        searchBtn.snp.makeConstraints { (make) in
            make.right.equalTo(contentView).offset(-10)
            make.width.equalTo(25)
            make.height.equalTo(20)
            make.centerY.equalTo(contentView)
        }

        // 结束日期
        let endDateLeftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 5))
        endDateTextField = UITextField(text: nil, textAlignment: .left, textColor: AppConstants.greyTextColor, placeholder: nil, placeholderColor: GlobalConstants.placeholderColor, font: UIFont(12), backgroundColor: UIColor.white, cornerRadius: 4, leftView: endDateLeftView)
        endDateTextField?.delegate = self
        endDateTextField?.tag = 2000
        endDateTextField?.inputView = datePicker
        contentView.addSubview(endDateTextField!)
        endDateTextField!.snp.makeConstraints { (make) in
            make.right.equalTo(searchBtn.snp.left).offset(-5)
            make.centerY.equalTo(contentView)
            make.height.equalTo(25)
            make.width.equalTo(startDateTextField!)
        }

        let endLabel = UILabel(text: NSLocalizedString("结束日期", comment: ""), textAlignment: .right, textColor: UIColor.white, font: UIFont(12))
        contentView.addSubview(endLabel)
        endLabel.snp.makeConstraints { (make) in
            make.right.equalTo(endDateTextField!.snp.left).offset(-5)
            make.centerY.equalTo(contentView)
            make.height.equalTo(20)
            make.left.equalTo(startDateTextField!.snp.right).offset(5)
            make.width.lessThanOrEqualTo(65).priority(700)
        }
    }

    fileprivate lazy var datePicker: UIDatePicker = {
        var datePicker = UIDatePicker()
        datePicker.backgroundColor = UIColor.white
        datePicker.timeZone = NSTimeZone.local
        datePicker.date = Date()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        return datePicker
    }()
}

extension DateSearchView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let date = datePicker.date
        textField.text = NSDate.dateString(date: date, GlobalEnum.DateFormatter.yyyymmdd.rawValue)
        
        return true
    }
}
