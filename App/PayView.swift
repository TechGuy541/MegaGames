//
//  PayView.swift
//  MegaGames
//
//  Created by Tech Guy on 10/14/24.
//

import SwiftUI
import PassKit

struct DonationView: View {
    let donationAmounts = [5, 10, 20]
    
    @State private var selectedAmount: Int? = nil
    @State private var paymentSucceeded = false
    @State private var paymentError: String?

    var body: some View {
        VStack {
            Text("Support Us!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text("Choose your donation amount:")
                .font(.title2)
            
            // List of donation buttons
            ForEach(donationAmounts, id: \.self) { amount in
                Button(action: {
                    selectedAmount = amount
                    startApplePay(amount: amount)
                }) {
                    Text("Donate €\(amount)")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.vertical, 5)
            }
            
            Spacer()
            
            if paymentSucceeded {
                Text("Payment Succeeded! 🎉")
                    .font(.headline)
                    .foregroundColor(.green)
                    .padding()
            }
            
            if let error = paymentError {
                Text("Error: \(error)")
                    .font(.headline)
                    .foregroundColor(.red)
                    .padding()
            }
        }
    }
    
    func startApplePay(amount: Int) {
        let paymentRequest = PKPaymentRequest()
        paymentRequest.merchantIdentifier = "merchant.dev.techguycodes.megagames" // Your merchant ID
        paymentRequest.supportedNetworks = [.visa, .masterCard, .amex]
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.countryCode = "IE" // Your country code
        paymentRequest.currencyCode = "EUR" // Currency
        paymentRequest.paymentSummaryItems = [
            PKPaymentSummaryItem(label: "Donation", amount: NSDecimalNumber(value: amount))
        ]
        
        guard let paymentVC = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest) else {
            self.paymentError = "Unable to present Apple Pay authorization."
            return
        }
        
        // Set the delegate and handle success/failure
        paymentVC.delegate = ApplePayCoordinator(onCompletion: { success, error in
            if success {
                self.paymentSucceeded = true
            } else {
                self.paymentError = error?.localizedDescription ?? "Payment failed."
            }
        })
        
        // Present the payment view controller using the new approach to get the root view controller
        if let rootViewController = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?.windows
            .first?.rootViewController {
            rootViewController.present(paymentVC, animated: true, completion: nil)
        }
    }
}

// Coordinator to handle Apple Pay payment flow
class ApplePayCoordinator: NSObject, PKPaymentAuthorizationViewControllerDelegate {
    let onCompletion: (Bool, Error?) -> Void

    init(onCompletion: @escaping (Bool, Error?) -> Void) {
        self.onCompletion = onCompletion
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        // Here you would handle the payment (send it to your backend, verify, etc.)
        let success = true // This should be the result of the payment processing logic
        
        if success {
            completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
            onCompletion(true, nil)
        } else {
            completion(PKPaymentAuthorizationResult(status: .failure, errors: nil))
            onCompletion(false, nil)
        }
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

struct DonationView_Previews: PreviewProvider {
    static var previews: some View {
        DonationView()
    }
}

