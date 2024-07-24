# Aptos Labs public Semgrep rules

This repository features Semgrep rules developed by Aptos Labs, now available to the public. These rules are integral to our continuous development efforts, utilized in our security audits and internal projects, and will evolve as we discover new techniques.

We share these rules with the community to aid Smart Contract developers in enhancing their code security and to provide researchers with a valuable tool to maximize the impact of their audits.

Visit [Testing Handbook](https://appsec.guide/docs/static-analysis/semgrep/) for Semgrep guidance.

## Using Semgrep

Before testing rules, make sure your Semgrep version `>= 1.80.0`:
```shell
# Check the OSS semgrep 
$ semgrep --version
1.81.0
```

If you have pro engine installed and want to leverage it, also ensure its version `>= 1.80.0`, as the pro engine **might have a different version** from the OSS engine:
```shell
$ semgrep install-semgrep-pro
Semgrep Pro Engine will be installed in /some/path/.../
Downloading... ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━ 180.3/180.3 MB 77.6 MB/s 0:00:00

Successfully installed Semgrep Pro Engine (version 1.80.0)!
```

You can clone this repository, navigate to the root folder of your project, and run individual rules using the command below :

```shell
$ semgrep --config /path/to/semgrep-rules/semgreprule.yml
```

To run all rules from the cloned repository:

```shell
$ semgrep --config /path/to/semgrep-rules/ .
```

## Useful flags

Semgrep will run against all supported code files except for those in your `.gitignore` file. If you want to run the rules against all files and directories, including those in your `.gitignore`, add the `--no-git-ignore` flag.

```shell
$ semgrep --config /path/to/semgrep-rules/ . --no-git-ignore
```

You can also tell Semgrep to ignore files and directories that match any pattern. For instance, if you want to tell Semgrep to ignore all Rust test files you can run the following:


```shell
$ semgrep --config /path/to/semgrep-rules/ . --exclude='*test.rs'
```

Use `-o` and `--sarif` to output results to a file in sarif format:

```shell
$ semgrep --config /path/to/semgrep-rules/complexity.yml --sarif -o leaks.sarif'
```

## Rules

### Move
| ID | Playground | Impact | Confidence | Description |
| -- | :--------: | :----: | :--------: | ----------- |


## Contributing

Pull Requests and issues are welcomed!

See [CONTRIBUTING.md](CONTRIBUTING.md) for more information.

## Licensing

The rules defined in this repository are licensed under Apachev2.