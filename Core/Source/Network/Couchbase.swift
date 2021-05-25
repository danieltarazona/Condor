//
//  CouchbaseDB.swift
//  Core
//
//  Created by Daniel Tarazona on 5/18/21.
//

import Foundation
import CouchbaseLiteSwift
import CouchbaseLiteSwiftCoder

class Couchbase {
    private var database: Database?
    private var name: String = ""
    
    init(name: String) {
        self.name = name
        connect(name: name)
        preload()
    }
    
    func connect(name: String) {
        let tempFolder = NSTemporaryDirectory().appending("cbllog")
        let config = LogFileConfiguration(directory: tempFolder)
        config.usePlainText = true
        config.maxSize = 1024
        Database.log.file.config = config
        Database.log.file.level = .info
        
        do {
            DispatchQueue.main.async {
                if let database = try? Database(name: "PokeDex") {
                    self.database = database
                }
            }
        }
    }
    
    func preload() {
        let path = Bundle.main.path(forResource: name, ofType: "cblite2")
        if !Database.exists(withName: name) {
            do {
                if let path = path, !path.isEmpty {
                    try Database.copy(fromPath: path, toDatabase: name, withConfig: nil)

                }
            } catch {
                print(error)
            }
        }
    }
    
    func close() {
        do {
            try database?.close()
        } catch {
            print(error)
        }
    }
    
    func exist(id: String) -> Bool {
        if database?.document(withID: id) != nil {
            return true
        }
        return false
    }
    
    func createIndex(name: String, with items: [ValueIndexItem]) {
        do {
            let index = IndexBuilder.valueIndex(items: items)
            try database?.createIndex(index, withName: name)
            
        } catch let error as NSError {
            print("Couldn't create index \(items): %@", error);
        }
    }
    
    func queryIndex<T: Storable>(type: T.Type, selection: [SelectResultAs] = [], limit: Int = 100) -> [T]? {
        guard let database = database else { return nil }
        
        let query = QueryBuilder
            .select(selection)
            .from(DataSource.database(database))
            
        print("QUERY", query)
        
        do {
            let result = try query.execute().decode(as: T.self)
            print("GET ALL \(T.self)")
            return result
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func queryAll<T: Storable>(type: T.Type, limit: Int = 100) -> [T]? {
        guard let database = database else { return nil }
        let objectMirror = Mirror(reflecting: T.init())
        
        let query = QueryBuilder
            .select(
                objectMirror.children.compactMap({ label, value in
                    if label == "$__lazy_storage_$_document" ||
                        label == "$__lazy_storage_$_spritesFormatted" ||
                        label == "document" {
                        return nil
                    }
                    return SelectResult.property(label ?? "")
                })
            )
            .from(DataSource.database(database))
            .limit(Expression.int(limit))
        
        print("QUERY", query)
        
        do {
            let result = try query.execute().decode(as: T.self)
            print("GET ALL \(T.self)")
            return result
        } catch {
            print(error)
        }
        return nil
    }
    
    func save<T: MutableDocument>(_ document: T) {
        guard let database = database else { return }
        
        
        guard !exist(id: document.id) else {
            print("Already \(T.self) \(document.id)");
            return
        }
        
        do {
            try database.saveDocument(document)
            print("Saved \(T.self) \(document.id)");
        } catch {
            print(error)
        }
    }
    
    func save<T: Storable>(_ object: T) {
        guard let database = database else { return }
        guard let document = object.document else { return }
        
        guard !exist(id: document.id) else {
            print("Already \(T.self) \(document.id)");
            return
        }
        
        do {
            try object.save(into: database)
            print("Saved \(T.self) \(document.id)");
        } catch {
            print(error)
        }
    }
    
    func update<T: Storable>(_ document: MutableDocument, type: T.Type) {
        guard let database = database else { return }
        
        do {
            try database.saveDocument(document)
            print("Updated \(T.self)");
        } catch {
            print(error)
        }
    }
    
   
    
    func createImageBlob(data: Data) -> Blob {
        return Blob(contentType: "image/jpeg", data: data)
    }
    
    func getBlobData(name: String) -> Data? {
        if let data = queryBy(id: name, type: ImageBlob.self)?.blob?.content {
            return data
        }
        return nil
    }

    func queryAllBy<T: Storable>(id: String, type: T.Type) -> [T]? {
        guard !id.isEmpty else { return nil }
        
        let result = queryAll(type: T.self)
        return result
    }

    func queryBy<T: Storable>(id: String, type: T.Type) -> T? {
        guard !id.isEmpty else { return nil }
        
        do {
            return try self.database?.document(withID: id, as: T.self)
        } catch {
            print(error)
        }
        return nil
    }
    
    func queryBy<T: Storable>(id: String, type: T.Type, limit: Int = 100) -> [T]? {
        guard let database = database else { return nil }
        guard !id.isEmpty else { return nil }
        
        let query = QueryBuilder
            .select(
                SelectResult.all()
            )
            .from(DataSource.database(database))
            .where(ID.equalTo(Expression.string(id)))
        
        print("QUERY", query)
        
        do {
            let result = try query.execute().decode(as: T.self)
            print("GET \(T.self)")
            return result
        } catch {
            print(error)
        }
        return nil
    }
    
    func queryBy<T: Storable>(expression: ExpressionProtocol, type: T.Type) -> [T]? {
        guard let database = database else { return nil }
        let query = QueryBuilder
            .select(
                SelectResult.all()
            )
            .from(DataSource.database(database))
            .where(expression)
        
        print("QUERY", query)
        
        do {
            return try query.execute().decode(as: T.self)
        } catch {
            print(error)
        }
        return nil
    }
    
    func delete(document: MutableDocument) {
        guard let database = database else { return }
        
        do {
            try database.deleteDocument(document, concurrencyControl: .failOnConflict)
        } catch {
            print(error)
        }
    }

}

