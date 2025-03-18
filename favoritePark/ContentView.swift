//
//  ContentView.swift
//  fruitTableSectionsSwiftUI
//
//  Created by Daniel Liao on 2/19/23.
//
// VIEW DEMO: https://youtube.com/shorts/aM0fM5Kxd_k?feature=share

import SwiftUI
import MapKit
import PhotosUI

struct ContentView: View {
    @StateObject var fruitVM: fruitViewModel = fruitViewModel()
    @State var toInsertView = false
    @State var fruitName = String()
    @State var fruitType = String()
    @State var tlatitude:String
    @State var tlongitude:String
    @State var description:String
    @State var city:String
    @State var insertPhoto = false
    @State var selectedImage: UIImage? = nil
    @State var image: String
    
    var body: some View {
        NavigationStack
        {
            List {
                ForEach(fruitVM.FruitGroups, id: \.id ) { FruitGroup in
                    let viewModel = fruitVM
                    fruitSectionView(fruitVM: viewModel, FruitGroup: FruitGroup)
                }
            }.navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Favorite Parks")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            
                            toInsertView = true
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }.alert("Insert", isPresented: $toInsertView, actions: {
                    TextField("Name:", text: $fruitName)
                    TextField("Category (A, B, ... Z):", text: $fruitType)
                    TextField("City:", text: $city)
                    TextField("latitude", text: $tlatitude)
                    TextField("longitude", text: $tlongitude)
                    TextField("Description", text: $description)
                    
                    
                    Button("Step 1: Add Photo", action: {
                        insertPhoto = true
                    })
                    
                    
                    Button("Step 2: Insert Park", action: {
                        
                        if let latVal = Double(tlatitude), let lngVal = Double(tlongitude) {
                            let ind: Int = fruitVM.groupNametoNum (gName: fruitType)
                            let fruit: Fruit = Fruit(name: fruitName, image: image, latitude: latVal, longitude: lngVal, description: description, city: city, parkImg: selectedImage)
                            fruitVM.FruitGroups[ind].fruits.append(fruit)
                            
                            fruitName = ""
                            fruitType = ""
                            city = ""
                            tlatitude = ""
                            tlongitude = ""
                            description = ""
                            selectedImage = nil
                            image = ""
                        }
                        
                        
                        
                        
                    })
                    
                    Button("Cancel", role: .cancel, action: {
                        toInsertView = false
                    })
                    
                }, message: {
                    Text("Please Enter Park Detail to Add")
                })
            
            
        }
        .sheet(isPresented: $insertPhoto) {
            selectPhotoInsteadView(selectedImage: $selectedImage, toInsertView: $toInsertView, image: $image, sImage: $image)
        }
    }
}

struct fruitSectionView: View {
    @ObservedObject var fruitVM : fruitViewModel
    let FruitGroup: FruitGroup
    
    
    var body: some View {
        
        Section(header: Text(FruitGroup.groupName)) {
            ForEach(FruitGroup.fruits) { fruit in
                NavigationLink(destination: DetailView(vm: fruitVM, fruit: fruit))
                {
                    parkListView(fruit: fruit)
                }
            }.onDelete(perform: {IndexSet in
                print(IndexSet)
                let ind: Int = fruitVM.groupNametoNum (gName: FruitGroup.groupName)
                if ind != -1 {
                    fruitVM.FruitGroups[ind].fruits.remove(atOffsets: IndexSet)
                }
            })
        }
    }
}

struct parkListView: View {
    let fruit: Fruit
    
    
    var body: some View {
        HStack {
            Image(uiImage: ((fruit.parkImg ?? UIImage(named: fruit.image)) ?? UIImage(named: "banana"))!)
                .resizable()
                .scaledToFit()
                .frame(width:50, height: 50)
                .cornerRadius(20)
            VStack (alignment: .leading, spacing: 5){
                
                Text(fruit.name)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .minimumScaleFactor(0.5)
                Text(fruit.city)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView(tlatitude: "", tlongitude: "", description: "", city: "", selectedImage: UIImage(named: "banana"), image: "banana")
    }
}

