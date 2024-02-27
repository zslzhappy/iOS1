//
//  Reload.swift
//  
//
//  Created by thor.wang on 2021/1/28.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
//MARK: 代码中的print函数仅在debug模式下生效

#if !DEBUG
public func print(items: Any..., separator: String = "", terminator: String = "") { }
#endif
