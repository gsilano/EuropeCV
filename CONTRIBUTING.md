Contributing
============

👍🎉 Thanks a lot for considering contributing 🎉👍

We welcome and encourage contribution. There are many ways to contribute: you can
write bug report, contribute code or documentation (take a look at the 
[Wiki section](https://github.com/gsilano/EuropeCV/wiki)).

## Working on your first Pull Request?

You can learn how from this *free* series [How to Contribute to an Open Source Project on GitHub](https://egghead.io/series/how-to-contribute-to-an-open-source-project-on-github)

## Reporting issues

When reporting issues the more information you can supply the better.

If it is an issue with building the LaTeX package, indicate your environment: operating system,
TeX distribution (TeX Live, MiKTeX, ...) and its version, and the engine (pdfLaTeX, XeLaTeX, LuaLaTeX).
A minimal example that reproduces the problem, and the `.log` file, help a lot.

## Improvements request and proposal

Feel free to make an issue to request a new functionality.

## Contributing code/Pull-Request

We welcome contribution, this can be done by starting a pull-request.
You can contribute by updating the package content or styling, code (.cls file), or both.

### Contributing content or styling

There are a couple of basic requirements for us to merge the pull request:
 - The styling should maintain the compatibility with previous versions. For example, if you plan to 
 add a new number to the contact information, it should be optional and not mandatory allowing not to
 change anything to the other users of the package. 

### Contributing code

If the change is big, typically if the change span to more than one file, consider starting an issue first to discuss the improvement.
This will make it much easier to make the change fit well into the package.

There are some basic requirements for us to merge a pull request:
 - Describe the change (a bot will remind you in case you forget it)
 - Refer to any issues it affects
 - Separate one pull request per functionality: if you start writing "and" in the feature description consider if it could be 
 separated in two pull requests.

In your code:
 - Make sure the coding style of your code follows the style of the file.
 - Use Unix style line terminators (LF, `\n`) instead of DOS style ones (CRLF, `\r\n`).
   This is required by CTAN.
 - Report each change in the `CHANGELOG.rst` file, specifying who made the contribution.
 - Update the date in the header of each file you changed (`\ProvidesClass` in
   `europecv.cls`, `\ProvidesFile` in the `ecv*.def` files, `\date` in `europecv.tex`).
 - Internal commands of the class must start with `\ecv@`, user commands with `\ecv`.
 - Run `make check` (it requires a TeX Live installation, including `biber`) to make sure
   that the documentation, the examples, the templates and all the language options still
   compile. The same checks run automatically on GitHub for every pull request.

### Adding or fixing a translation

The translations are stored in the `ecv<code>.def` files (e.g., `ecvit.def` for Italian).
These files must be saved with the UTF-8 encoding. Every key defined in `ecven.def`
should also be defined in the new file: a missing key falls back to English. To add a new
language, create the `.def` file and declare the corresponding option in `europecv.cls`
with `\ecv@declarelanguage{<option>}{<code>}{<Language name>}`; then add the language to
`tests/languages.sh`, to the documentation and to the README.
 
## Workflow

### Stable branch: `master`

The `master` branch is stable and **should not receive new features**. Only **bug fixes** are accepted.

This is the typical workflow to fix a bug in the master branch.

* Identify a bug that does not require breaking changes of the API/ABI.
* Open an issue on github.
* Add some label (FIXME which label?).
* Assign the issue to yourself.
* Create a new branch starting from the `master` branch:

```
git fetch origin
git checkout -b <branch_name> origin/master
```

* Fix the bug and make one or more commits.
* [Push the branch on your fork and create a pull request](https://help.github.com/categories/collaborating-on-projects-using-pull-requests/).
* Wait for someone else to review your fix and merge your pull request.
* Your fix is now in the `master` branch, now you need to port it to the `devel`
  branch.
* Ensure that your branches are in sync with `origin`:

```
git checkout master
git pull --rebase origin master
git checkout devel
git pull --rebase origin devel
```

  * Merge master into devel and eventually fix the conflicts.

```
git merge master
```

##### Work in progress PR
As final note, in case you need to start a PR but you deem it still **work-in-progress** and don't want anyone to merge it by mistake, do the following:
- Put `[WIP]` at the beginning of the PR title.
- Mark the PR with the label `"Status: In Progress"`.

Once you're happy about your work, just remove the `[WIP]` tag as well as the label, and drop a message within the PR to notify the community that reviews are welcome and merging is now possible.

### Development branch: `dev`


We use the branch `dev` to collect the ongoing work, which is given in terms of **new features** and **bug fixes**.

When we introduce a new feature that will cause downstream projects to be aware of such update, we do increase the tweak number (always sticking to _odd numbers_).

When we decide to publish these new features in a new software release (roughly each _3 months_), we merge the new modifications into `master`, doing:

```sh
git checkout master
git merge --no-ff devel
git push origin master
```


