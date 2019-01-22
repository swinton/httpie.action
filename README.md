# httpie-action

> Human-friendly interactions with third-party web services through **GitHub Actions** :zap:

A [**GitHub Actions**](https://developer.github.com/actions/)-compatible version of [**HTTPie**](https://github.com/jakubroztocil/httpie), allowing you to interact with any third-party service that exposes an API over HTTP in your [development workflow](https://developer.github.com/actions/creating-workflows/).

## Simple example

To `POST` some `JSON` data, `{"hello": "world"}`, to `https://httpbin.org/anything` on every `push` to the repo:

```hcl
workflow "Call external API" {
  on = "push"
  resolves = ["Call httpbin"]
}

action "Call httpbin" {
  uses = "swinton/httpie-action@master"
  args = ["POST", "httpbin.org/anything", "hello=world"]
}
```

## More examples

### Using output in a downstream action

In this example, we'll open an issue in the current repository, and get the details of the issue that was opened in a subsequent action.

**Note**, this is made possible since the response body is saved in a file, `$HOME/$GITHUB_ACTION.response.body`. Also available, is the response headers (`$HOME/$GITHUB_ACTION.response.headers`), and full response (`$HOME/$GITHUB_ACTION.response`).

```hcl
action "Open issue" {
  uses = "swinton/httpie-action@master"
  args = ["--auth-type=jwt", "--auth=$GITHUB_TOKEN", "POST", "api.github.com/repos/$GITHUB_REPOSITORY/issues", "title=Hello\\ world"]
  secrets = ["GITHUB_TOKEN"]
}

action "Get issue details" {
  needs = ["Open issue"]
  uses = "actions/bin/sh@master"
  args = ["cat $HOME/Open\\ issue.response.body"]
}
```

### Trigger another workflow

In this example, we'll trigger a separate workflow, via [the repository's dispatches endpoint](https://developer.github.com/actions/creating-workflows/triggering-a-repositorydispatch-webhook/#how-to-trigger-the-repositorydispatch-webhook).

**Note**, `$PAT` refers to a personal access token, [created separately](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/), and [stored as a secret](https://developer.github.com/actions/creating-workflows/storing-secrets/).

```hcl
action "Trigger workflow" {
  uses = "swinton/httpie-action@master"
  args = ["--auth-type=jwt", "--auth=$PAT", "POST", "api.github.com/repos/$GITHUB_REPOSITORY/dispatches", "Accept:application/vnd.github.everest-preview+json", "event_type=demo"]
  secrets = ["PAT"]
}
```

## Presets

Some [HTTPie presets](https://github.com/jakubroztocil/httpie/blob/358342d1c915d6462a080a77aefbb20166d0bd5d/README.rst#config) are applied by default by the included [`config.json`](config.json), that make sense in the context of GitHub Actions, namely:

1. [`--check-status`](https://github.com/jakubroztocil/httpie/blob/358342d1c915d6462a080a77aefbb20166d0bd5d/README.rst#scripting): Causes a workflow to exit if the HTTP status is one of `3xx`, `4xx`, or `5xx`
1. [`--ignore-stdin`](https://github.com/jakubroztocil/httpie/blob/358342d1c915d6462a080a77aefbb20166d0bd5d/README.rst#best-practices): Disables HTTPie's default behaviour of automatically reading STDIN, typically not desirable during non-interactive invocations
1. [`--default-scheme=https`](https://github.com/jakubroztocil/httpie/blob/358342d1c915d6462a080a77aefbb20166d0bd5d/README.rst#custom-default-scheme): Assumes `https://` is the default prefix for URLs, so you can just say (for example) `api.github.com/zen` as opposed to `https://api.github.com/zen`
1. [`--print=hb`](https://github.com/jakubroztocil/httpie/blob/358342d1c915d6462a080a77aefbb20166d0bd5d/README.rst#output-options): Prints both response headers _and_ response body in the output

## Plugins

A few [authentication plugins](https://github.com/jakubroztocil/httpie/blob/358342d1c915d6462a080a77aefbb20166d0bd5d/README.rst#auth-plugins) are included:

1. [`httpie-api-auth`](https://github.com/pd/httpie-api-auth): Provides support for the ApiAuth authentication scheme
1. [`httpie-aws-auth`](https://github.com/httpie/httpie-aws-auth): Provides support AWS authentication
1. [`httpie-hmac-auth`](https://github.com/guardian/httpie-hmac-auth): Provides support for HMAC authentication
1. [`httpie-jwt-auth`](https://github.com/teracyhq/httpie-jwt-auth): Provides support for JSON Web Tokens

## More info

Usage docs for HTTPie are [here](https://github.com/jakubroztocil/httpie).
