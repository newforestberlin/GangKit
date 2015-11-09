//
//  ClosureDeclarations.swift
//  TodayTickets
//
//  Created by Ricki Gregersen on 15/09/15.
//  Copyright © 2015 youandthegang.com. All rights reserved.
//

import Foundation

public typealias CompletionClosure = ((completed: Bool) -> ())
public typealias ProgressClosure = ((progress: Int, total: Int) -> ())
public typealias VoidClosure = () -> ()


