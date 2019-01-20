# httpie-action

> Human-friendly interactions with third-party web services with **GitHub Actions**.

[**GitHub Actions**](https://developer.github.com/actions/) compatible version of [**HTTPie**](https://github.com/jakubroztocil/httpie).

## Usage

Use as part of a GitHub Action like so:

```hcl
workflow "Call external API" {
  on = "push"
  resolves = ["Call httpbin"]
}

action "Call httpbin" {
  uses = "swinton/httpie-action@master"
  args = ["httpbin.org/anything", "foo=bar"]
}
```

## Presets

Some [HTTPie presets](https://github.com/jakubroztocil/httpie/blob/358342d1c915d6462a080a77aefbb20166d0bd5d/README.rst#config) are applied by default by the included [`config.json`](config.json), that make sense in the context of GitHub Actions, namely:

1. [`--check-status`](https://github.com/jakubroztocil/httpie/blob/358342d1c915d6462a080a77aefbb20166d0bd5d/README.rst#scripting): Causes a workflow to exit if the HTTP status is one of `3xx`, `4xx`, or `5xx`
1. [`--ignore-stdin`](https://github.com/jakubroztocil/httpie/blob/358342d1c915d6462a080a77aefbb20166d0bd5d/README.rst#best-practices): Disables HTTPie's default behaviour of automatically reading STDIN, typically not desirable during non-interactive invocations
1. [`--default-scheme=https`](https://github.com/jakubroztocil/httpie/blob/358342d1c915d6462a080a77aefbb20166d0bd5d/README.rst#custom-default-scheme): Assumes `https://` is the default prefix for URLs, so you can just say (for example) `api.github.com/zen` as opposed to `https://api.github.com/zen`
1. [`--print=hb`](https://github.com/jakubroztocil/httpie/blob/358342d1c915d6462a080a77aefbb20166d0bd5d/README.rst#output-options): Prints both response headers _and_ response body in the output

## More info

Usage docs for HTTPie are [here](https://github.com/jakubroztocil/httpie).
