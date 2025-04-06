import SwiftUI

struct LunchView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @State private var selectedWeek = 0
    @State private var showDietaryFilters = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Picker("Week", selection: $selectedWeek) {
                        Text("This Week").tag(0)
                        Text("Next Week").tag(1)
                    }
                    .pickerStyle(.segmented)
                }
                
                ForEach(getWeeklyMenu(), id: \.date) { day in
                    Section(day.date.formatted(.dateTime.weekday().day().month())) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text(day.mainCourse)
                                .font(.headline)
                            if !day.sideDish.isEmpty {
                                Text(day.sideDish)
                                    .font(.subheadline)
                            }
                            if !day.vegetarian.isEmpty {
                                Text("Vegetarian: \(day.vegetarian)")
                                    .font(.subheadline)
                                    .foregroundColor(.green)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Lunch Menu")
            .toolbar {
                Button {
                    showDietaryFilters.toggle()
                } label: {
                    Image(systemName: "slider.horizontal.3")
                }
            }
            .sheet(isPresented: $showDietaryFilters) {
                DietaryFilterView()
            }
        }
    }
    
    private struct DayMenu {
        let date: Date
        let mainCourse: String
        let sideDish: String
        let vegetarian: String
    }
    
    private func getWeeklyMenu() -> [DayMenu] {
        // Mock data
        return [
            DayMenu(date: Date(), mainCourse: "Meatballs with mashed potatoes", 
                   sideDish: "Lingonberry jam", vegetarian: "Veggie balls"),
            DayMenu(date: Date().addingTimeInterval(86400), 
                   mainCourse: "Fish and chips", sideDish: "Remoulade", 
                   vegetarian: "Veggie fish")
        ]
    }
}

struct DietaryFilterView: View {
    @Environment(\.dismiss) var dismiss
    @State private var vegetarian = false
    @State private var glutenFree = false
    @State private var lactoseFree = false
    
    var body: some View {
        NavigationView {
            List {
                Toggle("Vegetarian", isOn: $vegetarian)
                Toggle("Gluten-free", isOn: $glutenFree)
                Toggle("Lactose-free", isOn: $lactoseFree)
            }
            .navigationTitle("Dietary Preferences")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Done") {
                    dismiss()
                }
            }
        }
    }
}
