New-ComponentPage -Title 'Map' -Description 'Creates an interactive map' -Content {
    New-Example -Title 'Basic Map' -Description '' -Example {
New-UDMap -Endpoint {
    New-UDMapRasterLayer -TileServer 'https://tiles.wmflabs.org/bw-mapnik/{z}/{x}/{y}.png' 
} -Latitude 43.52107 -Longitude -114.31644 -Zoom 13 -Height '100vh'
    }

    New-Example -Title 'Map with layers' -Example {
New-UDMap -Endpoint {
    New-UDMapLayerControl -Content {
        New-UDMapBaseLayer -Name 'Black and White' -Content {
            New-UDMapRasterLayer -TileServer 'https://tiles.wmflabs.org/bw-mapnik/{z}/{x}/{y}.png' 
        } -Checked
        New-UDMapBaseLayer -Name 'Color' -Content {
            New-UDMapRasterLayer -TileServer 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png' 
        }
        New-UDMapOverlay -Name 'Marker' -Content {
            New-UDMapMarker -Latitude 51.505 -Longitude -0.09 
        } -Checked
        New-UDMapOverlay -Name 'Marker 2' -Content {
            New-UDMapMarker -Latitude 51.555 -Longitude -0.00 
        } -Checked
    }
} -Latitude 51.505 -Longitude -0.09 -Zoom 13 -Height '100vh'
    }

New-Example -Title 'Heatmap' -Example {
New-UDMap -Endpoint {
    New-UDMapRasterLayer -TileServer 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png' 
    New-UDMapHeatmapLayer -Points @(
        @(-37.9019339833, 175.3879181167, "625"),
        @(-37.90920365, 175.4053418167, "397"),
        @(-37.9057407667, 175.39478875, "540"),
        @(-37.9243174333, 175.4220341833, "112"),
        @(-37.8992012333, 175.3666729333, "815"),
        @(-37.9110874833, 175.4102195833, "360"),
        @(-37.9027096, 175.3913196333, "591"),
        @(-37.9011183833, 175.38410915, "655"),
        @(-37.9234701333, 175.4155696333, "181"),
        @(-37.90254175, 175.3926162167, "582"),
        @(-37.92450575, 175.4246711167, "90"),
        @(-37.9242924167, 175.4289432833, "47"),
        @(-37.8986079833, 175.3685293333, "801")
    )
} -Height '100vh'
}

New-Example -Title 'Marker Clusters' -Example {
New-UDMap -Endpoint {
    New-UDMapRasterLayer -TileServer 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png' 
    New-UDMapMarkerClusterLayer -Id 'cluster-layer' -Markers @(
        1..100 | ForEach-Object {
            $Random = Get-Random -Minimum 0 -Maximum 100
            $RandomLat = $Random + 400
            New-UDMapMarker -Latitude "51.$RandomLat" -Longitude "-0.$Random"
        }
    )
} -Latitude 51.505 -Longitude -0.09 -Zoom 13 -Height '100vh'
}

} -Cmdlet @("New-UDMap")