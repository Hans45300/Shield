# Shield \- AI Development Charter

## Purpose

This document defines the non\-negotiable architectural, technical and design principles governing the development of Shield.

All AI agents, contributors and automated systems must follow these rules.

When a local optimization, shortcut or feature request conflicts with this charter, the charter always takes precedence.

---

# Project Mission

Shield is a modern Virtual Analog synthesizer built around a unified Shape Engine.

The project is designed to provide:

- immediate visual feedback
- direct waveform manipulation
- unified modulation concepts
- high\-performance real\-time processing
- long\-term maintainability

Shield is not a collection of independent features.

Shield is a coherent architecture.

Every contribution must reinforce that architecture.

---

# Fundamental Principles

## Shape Engine First

The Shape Engine is the core abstraction of the project.

Before introducing any new DSP feature, evaluate whether it can be implemented as:

- a Shape Processor
- a Shape Generator
- a Shape Engine extension

Feature\-specific implementations should be avoided whenever possible.

---

## Unified Concepts

Oscillators, LFOs, modulation generators and future shape\-based systems must share:

- common concepts
- common interfaces
- common visual representations
- common interaction models

Do not create isolated systems that duplicate existing concepts.

---

## Architecture Before Convenience

The architecture must never be compromised for implementation convenience.

Forbidden:

- shortcuts bypassing existing layers
- temporary hacks becoming permanent
- duplicated logic
- feature\-specific exceptions

Prefer architectural consistency over short\-term development speed.

---

# Real\-Time Safety

## Mandatory Rules

Code executed in the audio thread must never:

- allocate memory
- deallocate memory
- acquire locks
- access the filesystem
- perform network operations
- block execution
- wait on synchronization primitives

Forbidden examples:

- new
- delete
- malloc
- free
- std::mutex
- std::lock\_guard
- std::filesystem
- fopen
- std::ofstream

inside audio processing paths.

---

## Deterministic Processing

The audio engine must produce deterministic results.

Avoid:

- hidden state changes
- non\-reproducible randomness
- timing\-dependent behavior

Sources of randomness must be explicitly controlled.

---

## Lock\-Free Communication

Cross\-thread communication must use:

- lock\-free queues
- immutable snapshots
- atomics when appropriate

Audio processing must never depend on UI timing.

---

# DSP Rules

## DSP First

Audio quality and stability always take precedence over UI requirements.

UI features must never degrade DSP performance.

---

## SIMD First

All new DSP algorithms must be designed with vectorization in mind.

Developers and AI agents should:

- favor contiguous memory
- favor cache\-friendly structures
- minimize branching
- use xsimd\-compatible patterns

Algorithms that cannot be vectorized should provide a clear justification.

---

## Audio\-Rate Awareness

Parameters supporting audio\-rate modulation must be explicitly identified.

Implementations must not silently downgrade audio\-rate modulation to control\-rate operation.

Current audio\-rate targets include:

- pitch
- phase
- phase stretch
- bend
- fold
- filter cutoff

---

## No Hidden DSP

DSP processing must be traceable and understandable.

Avoid:

- magic constants
- undocumented formulas
- implicit signal flows

All DSP decisions should be documented.

---

# Modulation Rules

## Centralized Resolution

Modulation resolution belongs exclusively to the Modulation Engine.

DSP modules must receive resolved values.

DSP modules must not perform modulation routing.

---

## Universal Modulation

Whenever technically reasonable:

- parameters are modulatable
- modulation behaves consistently
- modulation uses common infrastructure

Exceptions must be documented.

---

## Modulation Consistency

The same source must behave identically regardless of destination.

Routing logic must not introduce feature\-specific behaviors.

---

# UI Rules

## Strict Separation

UI and DSP are fully separated systems.

UI components must never:

- access DSP internals
- read audio engine state directly
- perform DSP computations

---

## Snapshot Only

Visualizations must use only published snapshots.

Examples:

- waveform snapshots
- filter snapshots
- modulation snapshots
- voice snapshots

The UI never interrogates the DSP engine directly.

---

## Vector First

Graphical components should prioritize:

- JUCE Paths
- SVG assets
- vector rendering

Avoid bitmap dependencies whenever possible.

---

## Visual Consistency

Every graphical element should follow the project's design principles:

- visual clarity
- direct manipulation
- minimal textual clutter
- consistent interaction patterns

---

# Parameter System Rules

## Single Source of Truth

Every parameter must exist only once.

Parameter values originate from the Parameter Store.

Do not duplicate parameter states.

---

## Unique Identification

Each parameter must have:

- stable identifier
- category
- default value
- minimum value
- maximum value
- display unit

Identifiers must remain stable across versions whenever possible.

---

## Serialization Safety

Parameters must support:

- serialization
- deserialization
- migration

Parameter renaming requires migration tools.

---

# Preset Compatibility Rules

## Compatibility First

Breaking preset compatibility is considered a major architectural event.

Avoid it whenever possible.

---

## Versioning

Preset formats must include:

- preset version
- schema version
- migration path

---

## Safe Loading

Unknown parameters:

- must not crash loading
- should be preserved whenever possible
- should be ignored safely

---

## Migration

Changes requiring preset migration must include:

- migration logic
- migration tests
- documentation updates

---

# Testing Rules

## Tests Are Mandatory

New functionality is incomplete without tests.

Every feature should include:

- functional tests
- serialization tests when applicable
- migration tests when applicable

---

## Regression Prevention

When fixing a bug:

1. reproduce the bug
2. add a failing test
3. fix the bug
4. validate the test

Avoid fixes without regression coverage.

---

# Code Quality Rules

## Readability Over Cleverness

Prefer:

- simple code
- explicit behavior
- maintainable solutions

Avoid unnecessary complexity.

---

## Self\-Documenting Code

Code should be understandable without excessive comments.

Comments should explain:

- why

not:

- what

unless absolutely necessary.

---

## Duplicate Logic

Do not duplicate behavior.

Extract reusable systems whenever appropriate.

---

# Dependency Rules

## Default Technology Stack

Core technologies:

- C\+\+20
- JUCE
- xsimd
- CMake

Core libraries:

- fmt
- spdlog
- nlohmann/json
- moodycamel::ConcurrentQueue
- Catch2
- cpptrace

---

## Dependency Justification

Every new dependency must provide significant value.

Before introducing a dependency:

- evaluate maintenance impact
- evaluate portability
- evaluate build complexity
- evaluate long\-term support

---

# Platform Support

Supported platforms:

- Windows
- macOS
- Linux

Supported formats:

- VST3
- AU (macOS)

All new code should be developed with cross\-platform compatibility in mind.

Platform\-specific code must be isolated whenever possible.

---

# Definition of Done

A task is considered complete only if:

- builds successfully
- passes all tests
- introduces no new warnings
- preserves architecture rules
- preserves real\-time safety
- includes documentation updates when required
- includes migration logic when required
- includes automated tests when required

Feature implementation alone is not sufficient.

---

# Final Rule

Whenever uncertainty exists, prioritize:

1. Real\-time safety
2. Architectural consistency
3. Shape Engine integration
4. Maintainability
5. Feature completeness

Shield must remain a coherent system.

No contribution should sacrifice long\-term architecture for short\-term convenience.

