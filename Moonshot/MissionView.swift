//
//  MissionView.swift
//  Moonshot
//
//  Created by saj panchal on 2021-06-24.
//

import SwiftUI

struct MissionView: View {
    let mission: Mission
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    let astronauts: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    GeometryReader  { img in
                        Image(self.mission.image)
                            .resizable()
//                            .scaledToFit()
                            .frame(width: (geometry.size.width * 0.7) - abs(img.frame(in: .global).minY) / 5, height: (geometry.size.width * 0.7) - abs(img.frame(in: .global).minY) / 5, alignment: .center)
                            .padding(.top)
                    }
                    
                    Text(self.mission.formattedLaunchDate).accessibility(label: Text("launch date"))
                        .accessibility(value: Text("\(self.mission.formattedLaunchDate == "N/A" ? "NOT AVAILABLE": self.mission.formattedLaunchDate)"))
                    
                    Text(self.mission.description)
                        .accessibility(label: Text("Mission Description"))
                        .accessibility(value: Text(self.mission.description))
                        .padding()
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(
                            destination: AstronautView(astronaut: crewMember.astronaut, missions: Bundle.main.decode("missions.json")),
                            label: {
                                HStack {
                                    Image(crewMember.astronaut.id)
                                        .resizable()
                                        .frame(width: 83, height: 60)
                                        .clipShape(Capsule())
                                        .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                                    VStack(alignment: .leading) {
                                        Text(crewMember.astronaut.name)
                                            .font(.headline)
                                        Text(crewMember.role)
                                            .foregroundColor(.secondary)
                                    }
                                    Spacer()
                                }
                            }).buttonStyle(PlainButtonStyle())
                       
                    }.padding(.horizontal)
                    Spacer(minLength: 25)
                }
            }
            
        }.navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        var matches = [CrewMember]()
        //scan crew array in mission object.
        for member in mission.crew {
            // get the crew member object from astronauts object with matched id in a given mission
            if let match = astronauts.first(where: {
                $0.id == member.name
            }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            }
            else {
                fatalError("Missing \(member)")
            }
        }
        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
