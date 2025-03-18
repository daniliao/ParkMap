//
//  DetailView.swift
//  fruitTableSectionsSwiftUI
//
//  Created by Daniel Liao on 9/17/23.
//
// VIEW DEMO: https://youtube.com/shorts/aM0fM5Kxd_k?feature=share

import SwiftUI
import MapKit

struct DetailView: View {
    @ObservedObject var vm: fruitViewModel
    let fruit: Fruit

    
    // default location set to Tempe
    private static let defaultLocation = CLLocationCoordinate2D(
        latitude: 33.4255,
        longitude: -111.9400
    )
    
    // state property that represents the current map region
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(
            latitude: 33.4255,
            longitude: -111.9400
        ),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    
    // state property that stores marker locations in current map region
    @State private var markers = [
        Fruit(name: "", latitude: 33.4255, longitude: -111.9400, description: "Dogs allowed · Picnic tables · Playground", city: "Phoenix")
    ]
    @State private var searchText = ""
    
    
    var body: some View {
        searchBar
        ZStack(alignment: .bottom) {
            Map(coordinateRegion: $region,
                interactionModes: .all,
                annotationItems: markers) { location in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)) {
                    VStack {
                        Image(systemName: "mappin.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                        Text(location.name)
                            .font(.caption)
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .ignoresSafeArea()
        .onAppear {
            let fruitLocation = CLLocationCoordinate2D(latitude: fruit.latitude, longitude: fruit.longitude)
            region = MKCoordinateRegion(
                center: fruitLocation,
                span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            )
            markers = [fruit]
        }
        parkDetail
        
        
    }
    
    
    private var searchBar: some View {
        HStack {
            Button {
                let searchRequest = MKLocalSearch.Request()
                searchRequest.naturalLanguageQuery = searchText
                searchRequest.region = region
                
                MKLocalSearch(request: searchRequest).start { response, error in
                    guard let response = response else {
                        print("Error: \(error?.localizedDescription ?? "Unknown error").")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        region = response.boundingRegion
                        markers = response.mapItems.map { item in
                            return Fruit(
                                name: item.name ?? "",
                                latitude: item.placemark.coordinate.latitude,
                                longitude: item.placemark.coordinate.longitude,
                                description: item.description,
                                city: ""
                            )
                        }
                    }
                    
                }
            } label: {
                Image(systemName: "location.magnifyingglass")
                    .resizable()
                    .foregroundColor(.accentColor)
                    .frame(width: 24, height: 24)
                    .padding(.trailing, 12)
            }
            TextField("Search e.g. Mill Cue Club", text: $searchText)
                .foregroundColor(.white)
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 8)
                .foregroundColor(.black)
        }
        .padding()
    }
    
    
    
    @MainActor
    private func startSearch() async {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchText
        searchRequest.region = region

        let search = MKLocalSearch(request: searchRequest)
        do {
            let response = try await search.start()
            region = response.boundingRegion
            
            markers = response.mapItems.map { item in
                Fruit(
                    name: item.name ?? "",
                    latitude: item.placemark.coordinate.latitude,
                    longitude: item.placemark.coordinate.longitude,
                    description: item.description,
                    city: ""
                )
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    private var parkDetail: some View {
        HStack {
            
            Image(uiImage: ((fruit.parkImg ?? UIImage(named: fruit.image)) ?? UIImage(named: "banana"))!)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height:50)
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
            Text(fruit.description)
                .font(.subheadline)
            Text("\(fruit.latitude), \(fruit.longitude)")
        }
    }
}
