//
//  ContentView.swift
//  InstaApp
//
//  Created by Alex Gioffre' on 07/07/24.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import PhotosUI
import StoreKit
import SwiftUI

struct ContentView: View {
    
    @State private var processdImage: Image?
    @State private var filterIntensity = 0.5
    @State private var selectedItem: PhotosPickerItem?
    @State private var showingFilters = false
    
    @AppStorage("filterCount") var filterCount = 0
    @Environment(\.requestReview) var requestReview
    
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                // Image Area
                
                
                PhotosPicker(selection: $selectedItem) {
                    if let processdImage {
                        processdImage
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text("Tap to import a photo"))
                    }
                }
                .buttonStyle(.plain)
                .onChange(of: selectedItem, loadImage)
                
                Spacer()
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                        .onChange(of:filterIntensity, applyProcesing)
                }
                
                HStack {
                    Button("Change Filter", action: changeFilter)
                    
                    Spacer()
                    
                    // Share
                    if let processdImage {
                        ShareLink(item: processdImage, preview: SharePreview("Instafilter image", image: processdImage))
                    }
                }
            }
            .padding([.horizontal, .bottom])
            .navigationTitle("Instafilter")
            .confirmationDialog("Select a filter", isPresented: $showingFilters ) {
                Button("Crystallize") {setFilter(CIFilter.crystallize())}
                Button("Edges") {setFilter(CIFilter.edges())}
                Button("Gauassian Blur") {setFilter(CIFilter.gaussianBlur())}
                Button("Pixellate") {setFilter(CIFilter.pixellate())}
                Button("Sepia Tone") {setFilter(CIFilter.sepiaTone())}
                Button("Unsharp Mask") {setFilter(CIFilter.unsharpMask())}
                Button("Vignette") {setFilter(CIFilter.vignette())}
                Button("cancel", role: .cancel){}
            }
        }
    }
    
    func changeFilter(){
        showingFilters = true
    }
    
    func loadImage() {
        Task {
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self) else {return}
            guard let inputImage = UIImage(data: imageData) else {return}
            
            let beginImage = CIImage(image:inputImage)
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            applyProcesing()
            
        }
    }
    
    func applyProcesing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        } 
        if inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        
        guard let outputImage = currentFilter.outputImage else {return}
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else {return}
        let uiImage = UIImage(cgImage: cgImage)
        processdImage = Image(uiImage: uiImage)
    }
    
    @MainActor func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
        filterCount += 1
        
        if filterCount >= 20 {
            requestReview()
        }
    }
}

#Preview {
    ContentView()
}
