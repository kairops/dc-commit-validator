# Docker Command: Commit Validator

Simply Commit Message Validator written in BASH

Its a part of the Docker Command series

## Usage

Execute the following within your repository folder:

- Using Bash:
  - `./entrypoint.sh [git-repository-dir]`
  - `./entrypoint.sh "Commit message"`
  - `echo "Commit message" | ./entrypoint.sh -`
- Using Docker:
  - `docker run --rm -v [git-repository-dir]:/workspace kairops/dc-commit-validator .`
  - `docker run --rm kairops/dc-commit-validator "Commit message"`
  - `echo "Commit message" | docker run --rm kairops/dc-commit-validator -`
- Using docker-command-launcher:
  - `kd git-changelog-generator [git-repository-dir]`
  - `kd git-changelog-generator "Commit message"`
  - `echo "Commit message" | kd git-changelog-generator -`

The script will check if the message(s) of the unreleased commit(s) (or the commit message passed as parameter) fulfill the rules of [Git Changelog Generator](https://github.com/kairops/dc-git-changelog-generator)

- If you pass a existent directory of the filesystem in the first parameter, the script expect to find a git repository and will check all the messages of all unreleased commit.
- If you pass a commit message as a text, the script will check it.

In both cases, it will return 0 if the message (or messages) fulfill the rules, and 1 in other case.

## Considerations

Make the commits on your repository following [Keep Changelog](https://keepachangelog.com/en/1.0.0/) rules and these keywords:

- Breaking - for a backwards-incompatible enhancement.
- New - implemented a new feature.
- Upgrade - for a dependency upgrade.
- Update - for a backwards-compatible enhancement.
- Fix - for a bug fix.
- Build - changes to build process only.
- Docs - changes to documentation only.
- Security - for security skills.
- Deprecated - for deprecated features.
