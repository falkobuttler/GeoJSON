// GeometryCollection.swift
//
// The MIT License (MIT)
//
// Copyright (c) 2014 Raphaël Mor
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation

public final class GeometryCollection : GeoJSONEncodable {
    
    /// Private var to store geometries
    private var _geometries: [GeoJSON] = []

    /// Public geometries
    public var geometries: [GeoJSON] { return _geometries }
    
    public init?(json: JSON) {
        if let jsonGeometries =  json.array {
            _geometries = jsonGeometries.map { jsonObject in
                return GeoJSON(json: jsonObject)
                } ?? []
            
            let validGeometries = _geometries.filter { geoJSON in
                return geoJSON.type != .Unknown
            }
            
            if validGeometries.count != _geometries.count {
                return nil
            }
        } else {
            return nil
        }
    }
	public var prefix : String { return "" }
	public func json() -> AnyObject { return "" }
}

/// Array forwarding methods
public extension GeometryCollection {
    
    public var count : Int { return geometries.count }
    
    public subscript(index: Int) -> GeoJSON {
        get { return geometries[index] }
        set(newValue) { _geometries[index] = newValue }
    }
}

public extension GeoJSON {
    
    /// Optional MultiPolygon
    public var geometryCollection: GeometryCollection? {
        get {
            switch type {
            case .GeometryCollection:
                return object as? GeometryCollection
            default:
                return nil
            }
        }
        set {
            _object = newValue ?? NSNull()
        }
    }
}