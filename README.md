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
  - Slack
  - Gimlet (if needed)

## Deploy keys
- Create CircleCI key 

## Secrets and variables / Actions
- Create a new repository secret
  - Name: `VERSIONING_TOKEN`
  - Secret: you can find `GitHub Tokens` in Bitwarden under `Development` collection

When these steps are completed, you can remove yourself from collaborators and teams.

