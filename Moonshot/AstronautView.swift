//
//  AstronautView.swift
//  Moonshot
//
//  Created by saj panchal on 2021-06-24.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]
    var sortedMissions: [String] {
        var names: [String] = []
        for mission in missions {
            let result = mission.crew.contains{ item in
                    item.name == astronaut.id
                }
            if result {
                names.append(mission.displayName)
            }
        }
        return names
    }
    var body: some View {
        //geometryReader must enclose the whole View although it is for Image view only.
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    Text("Missions")
                        .font(.title2)
                        .fontWeight(.bold)
                    List {
                        ForEach(0..<sortedMissions.count) { item in
                            Text(sortedMissions[item])
                        }
                    }
                }
                
            }
        }
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static var previews: some View {
        AstronautView(astronaut: astronauts[0], missions: missions)
    }
}
