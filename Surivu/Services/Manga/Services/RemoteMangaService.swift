//
//  RemoteMangaService.swift
//  Surivu
//
//  Created by Rodolfo Ramirez on 20/09/25.
//
import Foundation
import SwiftUI

struct RemoteMangaService: MangaService {
    let networkService: NetworkService
    
    func getMangasBy(title: String, limit: String) async throws -> [MangaDetail] {
        let mangaEntities: [MangaEntity] = try await networkService.makeNetworkRequest(
            endpoint: "\(Endpoints.mangas)?limit=\(limit)&title=\(title)",
            responseType: MangaEntity.self
        )
        return try await withThrowingTaskGroup(of: MangaDetail.self) { group in
            for mangaEntity in mangaEntities {
                group.addTask {
                    let coverEntity: CoverEntity = try await getCover(coverArtId: mangaEntity.relationships.first(where: {$0.type == .coverArt})?.id ?? "")
                    return await MangaDetail(
                        id: mangaEntity.id,
                        coverId: coverEntity.id,
                        title: mangaEntity.attributes.title?.en ?? "",
                        description: mangaEntity.attributes.description?.en ?? "",
                        coverUrl: "\(Endpoints.coversImageUrl)/\(mangaEntity.id)/\(coverEntity.attributes.fileName)"
                    )
                }
            }
            
            var details: [MangaDetail] = []
            for try await detail in group {
                details.append(detail)
            }
            return details
        }
    }
    
    func getCover(coverArtId: String) async throws -> CoverEntity {
        return try await networkService.makeAuthNetworkRequest(endpoint: "\(Endpoints.cover)/\(coverArtId)", responseType: CoverEntity.self)
        
    }
    
    func getManga(mangas: [MangaDetail]?, id: String) async throws -> MangaDetail {
        return mangas?.first(where: {$0.id == id}) ?? MangaDetail.mock
    }
}
