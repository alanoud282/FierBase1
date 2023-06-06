//
//  SingIn.swift
//  FierbaseAA
//
//  Created by ساره المرشد on 06/06/2023.
//

import SwiftUI
import FirebaseCore
import FirebaseAuth

struct SingIn: View {
    @State private var email = ""
    @State private var password1 = ""
    @State private var password2 = ""
    @State private var phoneNumber = ""

    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $password1)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Confirm Password", text: $password2)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Phone Number", text: $phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            register()
            Button("Submit") {
                register()
            } label: {
                    // إرسال البيانات إلى Firebase Realtime Database
                    let ref = Database.database().reference()
                    ref.child("users").childByAutoId().setValue([
                        "email": email,
                        "password": password1,
                        "phone": phoneNumber
                    ])
                }
            }
        
        func register(){
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if error != nil {
                    print(error!.localizedDescription)
                }
            }
        }
    }
}


struct SingIn_Previews: PreviewProvider {
    static var previews: some View {
        SingIn()
    }
}
