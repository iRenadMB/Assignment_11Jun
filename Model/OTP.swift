

import SwiftUI
import Firebase

struct OTP: View {
    @State private var phoneNumber = ""
    @State private var verificationCode = ""
    @State private var isEditing = false
    @State private var isCodeSent = false
    @State private var errorMessage = ""

    var body: some View {
        VStack {
            if !isCodeSent {
                TextField("رقم الجوال", text: $phoneNumber, onEditingChanged: { editing in
                    isEditing = editing
                })
                    .keyboardType(.phonePad)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding()
                
                Button(action: {
                    sendVerificationCode()
                }, label: {
                    Text("إرسال رمز التحقق")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                })
                .disabled(phoneNumber.count < 10)
                .opacity(phoneNumber.count < 10 ? 0.5 : 1)
            } else {
                TextField("رمز التحقق", text: $verificationCode)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                    .padding()

                Button(action: {
                    verifyCode()
                }, label: {
                    Text("التحقق")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                })

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
            }
        }
        .navigationBarTitle("تسجيل الدخول")
    }

    func sendVerificationCode() {
        let phoneNumber = "+966" + self.phoneNumber // Add country code

        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if let error = error {
                print("Error sending verification code: \(error.localizedDescription)")
                errorMessage = "حدث خطأ أثناء إرسال رمز التحقق"
                return
            }

            guard let verificationID = verificationID else {
                print("Error getting verification ID")
                errorMessage = "حدث خطأ أثناء إرسال رمز التحقق"
                return
            }

            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            isCodeSent = true
        }
    }

    func verifyCode() {
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") ?? ""
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)

        Auth.auth().signIn(with: credential) { _, error in
            if let error = error {
                print("Error signing in: \(error.localizedDescription)")
                errorMessage = "حدث خطأ أثناء التحقق"
                return
            }

            // User is signed in
            print("User signed in")
        }
    }
}

struct OTP_Previews: PreviewProvider {
    static var previews: some View {
        OTP()
    }
}
