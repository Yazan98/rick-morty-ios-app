//
//  RmRequestUrl.swift
//  RM Client
//
//  Created by Yazan Tarifi on 01/09/2023.
//

import Foundation

public final class RmRequestUrl {
    
    public static let shared = RmRequestUrl()
    
    private init() {}
    
    public func getEpisodsList() -> String {
        return "\(getBaseUrl())episode"
    }
    
    public func getCharacters() -> String {
        return "\(getBaseUrl())character"
    }
    
    public func getCharactersById(id: Int64) -> String {
        return "\(getBaseUrl())character/\(id)"
    }
    
    private func getBaseUrl() -> String {
        return "https://rickandmortyapi.com/api/"
    }
    
}
