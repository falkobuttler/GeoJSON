// Point.swift
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

public final class Point : Equatable {
	
	/// Private var to store coordinates
	private var coordinates : [Double] = [0.0, 0.0]
	
	/// Shortcut property to latitude
	public var latitude: Double { return coordinates[1] }
	/// Shortcut property to northing
	public var northing: Double { return coordinates[1] }
	/// Shortcut property to longitude
	public var longitude: Double { return coordinates[0] }
	/// Shortcut property to easting
	public var easting: Double { return coordinates[0] }
	/// Shortcut property to altitude
	public var altitude: Double { return coordinates[2] }
	
	
	public init?(json: JSON) {
		if let jsonCoordinates =  json.array {
			if jsonCoordinates.count < 2 { return nil }
			
			coordinates = jsonCoordinates.map {
				Double($0.doubleValue)
			}
		}
		else {
			return nil
		}
	}
}

/// Array forwarding methods
public extension Point {
	
	public var count : Int { return coordinates.count }
	
	public subscript(index: Int) -> Double {
		get { return coordinates[index] }
		set(newValue) { coordinates[index] = newValue }
	}
}

public func ==(lhs: Point, rhs: Point) -> Bool {

	if lhs.count != rhs.count { return false }
	
	for index in 0..<lhs.count {
		if lhs[index] != rhs[index] {
			return false
		}
	}
	
	return true
}

public extension GeoJSON {
	
	/// Optional Point
	public var point: Point? {
		switch type {
		case .Point:
			return object as? Point
		default:
			return nil
		}
	}
}