# Aptos Labs public Semgrep rules for Move

This repository features Semgrep rules for Move developed and maintained by Aptos Labs. These rules are integral to our continuous security efforts, are utilized in our code audits and internal projects, and will evolve as we discover new code patterns.

We share these rules with the community to aid Smart Contract developers in enhancing their code security and to provide researchers with a valuable tool to maximize the impact of their audits.

Trail of Bit's [Testing Handbook](https://appsec.guide/docs/static-analysis/semgrep/) provides a great introduction to Semgrep.

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
ID | Severity | IMPACT | Confidence | Message
:-:|:--------:|:------:|:----------:|--------
`public-randomness` | ℹ️ | 🔴 | 🌕 | If a public function directly or indirectly invokes the randomness API, a malicious user can abuse the composability of this function and abort the transaction if the result is not as desired. This allows the user to keep trying until they achieve a beneficial outcome, undermining the randomness.
`missing-ownership-check` | ❌ | 🔴 | 🌗 | The function does not verify the ownership of the object passed to it by the user. This can allow anyone to use another person's object, such as representing a subscription, bypassing the payment requirement.
`constructor-ref-leak` | ⚠️ | 🔴 | 🌕 | Leaking the ConstructorRef via public functions can create significant security vulnerabilities. The ConstructorRef permits adding resources to an object and generating other capabilities (or "Refs"), which can be exploited by attackers to manipulate the object beyond intended use.
`signer-leak` | ℹ️ | 🔴 | 🌗 | Returning a signer or &signer from a public function can introduce significant security vulnerabilities. When a function exposes a signer, it grants the recipient the ability to perform any operations on behalf of that address, such as transferring assets, withdrawing funds, and deploying contracts.
`public-friend-entry` | ⚠️ | 🔴 | 🌘 | Using both the scope identifier `friend` and `entry` in a function make it callable by any transaction, even if public(friend) is used. This can inadvertently expose sensitive functionality to unauthorized users, potentially leading to security vulnerabilities.

## Contributing

Pull Requests and issues are welcomed!

See [CONTRIBUTING.md](CONTRIBUTING.md) for more information.

## Licensing

The rules defined in this repository are licensed under Apachev2.
