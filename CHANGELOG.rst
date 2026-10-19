^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Changelog for package europecv
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

2026.10.19
----------
* New class europecv2020, implementing the single-column layout of the Europass CV introduced in 2020 (#37): header with picture, name, personal data and logo, section titles followed by a rule, \ecventry for dates/place/title/organisation, language self-assessment grid, customizable colours. It accepts the commands and options of europecv, so that existing CVs can be converted by changing the name of the class
* New templates cv_template_2020_en.tex and cv_template_2020_it.tex
* The code shared by the two classes (language and encoding options, personal data and cross-referencing commands) has been moved to europecv-common.def
* Translations of the new labels "Other language(s)" and "Levels" in English, French, German, Italian, Portuguese and Spanish
* The GitHub release workflow is triggered by tags without the "v" prefix (e.g. 2026.10.19), as used in the repository
* Fix the input encoding options (latin1, cp1250, koi8-r, ...), which failed with "Undefined control sequence \inputencoding": they now load the inputenc package. The obsolete utf8x option is now the same as utf8 (the ucs package is no longer needed)
* Fix the dutch, slovenian and maltese options, which stopped the compilation because of typos in ecvnl.def, ecvsl.def and ecvmt.def
* Maltese: the letters h and H with stroke now work with pdfLaTeX (they are taken from the maltese package if loaded, and drawn otherwise); updated the Maltese example for XeLaTeX/LuaLaTeX
* Fix the nobranding option for Portuguese, Romanian, Serbian, Slovak, Slovenian and Swedish, whose titles always contained the "Europass" text
* The cross-referencing commands (\ecvdisplay..., \ecvref...) no longer redefine \hypertarget and no longer risk overwriting existing commands when a key such as "par" is used. A reference to an undefined key is now printed as ?? with a warning
* New command \ecvNewReferenceType to define new kinds of numbered entries; new command \ecvrefWorkshops, as described in the documentation (\ecvrefWorkshopsPublications is kept for compatibility)
* \section* is accepted inside the europecv environment
* The parentheses of the CEF footer are now really upright (\textup instead of \upshape)
* The graphicx package is loaded automatically if needed (logo, flags, picture)
* Romanian: combelow is loaded with \RequirePackage at the end of the class
* Proper LPPL and maintenance status headers, dates in \ProvidesClass/\ProvidesFile in the standard format (yyyy/mm/dd)
* Fix the biber template (renamed to cv_template_en_biber.tex, missing photo, configuration file not matching the bib file names)
* Removed generated files (*-eps-converted-to.pdf) from the package; added a Makefile to build the documentation and the CTAN archive, a smoke test for all languages and a GitHub workflow
* Updated documentation: dead links, dependencies, encodings, Maltese, typos; rewritten README for CTAN
* Improved French translation (#45)
* Contributors: tytyvillus, Giuseppe Silano

2025.05.14
----------
* Fix hook error related to loading 'hyperref' package (#38)
* Contributors: Matteo Ferrigato

2025.05.11
----------
* Fix issue related to clash onto the horizontal #40 (#40)
* Contributors: Giuseppe Silano

2024.02.01
----------
* Improved Spanish translation #36 (#36)
* Contributors: kaneraZh, Giuseppe Silano

2022.08.03
----------
* europasslogo.pdf does not work with XeTeX #31 (#31)
* Contributors: Michal Vlasak

2022.06.17
----------
* Fixed issue related to the `ucs` and `inputenc`  (with utf8x option) package (#29)
* Contributors: David Carlisle, Ulrike Fischer, Giuseppe Silano

2022.03.13
----------
* Fixed "europass.pdf not found" error on XeLaTeX
* Improved Romanian translation
* Minor fix in the documentation
* Contributors: Alecu Ștefan-Iulian, Giuseppe Silano

2021.12.24
----------
* Add ref and display commands for FootNote, Conference and Journal papers, Posters, Awards, Research Projects, Book Chapters and Workshop. This update mainly involves academic researchers
* Files comply with the CTAN requirements
* Update templates as required by CTAN
* Contributors: Giuseppe Silano

2021.05.09
----------
* Update package documentation for new release
* Fix condensed fontseries name on the narrow option (#25)
* Contributors: Pancho Horrillo, Giuseppe Silano

2021.02.05
----------
* Improved Portuguese translation (#24)
* Update package documentation
* Contributors: Nuno Fachada, Giuseppe Silano

2020.01.03
-----------
* Added example with the geometry package (#20)
* Improved the parenthesis style around CEF (#19)
* Added Matrix/Riot support (#18)
* Completed all translations. Moreover, inverted the surname with the name (#16)
* Updated Nicola Vitacolonna's e-mail address (#14)
* Updated the manual with the new features. Typos have also been corrected.
* Contributors: Giuseppe Silano

2019.12.23
----------
* Integrated the nobranding features
* Contributors: Marc-Andre Hermanns

2019.03.19
----------
* Now you can integrate your YouTube channel into your CV
* Now you can add multiple addresses
* Contributors: Giuseppe Silano

2019.02.04
----------
* Improved Portuguese translation
* Correct hardcoded names in the "ecven.def" and "ecvit.def" files
* Contributors: JPSPLeite

2019.01.31
----------
* Optional CV "update date" by using the command \ecvdate{}
* Contributors: Giuseppe Silano

2019.01.25
----------
* Completed the "ecvsv.def" file with the Swedish translation
* Contributors: Emil Gardström

2018.10.15
----------
* Updated the template "cv_template_en" and added the template "cv_template_academic_en"
* Added instructions for using the command \pdfbookmark and how to automatically update the publications in the manual
* Added the command "ecvhomepage"
* Contributors: Giuseppe Silano

2018.10.12
----------
* Update of the "ecvde.def" file with the German translation
* Contributors: redlulz

2018.09.02
----------
* Fixed bug (italian \ae and removed "et studiorum") in according to #6
* Contributors: lgelmi

2018.07.23
----------
* More changes based on #2. The \ecvtelephone command changed to maintain forward compatibility.
* added the new commands to \ecvspace
* Redefined thebibliography environment due to errors in the wake of \section redefinition
* Fixed some minor documentations quirks.
* Contributor: Jürgen Spitzmüller

2018.07.22
----------
* Some changes based on #2. Specifically, the \ecvsection and \ecvfax commands have been restored. Furthermore, the documentation has been updated explaining how to use the \ecvtelephone command.
* Cotributors: Giuseppe Silano

2018.07.13
----------
* Bug fix
* Removed the CR-LF line terminators
* Contributors: Giuseppe Silano

2018.07.12
----------
* New features have been added to the LaTeX package. Now, you can add in your CV the Skype account, the professional or institutional address and the certified one (useful if you are Italian), and the office number. A GitHub repository has been opened to improve the development of new functionalities and, at the same time, make it easier to find and fix bugs.
* Contributors: Giuseppe Silano
