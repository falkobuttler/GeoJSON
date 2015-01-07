// Feature.swift
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

public final class Feature : GeoJSONEncodable {
    
    /// Private geometry
	private var _geometry: GeoJSON? = nil
    
    /// Public geometry
    public var geometry: GeoJSON? { return _geometry }
    
    /// Public identifier
    public var identifier: String? = nil
    
    /// Private properties
    private var _properties: JSON
    
    /// Public properties
    public var properties: JSON { return _properties }
    
     public init?(json: JSON) {
        
        _properties = json["properties"]
        if _properties.error != nil { return nil }
        
        let jsonGeometry = json["geometry"]
        if jsonGeometry.error != nil { return nil }
        
        if let _ = jsonGeometry.null {
            _geometry = nil
        } else {
            _geometry = GeoJSON(json: jsonGeometry)
            if _geometry?.error != nil { return nil }
            if _geometry?.isGeometry() == false { return nil }
        }
        
        let jsonIdentifier = json["id"]
        identifier = jsonIdentifier.string
    }
	public var prefix : String { return "" }
	public func json() -> AnyObject { return "" }
}

public extension GeoJSON {
    
    /// Optional Polygon
    public var feature: Feature? {
        get {
            switch type {
            case .Feature:
                return object as? Feature
            default:
                return nil
            }
        }
        set {
            _object = newValue ?? NSNull()
        }
    }
}