//: Playground - noun: a place where people can play
import Foundation

var _vertices: Set<Vertex> = Set()

func createNotConnectedVertices() {
    //change this value to increase or decrease amount of vertices in the graph
    let numberOfVerticesInGraph = 15
    for i in 0..<numberOfVerticesInGraph {
        let vertex = Vertex(identifier: "\(i)")
        _vertices.insert(vertex)
    }
}

func setupConnections() {
    for vertex in _vertices {
        let randomEdgesCount = arc4random_uniform(4) + 1
        for _ in 0..<randomEdgesCount {
            let randomWeight = Double(arc4random_uniform(10))
            let neighborVertex = randomVertex(except: vertex)
            if vertex.neighbors.contains(where: { $0.0 == neighborVertex }) {
                continue
            }
            let neighbor1 = (neighborVertex, randomWeight)
            let neighbor2 = (vertex, randomWeight)
            vertex.neighbors.append(neighbor1)
            neighborVertex.neighbors.append(neighbor2)
        }
    }
}

func randomVertex(except vertex: Vertex) -> Vertex {
    var newSet = _vertices
    newSet.remove(vertex)
    let offset = Int(arc4random_uniform(UInt32(newSet.count)))
    let index = newSet.index(newSet.startIndex, offsetBy: offset)
    return newSet[index]
}

func randomVertex() -> Vertex {
    let offset = Int(arc4random_uniform(UInt32(_vertices.count)))
    let index = _vertices.index(_vertices.startIndex, offsetBy: offset)
    return _vertices[index]
}

//initialize random graph
createNotConnectedVertices()
setupConnections()

//initialize Dijkstra algorithm with graph vertices
let dijkstra = Dijkstra(vertices: _vertices)

//decide which vertex will be the starting one
let startVertex = randomVertex()

//ask algorithm to find shortest paths from start vertex to all others
dijkstra.findShortestPaths(from: startVertex)

//printing results
let destinationVertex = randomVertex(except: startVertex)
print(destinationVertex.pathLengthFromStart)
var pathVerticesFromStartString: [String] = []
for vertex in destinationVertex.pathVerticesFromStart {
    pathVerticesFromStartString.append(vertex.identifier)
}
print(pathVerticesFromStartString.joined(separator: "->"))


