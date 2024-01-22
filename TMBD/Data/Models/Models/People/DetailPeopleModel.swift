//
//  DetailPeopleModel.swift
//  TMBD
//
//  Created by Dan FuPo on 19/01/24.
//

import Foundation

struct DetailPeople: Codable, Identifiable {
  var id: Int
  var biography: String
  var birthday: String?
  var deathday: String?
  var place_of_birth: String?
}
