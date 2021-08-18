//
//  ContentView.swift
//  Moonshot
//
//  Created by saj panchal on 2021-06-22.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    @State var flag = false
    var body: some View {
        NavigationView {
            List(missions) { mission in
                NavigationLink(destination: MissionView(mission: mission, astronauts: self.astronauts)) {
                    
                        Image(mission.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 44, height: 44)
                    VStack(alignment: .leading) {
                        Text(mission.displayName)
                            .font(.headline)
                        Text(flag ? mission.formattedLaunchDate : crewNames(mission: mission))
                            .foregroundColor(.secondary)
                    }
                 
                       
                    }
            }.navigationBarTitle("MoonShot")
            .navigationBarItems(trailing: Button("Toggle") {
                flag.toggle()
            })
        }
    }
}
func crewNames(mission: Mission) -> String {
    var str = ""
    for member in mission.crew {
        str = str + member.name + " "
    }
    
    return str
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
