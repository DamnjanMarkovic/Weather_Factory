//
//  CustomListener.swift
//  FactoryWeather
//
//  Created by Damnjan Markovic on 10.12.21..
//

import Foundation

final class CustomListener<T> {
    
      typealias Listener = (T) -> Void
        
      var listener: Listener?
        
      var value: T {
            didSet {
                listener?(value)
            }
      }
        
      init(_ value: T) {
          self.value = value
      }
        
      func bind(listener: Listener?) {
            self.listener = listener
            listener?(value)
      }
}
