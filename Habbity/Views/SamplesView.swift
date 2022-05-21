//
//  SamplesView.swift
//  Habbity
//
//  Created by Миша Перевозчиков on 18.05.2022.
//

import SwiftUI

struct SamplesView: View {
    @StateObject var viewModel = HabitSamplesViewModel()
    
    var body: some View {
        NavigationView {
            List{
                //TEST
                ForEach(viewModel.samplesGroups) { sampleGroup in
                    Section(sampleGroup.groupName) {
                        ForEach(sampleGroup.items) { sample in
                            HStack{
                                Image(systemName: sample.iconName)
                                Text(sample.name)
                            }
                                .onTapGesture {
                                    viewModel.selectedSample = sample
                                }
                        }
                        
                    }
                }
                
                
                //WORKING VERSION
//                Section {
//                    ForEach(viewModel.samples.health) { sample in
//
//                        Text(sample.name)
//                            .onTapGesture {
//                                viewModel.selectedSample = sample
//                            }
//                    }
//                }
            }
            .listStyle(.sidebar)
            .navigationTitle("Habit samples")
            .sheet(item: $viewModel.selectedSample) { sample in
                AddNewHabitView(habitSample: sample)
                    
            }
        }
        
    }
}

struct SamplesView_Previews: PreviewProvider {
    static var previews: some View {
        SamplesView()
    }
}
