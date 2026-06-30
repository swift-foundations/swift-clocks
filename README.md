# swift-clocks

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Bundles the `Clock` family — continuous, suspending, test, immediate, and unimplemented — with the platform time source that backs `Clock.Continuous` and `Clock.Suspending` and conforms them to Swift's concurrency `Clock` protocol.

---

## Key Features

- **OS-backed monotonic clocks** — `Clock.Continuous` and `Clock.Suspending` read the platform monotonic time source: `CLOCK_MONOTONIC_RAW` / `CLOCK_UPTIME_RAW` on Darwin, `CLOCK_BOOTTIME` / `CLOCK_MONOTONIC` on Linux, and the equivalent on Windows.
- **Swift concurrency conformance** — the continuous and suspending clocks conform to `_Concurrency.Clock`, so they drive `sleep(until:tolerance:)` and the standard scheduling surface.
- **Phantom-tagged instants** — a continuous-clock instant and a suspending-clock instant are distinct types; mixing them is a compile error, not a runtime bug.
- **Deterministic test clock** — `Clock.Test` advances only when you tell it to, running time-dependent code with no real delays.
- **Preview and proof clocks** — `Clock.Immediate` collapses every sleep to an instant; `Clock.Unimplemented` traps if any endpoint is touched.
- **Saturating deadlines** — `Clock.Continuous.Deadline` clamps overflowing offsets to `.never` rather than wrapping.
- **Single import** — `import Clocks` re-exports the full clock family together with its platform backing.

---

## Quick Start

```swift
import Clocks

// `Clock.Continuous` reads the operating system's monotonic clock.
let clock = Clock.Continuous()
let start = clock.now
// ... perform work ...
let elapsed: Duration = start.duration(to: clock.now)

// It conforms to Swift's concurrency `Clock`, so it drives `sleep`:
try await clock.sleep(until: start.advanced(by: .milliseconds(50)))

// In tests, swap in `Clock.Test` — time advances only when you say so:
let test = Clock.Test()
test.advance(by: .seconds(5))
print(test.now.offset)   // .seconds(5)
```

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-foundations/swift-clocks.git", branch: "main")
]
```

```swift
.target(
    name: "YourTarget",
    dependencies: [
        .product(name: "Clocks", package: "swift-clocks"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Community

<!-- BEGIN: discussion -->
*Discussion thread will be created at first public flip.*
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE](LICENSE.md).
