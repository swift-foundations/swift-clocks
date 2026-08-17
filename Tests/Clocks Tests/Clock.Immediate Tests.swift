// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-clocks open source project
//
// Copyright (c) 2025 Coen ten Thije Boonkkamp and the swift-clocks project authors
// Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

import Clocks
import Testing

@Suite
struct `Clock.Immediate` {
    @Test
    func `sleeping until a deadline adopts that deadline as now`() async throws {
        let clock = Clock.Immediate()
        let deadline = clock.now.advanced(by: .seconds(5))

        try await clock.sleep(until: deadline)

        #expect(clock.now == deadline)
    }

    @Test
    func `a fresh clock reports the instant it was created with`() {
        let start = Clock.Immediate.Instant().advanced(by: .seconds(3))
        let clock = Clock.Immediate(now: start)

        #expect(clock.now == start)
    }
}
