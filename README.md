# httpie-action

GitHub Actions compatible version of [HTTPie](https://github.com/jakubroztocil/httpie).

## Usage

Use as part of a GitHub Action like so:

```hcl
workflow "Call external API" {
  on = "push"
  resolves = ["Call httpbin"]
}

action "Call httpbin" {
  uses = "swinton/httpie-action@master"
  args = ["--ignore-stdin", "https://httpbin.org/anything", "foo=bar"]
}
```

## More info

Usage docs for HTTPie are [here](https://github.com/jakubroztocil/httpie).
