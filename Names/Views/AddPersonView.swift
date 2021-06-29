//
//  AddPersonView.swift
//  Names
//
//  Created by Russell Gordon on 2021-06-29.
//

import SwiftUI

struct AddPersonView: View {
    
    // Access our data store
    @EnvironmentObject var store: PersonStore
    
    // The image to show
    @State private var image: Image?
    
    // The image the user selected
    @State private var inputImage: UIImage?
    
    // The name for the person
    @State private var name: String = ""
    
    // Whether to show the image picker
    @State private var showingImagePicker = false
    
    // Control whether this view is showing or not
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        
        NavigationView {
            
            VStack {
                
                ZStack {
                    Rectangle()
                        // Don't show the rectangle behind a landscape sized photo
                        .fill(image == nil ? Color(hue: 220.0/360.0, saturation: 0.8, brightness: 0.9) : Color(.clear))

                    // display the image
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select an image")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    // select an image
                    showingImagePicker = true
                }
                
                // Field to enter a name
                TextField("What is this person's name?", text: $name)
                
                // Allow selection of random name
                HStack {
                    Spacer()
                    Button("Use Random Name") {
                        getNewRandomName()
                    }
                }
                
                
            }
            .padding()
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage)
            }
            .toolbar {
                
                ToolbarItem(placement: .primaryAction) {
                    
                    Button("Done") {
                        
                        // Add the new person
                        addPerson()
                        
                        // Dismiss this view
                        presentationMode.wrappedValue.dismiss()
                        
                    }
                    // Don't allow person to save unless a name and photo are provided
                    .disabled(name.isEmpty || image == nil)

                    
                }
            }
            .navigationTitle("Add Person")

        }

    }
    
    // Get a new random name
    func getNewRandomName() {
        
        let placeholderNames = ["Bryan Osborn",
                                "Taylor Cooke",
                                "Edgar Washington",
                                "Williams Grant",
                                "Terrell Stein",
                                "Jamar Salinas",
                                "Katie Aguirre",
                                "Ava Mcdowell",
                                "Damian Glass",
                                "Drew Parker",
                                "Nadine Guerrero",
                                "Tyron Lloyd",
                                "Kurt Carpenter",
                                "Jarvis Hess",
                                "Willy Weaver",
                                "Seymour Esparza",
                                "Angelo Lambert",
                                "Millard Richards",
                                "Jesse Casey",
                                "Danielle Finley",
                                "Jamaal Carson",
                                "Lauren Rice",
                                "Irma Brandt",
                                "Carolyn Santana",
                                "Margret Barajas",
                                "Pearlie Pena",
                                "Shanna Mcfarland",
                                "Stanley Gates",
                                "Rashad Jones",
                                "Marcus Mills",
                                "Merle Keller",
                                "Anastasia Payne",
                                "Eli Morse",
                                "Clarence Brewer",
                                "Faustino Mann",
                                "Noel Fritz",
                                "Sydney Solomon",
                                "Stanford Burke",
                                "Ida Winters",
                                "Pamela Mcgrath",
                                "Rosario Nguyen",
                                "Chandra Copeland",
                                "Zelma Gillespie",
                                "Sherwood Ford",
                                "Arlene Beltran",
                                "Lynn Patrick",
                                "Carrie Horton",
                                "Minerva Rich",
                                "Porfirio Novak",
                                "Priscilla Day",]
        
        // Try to avoid same name
        var newName = ""
        var uniqueName = true
        repeat {
            
            // Get a new name
            newName = placeholderNames.randomElement()!
            
            // Assume new name is unique until shown otherwise
            uniqueName = true
            
            // Check to see if name already exists in list of people
            for person in store.people {
                if person.name == newName {
                    uniqueName = false
                    break
                }
            }
            
        } while uniqueName == false && store.people.count < 50
        
        name = newName
        
    }
    
    // Load the image selected from the picker
    func loadImage() {
        
        // Verify that an image was selected, otherwise quit
        guard let inputImage = inputImage else { return }
        
        // Show the image
        image = Image(uiImage: inputImage)
        
    }
    
    // Add the new person
    func addPerson() {
        
        // Add a person to the list
        store.people.append(Person(id: UUID(),
                                   name: name))
        
        // Save that person to permanent storage
        store.saveData()
        
    }
    
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView()
    }
}
