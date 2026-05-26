# Typst Template Library

A [Typst](https://typst.app/) template library optimized for personal projects, university reports, and academic papers. It is designed to be integrated into individual projects as a Git submodule.
It comes pre-configured with Japanese typesetting settings, math packages, and useful custom macros.

## Features
- **Japanese Optimization**: Pre-configured with the "Harano Aji Mincho" font for Japanese text, while gracefully falling back to "New Computer Modern" for English alphabets and numbers (ensuring a professional, LaTeX-like appearance). A4 paper size and standard margins are applied by default.
- **Math & Physics Ready**: Pre-loads essential packages like `@preview/physica`, `@preview/unify`, and `@preview/cetz`.
- **Dynamic Equation Numbering**: If you set a section numbering style (e.g., `1.1`), equation numbers will automatically synchronize (e.g., `(1.1.1)`).
- **Advanced Report Features**: Built-in support for generating dedicated title pages, tables of contents, and IEEE-style bibliographies.
- **Custom Macros**: Includes useful functions for unit formatting (via `unify`), answer boxes, and permutations/combinations (P, C, H).

---

## Prerequisites (Font Installation)

This template uses the **"Harano Aji Mincho"** (原ノ味明朝) font by default to output beautiful Japanese typography.
If you do not have this font installed on your local environment, please download and install it from the link below:

- [Harano Aji Fonts (GitHub Repository)](https://github.com/trueroad/HaranoAjiFonts)
  - Downloading and installing `HaranoAjiMincho-Regular.otf` and `HaranoAjiMincho-Bold.otf` is usually sufficient.
  - *Note: If you are using the Typst Web App, you can upload the font files directly via the project's font settings.*

---

## Installation

To use this template in your Typst project, add it as a Git submodule and run the initialization script to automatically configure your environment.
Run the following commands in your project's root directory (assuming Windows PowerShell):

```powershell
# 1. Add the submodule
mkdir -p lib
git submodule add https://github.com/Key-2014/Typst_Template lib/Typst_Template
```
```powershell
# 2. Run the automatic setup script
powershell -ExecutionPolicy Bypass -File .\lib\Typst_Template\init.ps1
```

> **What does `init.ps1` do?**
> - **CI/CD**: Copies the GitHub Actions workflow to automatically build and release PDFs on push.
> - **Snippets**: Copies the highly optimized `.vscode/typst.code-snippets` to your workspace so they are instantly available.
> - **.gitignore**: Safely appends `*.pdf` to your `.gitignore` to prevent generated PDFs from bloating your repository.

> **Updating the Submodule**:
> To fetch and apply the latest changes from the template repository, run:
> ```bash
> git submodule update --remote lib/Typst_Template
> ```

---

## Usage

The easiest way to get started is to copy the contents of the `example/` directory (which includes `main.typ` and `refs.bib`) to your project's root folder and modify it.

Alternatively, in your project's main file (e.g., `main.typ`), initialize the document by importing the library and calling the `project` function:

```typ
// Import the template (this also loads the macros from utils.typ)
#import "lib/Typst_Template/lib.typ": *

// Initialize the document settings
#show: project.with(
  title: "Document Title",
  author: "Typst User",
  student-id: "12345678",
  date: datetime.today().display(),
  heading-numbering: "1.1",  // Optional: Enable section numbering
  equation-numbering: "1.1", // Optional: Enable equation numbering ("1" or "1.1")
  title-page: true,          // Optional: Generate a standalone title page
  toc: true,                 // Optional: Generate a table of contents
)

= Introduction
Start writing your content here. Japanese fonts and paragraph settings will be applied automatically.

$ x = (-b +- sqrt(b^2 - 4a c)) / (2a) $

// To add a bibliography, simply call the bibliography function at the end of your document.
// The template automatically styles it as "参考文献" with the IEEE style.
#pagebreak()
#bibliography("refs.bib")
```

---

## Configuration

The `project` function accepts the following arguments:

| Argument | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `title` | `string` / `content` | `""` | The title of the document. |
| `author` | `string` / `content` | `""` | Author name. |
| `student-id` | `string` / `content` | `""` | Student ID. |
| `date` | `datetime` / `content` | `none` | Date (e.g., `datetime.today().display()`). |
| `indent` | `boolean` | `false` | If `true`, the first line of each paragraph is indented by 1em. |
| `heading-numbering` | `string` / `none` | `none` | Heading numbering style (e.g., `"1.1"`). |
| `heading-supplement` | `content` / `none`| `none` | Heading prefix (e.g., `[Chapter]`). |
| `equation-numbering` | `string` / `none` | `none` | Equation numbering style (`"1"` for continuous, `"1.1"` for section-based, or `none`). |
| `title-page` | `boolean` | `false` | If `true`, generates a dedicated, vertically-centered title page without a page number. The page counter is reset to 1 for the following content. |
| `toc` | `boolean` | `false` | If `true`, generates a Table of Contents (目次) before the main content. |

> **💡 Equation Numbering**
> Equation numbering is controlled by the `equation-numbering` parameter:
> - `none` (default): Equations are not numbered.
> - `"1"`: Continuous numbering like `(1)`, `(2)`, ... throughout the document.
> - `"1.1"`: Section-based numbering like `(1.1)`, `(2.1)`, ... which resets at each major section heading. (Note: If `heading-numbering` is `none`, it will automatically fall back to continuous numbering `"1"`).

---

## Included Macros (`utils.typ`)

This template provides custom macros (functions) to streamline writing reports. These are automatically available when you import `lib.typ`.

### Units
Uses the `unify` package to beautifully format complex units.
- **`#u("unit_string", b: false)`**
  - Example: `#u("m/s^2")` -> Outputs a properly parsed, upright math unit.
  - Set `b: true` to enclose the entire unit in square brackets (e.g., `#u("kg*m/s^2", b: true)` -> `[kg m/s²]`).

### Math Notations
Provides notation commonly used in Japanese mathematics education (subscripts on the bottom left).
- `#combination(n, r)`: Combination $_n\text{C}_r$
- `#permutation(n, r)`: Permutation $_n\text{P}_r$
- `#hcombination(n, r)`: Combination with repetition $_n\text{H}_r$

### Boxes & Layout
- **`#ans(body)`**: A highlighted box for answers. It adapts to both text and math content, and automatically adjusts its baseline for fractions.
- **`#crect(body)`**: A centered rectangular block (useful for emphasizing definitions or theorems).
- **`#frect(body)`**: A full-width rectangular block.

### Misc
- **`#eqtag(content, tag)`**: Manually tags a specific equation (e.g., `*` or `A`) without advancing the global equation counter.
- **`#bk`**: Inserts a horizontal space of 1em.
- **`#qed`**: Places a Q.E.D. symbol flush right at the end of a line.
- **`#lhs`**: Outputs the Japanese text `(左辺)` (Left-hand side).
- **`#rhs`**: Outputs the Japanese text `(右辺)` (Right-hand side).

---

## VS Code Snippets

This template includes a `.vscode/typst.code-snippets` file that provides highly optimized auto-completion snippets for writing academic reports efficiently. These workspace snippets are automatically active when you open the template directory in VS Code.

To use them, simply type `typ-` in a `.typ` file and select from the suggestions:

### Template Initialization
- **`typ-report`**: Initializes a new report document with the custom template (sets up title page, fonts, and numbering).

### Content Blocks
- **`typ-png`**: Inserts a figure containing an image with optional caption and label.
- **`typ-table`**: Inserts a table wrapped in a figure.
- **`typ-code`**: Inserts a source code block with syntax highlighting and caption.
- **`typ-cetz`**: Inserts a CeTZ drawing canvas with a helper grid.

### Macros from `utils.typ`
- **`typ-frect`**: Inserts a full-width framed rectangle block (`#frect[...]`). Ideal for theorems and definitions.
- **`typ-crect`**: Inserts a centered framed rectangle block (`#crect[...]`). Ideal for emphasizing results.
- **`typ-ans`**: Inserts an answer box (`#ans[...]`).
- **`typ-u`**: Formats physical units (`#u("m/s^2")`).

### Equation Numbering Control
- **`typ-eqnum`**: Enables standard equation numbering `(1)`.
- **`typ-eq-manual`** (or **`typ-eq-prefix`**): Manually sets the equation numbering prefix (e.g., to `(6.5.1)` or `(1.1.1)`) and optionally resets the counter.
- **`typ-eqtag`**: Tags a single equation manually using `eqtag()` without affecting the global counter.
- **`typ-eq-none`** (or **`typ-eqdelete`**): Disables equation numbering from that point forward.

---

## Dependencies

The following official/preview Typst packages are pre-imported in the template, so you don't need to import them again in your documents:

* `@preview/physica:0.9.8` (Advanced notations for physics and math)
* `@preview/unify:0.8.0` (Number and unit formatting)
* `@preview/cetz:0.5.0` (Drawing and diagrams)
* `@preview/showybox:2.0.4` (Colorful emphasis boxes)
* `@preview/whalogen:0.3.0` (Chemical equations)

---

## Updating Packages

Typst requires exact version numbers for packages (e.g., `@preview/physica:0.9.8`) to guarantee document reproducibility.
To easily update the packages used in this template to their latest versions, you have two options:

### Option 1: Using VS Code (Tinymist) - Recommended
If you use the [Tinymist Typst](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist) extension in VS Code:
1. Delete the version number in the import statement (e.g., change it to `#import "@preview/physica:"`).
2. Press `Ctrl + Space` (or your autocomplete shortcut).
3. Select the latest version from the dropdown menu.

### Option 2: Using the Auto-Update Script (Windows)
This repository includes a PowerShell script that automatically fetches the latest versions from the Typst package registry and updates all `.typ` files in the directory.
Run the following command in the template directory:
```powershell
powershell -ExecutionPolicy Bypass -File .\update_packages.ps1
```

---

## Automated PDF Generation (GitHub Actions CI/CD)

This template provides a ready-to-use GitHub Actions workflow (`.github/workflows/compile-typst.yml`) that automatically compiles your Typst source code into a PDF and publishes it to GitHub Releases every time you push to the `main` branch. 

**This workflow automatically downloads the required "Harano Aji Mincho" fonts to the cloud server before compilation, ensuring perfect reproducibility without bloating your Git repository with heavy font files.**

### How to use in your report repository:

Because GitHub Actions only run workflows located in the root directory of a repository, the workflow must be copied to your parent repository.

**The easiest way to set this up is to run the `init.ps1` script during installation** (see the Installation section). This script will automatically copy the workflow file into your parent repository's `.github/workflows/` directory.

Once configured, GitHub will automatically discover any `.typ` files in your parent repository's root directory, build them, and publish a new PDF Release on every push!

---

## License
MIT License