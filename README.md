# ds-repo-template
Template repository for data science projects


# Repository settings setup
When creating a repository, please setup the following.

## General
- Check `Automatically delete head branches`

## Collaborators and teams
- Add `ds` as the team
- Provide `ds` team with `Maintain DS` role
- Provide `pdarulewski` with `Admin` role

## Branches / main
- Check the following:
  - `Require a pull request before merging`
  - `Require approvals` of at least 1 person
  - `Dismiss stale pull request approvals when new commits are pushed`
  - `Require review from Code Owners`
  - `Allow specified actors to bypass required pull requests`
    - Add `Lyngsoe`
    - Add `hal9000raffle`
  - `Do not allow bypassing the above settings`

## Webhooks
- Create webhooks for:
  - CircleCI
    - payload URL: https://circleci.com/hooks/github
    - content-type: appplication/x-www-form-urlencoded
    - enable SSL verification
    - select individual:
      - pull requests
      - pushes
    
  - Slack
    - Payload URL: https://hooks.slack.com/services/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
    - Content type: application/json
    - enable SSL verification
    - select individual:
      - pull requests
  - Gimlet (if needed)
  - ClickUp (if needed)

When these steps are completed, you can remove yourself from collaborators and teams.


# Code setup
- If you don't need `api` directory, you can remove it entirely.
- If you plan to have multiple modules, you can rename `src` to something more meaningful or just put your main package code there.
- To make auto version bump working, you need to manually push `v0.1.0` tag at the very beginning.
- Rename `ds-repo-template` from all files to actual project name
  - `.circleci/.config`
  - `src/api/__main__.py`
  - `Dockerfile`
  - `pyproject.toml`

Remember to regenerate `poetry.lock` file:
```shell
poetry lock
```

## Packaging

In order for your package to be importable from another project, two approaches are possible:


### 1. Single package in a single repository

Organize your code as follows where `my_package` is the name of your package with `-` replaced by `_`:

```markdown
my_package/
├── __init__.py
├── some_code/
│ ├── __init__.py
```

In `pyproject.toml`:

```toml
[tool.poetry]
name = "my-package"
packages = [{ include = "my_package" }]
```

Then, from another project, you can import your package as follows:

```python
from my_package import some_code
```


### 2. Multiple packages in a single repository

Organize your code as follows:

```markdown
src/
├── my_package/
│   ├── __init__.py
├── my_other_package/
│   ├── __init__.py
```

In `pyproject.toml`:

```toml
[tool.poetry]
name = "my-package"
packages = [
    { from = "src", include = "my_package" },
    { from = "src", include = "my_other_package" },
]
```

Then, from another project, you can import your package as follows:

```python
import my_package
import my_other_package
```
