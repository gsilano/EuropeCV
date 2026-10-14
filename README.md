[![All Contributors](https://img.shields.io/badge/all_contributors-29-orange.svg?style=flat-square)](#contributors)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/proposing-changes-to-your-work-with-pull-requests/creating-a-pull-request)
[![first-timers-only](https://img.shields.io/badge/first--timers--only-friendly-blue.svg?style=flat-square)](https://www.firsttimersonly.com/)
[![License: LPPL 1.3c](https://img.shields.io/badge/license-LPPL%201.3c-blue.svg?style=flat-square)](https://www.latex-project.org/lppl/lppl-1-3c/)

# europecv – An unofficial LaTeX class for European curricula vitae

Version 2026.10.14 (2026-10-14)

`europecv` is an unofficial LaTeX implementation of the standard model for
curricula vitae (the *Europass CV*) as recommended by the European Commission.
Although primarily intended for users in the European Union, the class can be
used for any kind of curriculum vitae (possibly with the options `notitle`,
`nobranding` and `nologo`).

The class supports 27 languages (Bulgarian, Catalan, Czech, Danish, Dutch,
English, Estonian, Finnish, French, Galician, German, Greek, Hungarian,
Icelandic, Italian, Latvian, Lithuanian, Maltese, Norwegian, Polish,
Portuguese, Romanian, Serbian, Slovak, Slovenian, Spanish and Swedish), the
self-assessment table of the Common European Framework of Reference for
Languages (CEFR), and cross-referenced lists of publications, projects and
awards. It works with pdfLaTeX, XeLaTeX and LuaLaTeX.

- CTAN: <https://ctan.org/pkg/europecv>
- Development and bug reports: <https://github.com/gsilano/EuropeCV>

## Usage

A minimal curriculum vitae:

```latex
\documentclass[helvetica,narrow]{europecv}
\ecvname{Surname, Name}
\begin{document}
\begin{europecv}
\ecvpersonalinfo
\section{Work experience}
\ecvitem{2020 -- today}{Job description}
\end{europecv}
\end{document}
```

The full documentation is in `europecv.pdf`. Ready-to-use templates are in the
`templates` folder and further examples in the `examples` folder.

## Contents of the package

| File(s)                         | Description                                          |
|---------------------------------|------------------------------------------------------|
| `europecv.cls`                  | The document class                                   |
| `ecv*.def`                      | Language definition files (`ecven.def` is English, `ecvit.def` Italian, ...) |
| `europasslogo.{eps,pdf}`        | Europass logo (unofficial vector version)            |
| `EuropeFlag*.{eps,pdf}`         | Flags of the European Union                          |
| `europecv.tex`, `europecv.pdf`  | Documentation (source and PDF)                       |
| `examples/`                     | Examples (minimal CV, Bulgarian, Greek, Maltese, ...) |
| `templates/`                    | Templates (standard, academic, and with biblatex/biber) |
| `CHANGELOG.rst`                 | History of changes                                   |
| `CONTRIBUTING.md`               | How to contribute                                    |
| `LICENSE`                       | The LaTeX Project Public License, version 1.3c       |

## Installation

`europecv` is part of TeX Live and MiKTeX: use the package manager of your TeX
distribution to install or update it.

To install it manually, copy `europecv.cls`, the `ecv*.def` files, and the
logo and flag images (`europasslogo.*` and `EuropeFlag*.*`) into a directory
searched by TeX, e.g. `TEXMFHOME/tex/latex/europecv/`, and the documentation
into `TEXMFHOME/doc/latex/europecv/`. Alternatively, simply put these files in
the same directory as your CV.

## Requirements

The class needs a LaTeX kernel released on 2020-10-01 or later. It loads the
`array`, `longtable`, `fancyhdr`, `etoolbox`, `graphicx` and `hyperref`
packages and, depending on the options, `inputenc`, `totpages`, `booktabs`
and `combelow`. All of them are part of any TeX distribution.

## License

Copyright (C) Nicola Vitacolonna (original author)  
Copyright (C) 2018-2026 Giuseppe Silano and the EuropeCV contributors

This work may be distributed and/or modified under the conditions of the
LaTeX Project Public License, either version 1.3c of this license or (at your
option) any later version. The latest version of this license is in
<https://www.latex-project.org/lppl.txt> and version 1.3c or later is part of
all distributions of LaTeX version 2008 or later.

This work has the LPPL maintenance status `maintained`.
The Current Maintainer of this work is Giuseppe Silano.

The Europass logo and the flags are distributed for convenience only: see the
"Disclaimer" section of the documentation.

## Maintainer

This project is maintained by **Giuseppe Silano**.
Feel free to reach out via [his website](https://giuseppesilano.net/index.html)
for contributions, questions, or bug reports. The preferred way to report
bugs and propose changes is the
[GitHub repository](https://github.com/gsilano/EuropeCV/issues).

Translations are written by volunteers: if you find a wrong translation,
please correct the corresponding `ecv*.def` file and open a pull request.
See [CONTRIBUTING.md](CONTRIBUTING.md) for the details.

## Building and releasing (maintainers)

The repository contains a `Makefile`:

- `make doc` builds the documentation;
- `make check` builds the documentation, the examples and the templates, and
  compiles a test CV with every language option and with pdfLaTeX, XeLaTeX and
  LuaLaTeX;
- `make ctan` creates `build/europecv.zip`, ready for the
  [CTAN upload form](https://ctan.org/upload). The archive is created with
  `git archive` from the committed files, so that files not meant for CTAN
  (hidden files, the `Makefile`, the tests, ...) are excluded through the
  `export-ignore` attributes in `.gitattributes`.

Before a release, update the date and version in `europecv.cls`
(`\ProvidesClass`), in the `ecv*.def` files that changed (`\ProvidesFile`), in
`europecv.tex` (`\date`), in this file and in `CHANGELOG.rst`, then rebuild
`europecv.pdf`.

### CTAN contact

All CTAN-related correspondence should be directed in English to
ctan (at) ctan (dot) org, the common email address of all "CTAN people",
rather than to an individual maintainer. Emails must be in plain text only
(HTML is filtered out). Uploads must be done via the CTAN upload form, not by
email. Please avoid sending large attachments to the CTAN address.
