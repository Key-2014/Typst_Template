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

The easiest way to get started is to use one of the files in the `examples/` directory as a template for your project. We provide three official examples depending on your target format:

1. **[report_ja.typ](file:///C:/Users/keion/github/Typst_Template/examples/report_ja.typ)**: A Japanese report template (No separate cover page, uses `#report-header()`).
2. **[thesis_ja.typ](file:///C:/Users/keion/github/Typst_Template/examples/thesis_ja.typ)**: A Japanese bachelor/master thesis template (Includes `#thesis-cover()`, `#thesis-abstract()`, and `#thesis-toc()`).
3. **[thesis_en.typ](file:///C:/Users/keion/github/Typst_Template/examples/thesis_en.typ)**: An English thesis template (All fonts and captions formatted for English).

In your main document file (e.g., `main.typ`), import the template and select configuration rules by calling `project`. You can then call layout components individually:

```typ
// Import the template and math utilities
#import "lib/Typst_Template/lib_v2.0.0.typ": *

// 1. Initialize global layout rules
#show: project.with(
  lang: "ja",
  supplement-lang: "ja",
  heading-numbering: "1.1",
  equation-numbering: "1.1",
)

// 2. Render the cover page (optional)
#thesis-cover(
  academic-year: "令和7",
  title: "Document Title",
  affiliation: "Department of Physics",
  student-id: "12345678",
  author: "Typst User",
  supervisor: "Professor Einstein",
  date: "March 2026",
  lang: "ja",
)

// 3. Render the abstract (optional)
#thesis-abstract(lang: "ja")[
  Your abstract goes here.
]

// 4. Render the Table of Contents (optional)
#thesis-toc(lang: "ja")

// 5. Start your main body
= Introduction
Write your content here.
```

---

## Configuration

### `project` (Global setup)
The `#show: project.with(...)` rule configures document-wide spacing, fonts, and numbering.

| Argument | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `lang` | `string` | `"ja"` | Document language (`"ja"` or `"en"`). Determines the default fallback font. |
| `supplement-lang` | `string` | `"ja"` | Caption language (`"ja"`, `"en"`, or `"en-full"`). Determines labels like "Fig.", "Table", "Eq.". |
| `heading-numbering` | `string` / `none` | `none` | Heading numbering style (e.g., `"1.1"`). |
| `equation-numbering` | `string` / `none` | `none` | Equation numbering style (`"1"` for continuous, `"1.1"` for section-based). |
| `indent` | `boolean` | `false` | If `true`, the first line of each paragraph is indented by 1em. |

### `thesis-cover` (Thesis Cover Page)
Creates a beautifully aligned cover page centered on the page.

| Argument | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `academic-year` | `string` | `""` | The academic year (e.g., `"令和7"` or `"2025"`). |
| `title` | `string` | `""` | The title of the thesis. |
| `affiliation` | `string` | `""` | Department/Affiliation. |
| `student-id` | `string` | `""` | Student identification number. |
| `author` | `string` | `""` | Author name. |
| `supervisor` | `string` | `""` | Supervisor's name and title. |
| `date` | `string` | `""` | Submission date. |
| `lang` | `string` | `"ja"` | Label language (`"ja"` or `"en"`). |

### `report-header` (Compact Report Header)
Inserts a simple, right-aligned header block at the top of the first page.

| Argument | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `title` | `string` | `""` | The report title. |
| `author` | `string` | `""` | Author name. |
| `student-id` | `string` | `""` | Student ID. |
| `date` | `datetime` / `content` | `none` | Date. |
| `lang` | `string` | `"ja"` | Label language (`"ja"` or `"en"`). |

### `thesis-abstract` (Abstract Block)
Formats the abstract text and centers the abstract title.

| Argument | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `lang` | `string` | `"ja"` | Label language (`"ja"` or `"en"`). Displays "概要" or "Abstract". |
| `body` | `content` | (Required) | The abstract content. |

### `thesis-toc` (Table of Contents)
Renders a Table of Contents (目次). Page numbering is automatically managed: Roman numerals (`i, ii...`) are used from the TOC page up to the main body, where numbering is reset to `1` (Arabic numerals).

| Argument | Type | Default | Description |
| :--- | :--- | :--- | :--- |
| `lang` | `string` | `"ja"` | Label language (`"ja"` or `"en"`). Displays "目次" or "Table of Contents". |

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