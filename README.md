# Roadmap
Publish your roadmap inside your app and allow users to vote for upcoming features

## Example
<HIDDE_TO_SHOW_IMAGE>

## Setting up Roadmap
### Create a Roadmap JSON
Roadmap works with a remote JSON configuration listing all features and their statuses. We recommend hosting it at [simplejsoncms.com](https://simplejsoncms.com/).

An example JSON looks as follows:

```json
[
    {
        "id": "1",
        "title": "Combine sentences",
        "status": "planned"
    },
    {
        "id": "2",
        "title": "Open with Finder support",
        "status": "planned"
    }
]
```

The keys `id`, `title` and `status` are mandatory and all have to be strings. You can use any value for `status`.

### Add Roadmap using Swift Package Manager

Add `https://github.com/AvdLee/Roadmap.git` within Xcode's package manager.

### Create a Roadmap Configuration instance

Create a new Roadmap configuration following the documentation:

```swift
public struct RoadmapConfiguration {
    /// The URL pointing to the JSON in the `Roadmap` format.
    public let roadmapJSONURL: URL

    /// A unique namespace to use matching your app.
    /// See `https://countapi.xyz/` for more information.
    /// Recommended: your bundle identifier.
    public let namespace: String

    public init(roadmapJSONURL: URL, namespace: String) {
        self.roadmapJSONURL = roadmapJSONURL
        self.namespace = namespace
    }
}
```

For example:

```swift
let configuration = RoadmapConfiguration(
    roadmapJSONURL: URL(string: "https://simplejsoncms.com/api/vq2juq1xhg")!,
    namespace: "roadmaptest"
)
```

### Use the configuration to construct the view
And use the configuration inside the `RoadmapView`:

```swift
struct ContentView: View {
    let configuration = RoadmapConfiguration(
        roadmapJSONURL: URL(string: "https://simplejsoncms.com/api/vq2juq1xhg")!,
        namespace: "roadmaptest"
    )

    var body: some View {
        RoadmapView(configuration: configuration)
    }
}
```

## FAQ
### How does Roadmap store votes?
We make use of the [Free Counting API](https://countapi.xyz/)

### Why can't I open issues?
Since we'd love to invite you to contribute directly with a pull request. Join us in making this project a success!

## Projects using Roadmap
- [MacWhisper](https://goodsnooze.gumroad.com/l/macwhisper)
- [RocketSim](https://www.rocketsim.app)

## Authors
This library is created in collaboration between [Jordi Bruin](https://twitter.com/jordibruin), [Hidde van der Ploeg](https://twitter.com/hiddevdploeg), and [Antoine van der Lee](https://www.twitter.com/twannl)

## License

Roadmap is available under the MIT license. See the LICENSE file for more info.

