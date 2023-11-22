//
//  URLSession.swift
//  EmpleadosAPI
//
//  Created by Yery Castro on 19/11/23.
//

import Foundation
/*:
 2ª capa. URLSession
 */

public extension URLSession {
    // función para devolver el data, ya directamente casteado el HTTPURLResponse
    func getData(from url: URL, delegate: (URLSessionTaskDelegate)? = nil) async throws -> (Data, HTTPURLResponse) {
        do {
            // Si el try await da un error, se captura en el catch.
            let (data, response) = try await URLSession.shared.data(from: url, delegate: delegate)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.noHTTP// Devuelve mi propio error
            }
            return (data, response)// Devuelve la tupla de data y response
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.general(error)
        }
    }
    
    func getData(for url: URLRequest, delegate: (URLSessionTaskDelegate)? = nil) async throws -> (Data, HTTPURLResponse) {
        do {
            let (data, response) = try await URLSession.shared.data(for: url, delegate: delegate)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.noHTTP
            }
            return (data, response)
        } catch let error as NetworkError {
            throw error
        } catch {
            throw NetworkError.general(error)
        }
    }
}
