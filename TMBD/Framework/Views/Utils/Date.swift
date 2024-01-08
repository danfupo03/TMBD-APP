//
//  Date.swift
//  TMBD
//
//  Created by Dan FuPo on 07/01/24.
//

import Foundation

func dateFormatter(date: String) -> String {
  let dateFormatter = DateFormatter()
  dateFormatter.dateFormat = "yyyy-mm-dd"
  
  let date = dateFormatter.date(from: date)
  dateFormatter.dateFormat = "yyyy"
  
  return dateFormatter.string(from: date!)
}
