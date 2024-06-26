Contributing to Aptos Labs Semgrep Rules
=========================

Thank you for your interest in contributing to Aptos Labs' `semgrep-rules`!

The information below will help you set up a local development environment, and perform common development tasks.

## Requirements

The only requirement for the `semgrep-rules` development environment is Python 3.7 or newer. Development and testing are actively performed on macOS and Linux, but Windows and other platforms supported by Python should also work.

## Development Steps

First, clone this repository:

```bash
git clone https://github.com/aptoslabs/semgrep-rules
cd semgrep-rules
```

Then [install the Semgrep CLI](https://semgrep.dev/docs/getting-started/), and you are ready to start development.

### Linting

First, [install `prettier`](https://prettier.io/docs/en/install), or use [`brew`](https://formulae.brew.sh/formula/prettier) to do so.

Use the following command to check rule files for formatting errors:

```bash
prettier --check '**/*.{yaml,yml}'
```

Any issues can be automatically fixed with the following command:

```bash
prettier --write '**/*.{yaml,yml}'
```

### Testing

You can run tests locally with:

```bash
semgrep --test --test-ignore-todo --metrics=off
```

To test a specific file:

```bash
semgrep --test --test-ignore-todo --metrics=off --config ./move/entry-friend-used-in-conjunction.yaml ./move/entry-friend-used-in-conjunction.move
```

### Development Practices

Before publishing a new rule or updating an existing one, review the checklist below:

- [ ] Check if the rule does not already exists. Review this repository and [Semgrep registry](https://semgrep.dev/r). If there already is a rule that finds the vulnerability your new rule is targeting, consider making updates to this rule instead of creating a new one.

- [ ] Add metadata. Semgrep [defines which metadata fields are required](https://semgrep.dev/docs/contributing/contributing-to-semgrep-rules-repository/#writing-a-rule-for-semgrep-registry)
    - [ ] Add a non-standard `metadata.description` field. It will be used as a description in the `semgrep-rules` README table.
    - For `metadata.references` provide a link to official documentation, Trail of Bits blogpost, GitHub issue, or some reputable website. Avoid linking to websites that may disappear in the future.

- [ ] Validate metadata against the official schema
    - Download python validation script `wget https://raw.githubusercontent.com/returntocorp/semgrep-rules/develop/.github/scripts/validate-metadata.py`
    - Download rules schema `wget https://raw.githubusercontent.com/returntocorp/semgrep-rules/develop/metadata-schema.yaml.schm`
    - Run `python ./validate-metadata.py -s ./metadata-schema.yaml.schm -f .`

- [ ] Add tests
  - [ ] At least one true positive (`ruleid: ` comment)
  - [ ] At least one true negative (`ok: ` comment)
  - Tests are allowed to crash when running them directly or to be meaningless
  - However, try writing tests that can be compiled or parsed by the language interpreter
  - The first few test cases should be easy to understand, the later should be more complex or check for edge-cases
  - [ ] Make sure all tests pass, run `semgrep --test --test-ignore-todo --metrics=off`

- [ ] Run official semgrep lints with `semgrep --validate --metrics=off --config ./<new-rule>.yaml`

- [ ] Review style of the rules
    - [ ] Use 2 spaces for indentation
    - [ ] Use `>-` for multiline messages
    - [ ] Use backticks in messages e.g., `$VAR`, `$FUNC`, `some.method()`
    - [ ] Run prettier (see [Linting](#linting))

- [ ] Check amount of false-positives on some large public repositories

- [ ] Check performance - take a look at [r2c methodology](https://github.com/returntocorp/semgrep-rules/blob/main/tests/performance/test_public_repos.py)

- [ ] Add the new rules to the README

### Documentation

We don't provide any documentation for the rules. All information that you need to understand a rule is inside it. Semgrep documentation can be found [here](https://semgrep.dev/docs/).

<!-- The first version of this page was heavily inspired by https://raw.githubusercontent.com/trailofbits/semgrep-rules/main/CONTRIBUTING.md -->
