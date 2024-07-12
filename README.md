# Aptos Labs public Semgrep rules for Move

This repository features Semgrep rules for Move developed and maintained by Aptos Labs. These rules are integral to our continuous security efforts, are utilized in our code audits and internal projects, and will evolve as we discover new code patterns.

We share these rules with the community to aid Smart Contract developers in enhancing their code security and to provide researchers with a valuable tool to maximize the impact of their audits.

Trail of Bit's [Testing Handbook](https://appsec.guide/docs/static-analysis/semgrep/) provides a great introduction to Semgrep.

## Using Semgrep

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
| public-friend-entry | :--------: | :----: | :--------: | Identify all functions where both scope identifier friend and entry are used, since doing this makes the function callable by cli even if `public(friend)` is used. |
| public-friend-entry | :--------: | :----: | :--------: | Try to identify functions which used an object without verifying `&signer` owns the object. |
| objects-in-group-stored-without-account | :--------: | :----: | :--------: | Identify functions that store different objects under the same resource group in the same account is not recommended. Transferring one of them can influence the entire collection. Objects should be stored in separate object accounts. |
| constructor-ref-leak | :--------: | :----: | :--------: | Identify functions which leak the `ConstructorRef`. `ConstructorRef` allows adding resources to an object and generate other capabilities (or “Refs”). |
| signer-leak | :--------: | :----: | :--------: | ----------- |
| public_ramdomness | :--------: | :----: | :--------: | ----------- | | :--------: | :----: | :--------: | ----------- |

## Contributing

Pull Requests and issues are welcomed!

See [CONTRIBUTING.md](CONTRIBUTING.md) for more information.

## Licensing

The rules defined in this repository are licensed under Apachev2.
