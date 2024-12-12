//
//  EditItemScreen.swift
//  BrainMatter
//
//  Created by Joseph DeWeese on 12/10/24.
//

import SwiftUI
import PhotosUI
import SwiftData



struct EditItemScreen: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    let item: Item
    
    @State private var status = Status.Hold
    @State private var showImagePicker = false
    @State private var showImageEditor = false
    @State private var title = ""
    @State private var itemColor = Color.accentColor
    @State private var remarks = ""
    @State private var dateAdded: Date = .init()
    @State private var dateStarted: Date = .init()
    @State private var dateCompleted: Date = .init()
    var editItem: Item?
    /// View Properties
    @State private var category: Category = .Objectives
    
    @State private var showSTags = false
    init(item: Item) {
        self.item = item
        _status = State(initialValue: Status(rawValue: item.status)!)
    }
    var body: some View {
        NavigationStack{
                VStack{
                    ScrollView {
                        DashControlView(item: item)
                        VStack(alignment: .center, spacing: 7){
                            ///title
                            Text("Objective Title")
                                .foregroundStyle(.blue)
                                .padding(.bottom, 4)
                            TextField("Objective Title", text:$title)
                                .padding()
                                .foregroundStyle(.primary)
                                .background(.thinMaterial.shadow(.drop(color: .black.opacity(0.65), radius: 3)), in: .rect(cornerRadius: 10))
                                .padding(.horizontal)
                                .padding(.bottom, 10)
                            ///description
                            Text("Brief Description")
                                .foregroundStyle(.secondary)
                            TextEditor(text: $remarks)
                                .multilineTextAlignment(.leading)
                                .lineLimit(3)
                                .foregroundStyle(.primary)
                                .background(.thinMaterial.shadow(.drop(color: .black.opacity(0.65), radius: 4)), in: .rect(cornerRadius: 7))
                                .frame(minWidth: 365, maxWidth: .infinity, minHeight: 85, maxHeight: .infinity, alignment: .leading)
                                .padding(.bottom, 10)
                            /// Giving Some Space for tapping
                                .padding(.horizontal)
                         
                                
                            //MARK:  CUSTOM COLOR PICKER (OBJECTIVE COLOR)
                            
                            if item.sTags != nil {
                                ViewThatFits {
                                    //         TargetTagsStackView(targetTags: targetTags)
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        //            TargetTagsStackView(targetTags: targetTags)
                                    }
                                }
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(uiColor: .tertiarySystemFill), lineWidth: 2))
                            }
                        }
                        .padding()
                        .navigationBarTitle("Edit Objective Folder")
                        .navigationBarTitleDisplayMode(.inline)
                    }
                    if changed {
                        Button{
                            HapticManager.notification(type: .success)
                            item.status = status.rawValue
                            item.title = title
                            item.remarks = remarks
                            item.dateAdded = dateAdded
                            item.dateStarted = dateStarted
                            item.dateCompleted = dateCompleted
                            dismiss()
                        }  label: {
                            ZStack{
                                RoundedRectangle(cornerRadius: 10).stroke(style: StrokeStyle(lineWidth: 1))
                                
                                Text("Update Objective")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                            }
                        }
                        .frame(width: 300, height: 55)
                        .buttonStyle(.borderedProminent)
                    }
                }
                .padding(.top, 15)
                    .onAppear {
                        title = item.title
                        remarks = item.remarks
                        dateAdded = item.dateAdded
                        dateStarted = item.dateStarted
                        dateCompleted = item.dateCompleted
                        
                    }
            }
            var changed: Bool {
                status != Status(rawValue: item.status)!
                || title != item.title
                || remarks != item.remarks
                || dateAdded != item.dateAdded
                || dateStarted != item.dateStarted
                || dateCompleted != item.dateCompleted
                
            }
        }
    
    
    
    
    }
#Preview {
    EditItemScreen(item: Item())
}
