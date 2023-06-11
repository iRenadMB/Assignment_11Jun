//
//import SwiftUI
//import FirebaseFirestore
//
//struct SearchView: View {
//    @State private var searchText = ""
//    @State private var results = Person
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(results) { person in
//                    Text(person.name)
//                }
//            }
//            .searchable(text: $searchText, placement: .navigationBar) {
//                if searchText.isEmpty {
//                    results = []
//                } else {
//                    let db = Firestore.firestore()
//                    db.collection("people").whereField("name", isEqualTo: searchText).getDocuments { snapshot, error in
//                        if let error = error {
//                            print(error)
//                        } else {
//                            if let documents = snapshot?.documents {
//                                results = documents.compactMap { document in
//                                    var person = Person()
//                                    person.id = document.documentID
//                                    person.name = document.data()["name"] as! String
//                                    return person
//                                }
//                            }
//                        }
//                    }
//                }
//            }
//            .navigationBarTitle("Search")
//        }
//    }
//
//}
//
//struct Person: Identifiable {
//let id: String
//let name: String
//}
