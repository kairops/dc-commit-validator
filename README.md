# DEPRECATED

Please visit https://github.com/tpbtools/dc-commit-validator/settings

# Docker Command: Commit Validator

Simply Commit Message Validator written in BASH

Its a part of the Docker Command series

## Usage

Execute the following:

- Using Bash, withinh your repository folder: `cd [git-repository-dir]; [/path/to/commit-validator]/entrypoint.sh`
- Using Docker: `docker run --rm -v [git-repository-dir]:/workspace kairops/dc-commit-validator .`
- Using docker-command-launcher:`kd git-changelog-generator [git-repository-dir]`

The script will check if the commit message(s) of your repository corresponding to the unreleased commit(s) fulfill the rules of [Git Changelog Generator](https://github.com/kairops/dc-git-changelog-generator)

It will return 0 if the the whole commit messages fulfill the rules, and 1 if at least one commit does not.

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
