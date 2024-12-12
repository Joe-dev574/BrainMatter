//
//  ItemCardView.swift
//  BrainMatter
//
//  Created by Joseph DeWeese on 12/10/24.
//

import SwiftUI

import SwiftUI

struct ItemCardView: View {
    @Environment(\.modelContext) private var context
    let item: Item
    var body: some View {
        NavigationStack{
            SwipeAction(cornerRadius: 10, direction: .trailing) {
                ZStack {
                    RoundedRectangle(cornerRadius: 7)
                        .fill(.ultraThinMaterial.opacity(.greatestFiniteMagnitude))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    VStack(alignment: .leading){
                        HStack{
                            ZStack {
                                RoundedRectangle(cornerRadius: 7)
                                    .fill(.ultraThinMaterial)
                                    .frame(height: 30)
                                Text(item.category)
                                    .padding(3)
                                    .padding(.horizontal,2)
                                    .foregroundStyle(.white)
                                    .background(.blue.gradient, in: .rect(cornerRadius: 7))
                                    .contentShape(.rect)
                                    .fontDesign(.serif)
                                    .hSpacing(.trailing)
                                    .padding(.horizontal, 30)
                                   
                            }
                        }
                        //MARK:  MAIN BODY OF CARD
                        HStack{
                            //MARK:  ICON
                            item.icon
                                .font(.title)
                                .padding(.leading, 5)
                                .padding(.horizontal, 10)
                                .padding(.bottom, 30)
                                .foregroundStyle(.orange)
                            VStack(alignment: .leading){
                                Text(item.title )
                                    .fontDesign(.serif)
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                    .foregroundStyle(.primary)
                                    .padding(.horizontal, 2)
                                    .padding(.bottom, 4.0)
                                Text(item.remarks)
                                    .fontDesign(.serif)
                                    .font(.system(size: 14))
                                    .foregroundStyle(.blue)
                                    .padding(.horizontal, 4)
                                    .padding(.bottom, 7)
                                    .lineLimit(3)
                                HStack {
                                    //MARK:  DATE CREATED DATA LINE
                                    Text("Date Created: ")
                                        .foregroundStyle(.gray)
                                        .fontDesign(.serif)
                                    Image(systemName: "calendar.badge.clock")
                                        .font(.caption)
                                        .fontDesign(.serif)
                                        .foregroundStyle(.gray)
                                    Text(item.dateAdded.formatted(.dateTime))
                                        .fontDesign(.serif)
                                        .foregroundColor(.secondary)
                                }.padding(.top, 5)
                                    .padding(.bottom, 3)
                                HStack {
                                    if let sTags = item.sTags {
                                        ViewThatFits {
                                   //         SniperScopeStackView(sniperScope: sniperScopes)
                                            ScrollView(.horizontal, showsIndicators: false) {
                            ///                    SniperScopeStackView(sniperScope: sniperScopes)
                                            }
                                        }
                                    }
                                }
                            }
                            
                        }
                    }
                    
                }
            } actions: {
                Action(tint: .red, icon: "trash", action: {
                    context.delete(item)
                    //WidgetCentrer.shared.reloadAllTimneLines
                })
            }
        }
    }
}
#Preview {
    ItemCardView(item: Item(title: "Sniper Scope Daily Planner", remarks: "A project for a daily planner that allows users to track their progress towards their goals."))
}
