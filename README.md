# Typst_Template
# Personal Typst Templates

This repository serves as a centralized collection of [Typst](https://typst.app/) templates and configurations, designed to be used as a Git submodule in various academic or personal projects.

It consolidates common packages, Japanese language settings, and custom mathematical macros into a single, reusable library.

## Features

* **Japanese Optimization**: Pre-configured fonts (`Harano Aji Mincho`) and paragraph settings (justification, indentation) for Japanese documents.
* **Math Ready**: Includes `@preview/physica`, `@preview/unify`, and custom setups for equations.
* **Diagrams**: Pre-loaded with `@preview/cetz`.
* **Custom Macros**: Useful shortcuts for answer boxes, definitions, and distinct formatting.
* **Flexible Numbering**: Switch between standard `(1)` and textbook-style `(6.5.1)` equation numbering easily.

## Installation

To use this template in your Typst project, add it as a Git submodule.

Run the following command in your project root:

```bash
mkdir -p lib
git submodule add <URL_TO_THIS_REPO> lib/my-templates

```

*Note: Replace `<URL_TO_THIS_REPO>` with the actual Git URL of this repository.*

## Usage

In your main Typst file (e.g., `main.typ`), import the library and apply the `project` function.

```typ
// Import the template library
#import "lib/my-templates/lib.typ": *

// Initialize the document
#show: project.with(
  title: "Your Document Title",
  // author: "Your Name",  // Optional: defaults to the preset name
  // textbook-numbering: true, // Optional: changes equation numbering style
)

= Introduction
Your content goes here. The environment is already set up with Japanese fonts and math packages.

```

## Configuration

The `project` function accepts the following arguments:

| Argument | Type | Default | Description |
| --- | --- | --- | --- |
| `title` | `content` | `""` | The title of the document. |
| `author` | `content` | *(Preset)* | The author name/ID. Defaults to "Kei Onuma / 23311420". |
| `date` | `content` | `none` | The date of the document. |
| `textbook-numbering` | `boolean` | `false` | If `true`, equations are numbered as `(6.5.1)`. |

## Included Macros (`utils.typ`)

This template exports several utility functions for faster typing.

### Math & Physics

* `#combination(n, r)` / `#permutation(n, r)`: Formatted permutation/combination notation (, ).
* `#qed`: Inserts a QED symbol flushed to the right.
* `#lhs` / `#rhs`: Shorthand for "Left-hand side" / "Right-hand side" in Japanese.

### Boxes & Layout

* `#crect(body)`: **Centered Rectangle**. Useful for emphasizing formulas or definitions.
* `#frect(body)`: **Full-width Rectangle**. Spans the entire page width.
* `#ans(body)`: **Answer Box**. A small box designed for highlighting final answers in math problems.

## Dependencies

The following packages are pre-imported from Typst Preview:

* `physica:0.9.7`
* `unify:0.7.1`
* `cetz:0.4.2`
* `showybox:2.0.4`
* `whalogen:0.3.0`

## License

MIT

```