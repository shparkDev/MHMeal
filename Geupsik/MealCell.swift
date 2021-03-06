//
//  MealCell.swift
//  Geupsik
//
//  Created by 박성헌 on 2020/02/02.
//  Copyright © 2020 n30gu1. All rights reserved.
//

import SwiftUI

struct MealCell: View {
    @ObservedObject var data = GetData()
    @State var showDetails = false
    let selDate: Date
    
    init(date: Date, selectedDate: Date) {
        self.selDate = selectedDate
        data.date = date
        data.getData(date: date, image: false)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 0) {
                Text(data.date.format())
                    .tracking(0.9)
                    .font(.footnote)
                    .bold()
                    .padding(.horizontal, 5)
                if data.date.format() == Date().format() {
                    Text("Today")
                        .tracking(0.9)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                Spacer()
                Text("Show Details ")
                    .tracking(0.9)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .bold()
                Text("▾")
                    .font(.system(size: 28))
                    .frame(height: 3)
                    .padding([.bottom, .trailing], 5)
                    .foregroundColor(.gray)
            }
            ZStack {
                Rectangle()
                    .foregroundColor(Color(white: 0, opacity: 0))
                if data.mealIsLoaded {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(data.meal!)
                            Spacer()
                        }
                        Spacer()
                        VStack {
                            Spacer()
                            HStack(spacing: 1) {
                                Text(data.kcal!)
                                    .font(.system(size: 22))
                                    .bold()
                                Text("kcal")
                                    .padding(.bottom, -3)
                            }
                        }
                    }
                    .padding(5)
                } else {
                    VStack {
                        ProgressView() {
                            Text("Loading")
                        }
                    }
                }
            }
        }
        .frame(height: data.date.format() == self.selDate.format() ? 300 : 150)
        .onTapGesture {
            if self.data.mealIsLoaded {
                self.showDetails.toggle()
            }
        }
        .sheet(isPresented: self.$showDetails) {
            ShowDetailsView(data: self.data)
        }
    }
}
struct MealCell_Previews: PreviewProvider {
    static var previews: some View {
        MealCell(date: Date(), selectedDate: Date())
            .previewLayout(.fixed(width: 375, height: 300))
    }
}
