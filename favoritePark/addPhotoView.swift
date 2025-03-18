//
//  selectPhotoInsteadView.swift
//  fruitTableSectionsSwiftUI
//
//  Created by Daniel on 3/15/25.
//
// VIEW DEMO: https://youtube.com/shorts/aM0fM5Kxd_k?feature=share

import SwiftUI
import PhotosUI
// a view for adding a new task
struct selectPhotoInsteadView: View {
    
    @State var selectedItem: PhotosPickerItem? = nil
    @Binding var selectedImage: UIImage?
    @Binding var toInsertView: Bool
    @Binding var image: String
    
    @Binding var sImage: String
    // Access the presentation mode from the environment to allow dismissal of the view
    @Environment(\.presentationMode) var presentationMode
    
    // Observed object that holds and manages the list of tasks
    //@ObservedObject var viewModel: fruitViewModel
    
    // Local state variable for the task title input field
    @State private var title: String = ""
    // Local state variable for the task description input field
    @State private var description: String = ""
    // Local state variable for the selected image name, initialized with the default image
    @State private var imageName: String = "default"  // Default image name
    
    // List of sample image names available for selection
    let sampleImages = ["banana", "apple", "peach"]
    
    // Main body of the view
    var body: some View {
        NavigationView {  // Embed the form in a navigation view for navigation and toolbar support
            Form {  // Use a form to structure the input fields and selectors
                // Section for entering the task's title and description
                Section(header: Text("Task Information")) {
                    // TextField for task title input (data binding to 'title')
                    VStack {
                        PhotosPicker("Select Image", selection: $selectedItem, matching: .images)
            
                    }
                    .onChange(of: selectedItem) { newItem in
                        Task {
                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
                                selectedImage = UIImage(data: data)
                            }
                        }
                        toInsertView = true
                    }
                }
                
                // Section to select an image icon for the task
                Section(header: Text("Select Image")) {
                    // Horizontal scrollable view to display sample images side-by-side
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            // Loop through each image name in sampleImages array
                            ForEach(sampleImages, id: \.self) { image in
                                Image(image)  // Display the image by its name
                                    .resizable()  // Allow the image to be resized
                                    .scaledToFit()  // Scale the image to fit within the frame
                                    .frame(width: 50, height: 50)  // Set fixed width and height
                                    .clipShape(RoundedRectangle(cornerRadius: 8))  // Clip the image to a rounded rectangle shape
                                    .onTapGesture {
                                        // When the image is tapped, update the selected image name
                                        imageName = image
                                    }
                                    .padding(4)  // Add spacing around the image
                                    .overlay(
                                        // Draw a border around the image to indicate selection
                                        RoundedRectangle(cornerRadius: 8)
                                            .stroke(image == imageName ? Color.blue : Color.clear, lineWidth: 2)
                                    )
                            }
                        }
                    }
                }
            }
            .navigationTitle("Add photo")  // Set the title of the navigation bar
            .toolbar {
                // Toolbar button for saving the task
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {

                        sImage = imageName
                        // Dismiss the AddTaskView after saving the task
                        presentationMode.wrappedValue.dismiss()
                        selectedImage = nil
                        toInsertView = true
                    }
                }
                // Toolbar button for canceling the task addition
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        // Dismiss the AddTaskView without saving any changes
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }
}
