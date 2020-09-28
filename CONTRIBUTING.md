# How to contribute

Thank you for taking the time to contribute. We appreciate it!

There are two ways to contribute - via issues, which are used for discussion, and pull requests, which are concrete proposals for changes.

## Issues

The project's issues page is a forum to discuss both major and minor issues related to developing the specification. It also serves as the means for collaborating with the group and discussing contributions that will ultimately lead to changes to the API.

## Workflow

Our workflow is based on [Gitflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow), which defines a strict branching model designed around the project release. This workflow uses two branches to record the history of the project. The `master` branch stores the official release history, and the `develop` branch serves as an integration branch for features. Aside from these two main branches, the workflow utilizes topic and release branches.

### Pull requests

The way to contribute development effort and code to the project is via GitHub pull requests. GitHub provides a nice [overview on how to create a pull request](https://help.github.com/articles/creating-a-pull-request). Pull Requests should usually be made against the `develop` branch.

Some general rules to follow:

- [Fork](https://help.github.com/articles/fork-a-repo) the main project into your personal GitHub space to work on.
- Create a branch for each update that you're working on. These branches are often called "feature" or "topic" branches. Any changes that you push to your feature branch will automatically be shown in the pull request.
- Keep your pull requests as small as possible. Large pull requests are hard to review. Try to break up your changes into self-contained and incremental pull requests.
- The first line of commit messages should be a short (&lt;80 character) summary, followed by an empty line and then any details that you want to share about the commit.
- Please try to follow [common commit message conventions](https://chris.beams.io/posts/git-commit/).

### Topic branches

If you wish to collaborate on a new feature with other GA4GH members, you can create a topic branch. Once a topic branch exists, pull requests can be made against it the usual way. It may also be brought up to date with new changes merged into develop by anyone with commit access, if the changes produce merely a fast-forward merge for each constituent branch. However, if changes from the develop branch create a new merge commit in or or more of the repositories, that commit needs to be reviewed in a pull request.

Changes made in a topic branch can be merged into develop by creating a pull request against the `develop` branch and then resolving the normal way.

Topic branches that have been merged into develop and that are no longer being developed upon should be [deleted](https://github.com/blog/1335-tidying-up-after-pull-requests).

### Release branches

From time to time the group will make a release. This is achieved by creating a branch named `release-foo`, where `foo` is the release name. Only bug fixes are allowed to release branches. To refer to a specific version of a release branch, either the commit ID can be used, or alternatively (better), a tag can be created.
