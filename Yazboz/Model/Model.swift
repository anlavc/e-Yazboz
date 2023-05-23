//
//  Model.swift
//  Yazboz
//
//  Created by Anıl AVCI on 18.05.2023.
//

import Foundation

struct Game {
    var players: [Player] = []
    var rounts: [Rount] = []
    var total: [TotalPoints] = []
    var name: String?
}
struct Player {
    var playerName: String?
    }
struct Rount {
    var points: [Int] = []

}
struct TotalPoints {
    var PlayerTotal: Int?
    }




var game = [Game(players: [Player(playerName: ""),
                           Player(playerName: ""),
                           Player(playerName: ""),
                           Player(playerName: "")],

                 rounts: [
                     Rount(points: []),
                     Rount(points: []),
                     Rount(points: []),
                     Rount(points: [])
                 ],
                 total: [
                     TotalPoints(PlayerTotal: 0),
                     TotalPoints(PlayerTotal: 0),
                     TotalPoints(PlayerTotal: 0),
                     TotalPoints(PlayerTotal: 0),
                 ],name: "")]
