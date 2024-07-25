import os
import yaml
from itertools import chain
from pathlib import Path
from typing import List


SEVERITY_MAP = {
    'INFO': "ℹ️",
    'WARNING': "⚠️",
    'ERROR': "❌",
    None: "🌫️",
}

IMPACT_MAP = {
    'LOW': "🔵",
    'MEDIUM': "🟡",
    'HIGH': "🔴",
    None: "",
}

CONFIDENCE_MAP = {
    'LOW': "🌕",
    'MEDIUM': "🌗",
    'HIGH': "🌘",
    None: "",
}


def list_rules(directory: str) -> List[tuple[str, str]]:
    """
    List all rule files in the given directory
    """
    path = Path(directory)
    result : List[tuple[str, str]] = []
    if not path.is_dir():
        raise ValueError(f'{directory} is not a directory')
    for rule in chain(path.glob('**/*.yaml'), path.glob('**/*.yml')):
        name = rule.stem
        parent = rule.parent
        test_file = os.path.join(parent, f'{name}.move')
        if not os.path.exists(test_file):
            raise ValueError(f'Test case for {name} does not exist')
        result.append((str(rule), test_file))
    return result


def generate_rule_table(rules: List[tuple[str, str]]):
    """
    Generate a rule table for the given rules
    """
    print('ID | Severity | IMPACT | Confidence | Message')
    print(':-:|:--------:|:------:|:----------:|--------')
    for rule, test in rules:
        with open(rule, 'r') as f:
            rules = yaml.safe_load(f).get('rules')
            for r in rules:
                id = r.get('id')
                message = r.get('message')
                severity = r.get('severity')
                
                meta = r.get('metadata')
                impact = meta.get('impact')
                confidence = meta.get('confidence')
                print(f'`{id}` | {SEVERITY_MAP[severity]} | {IMPACT_MAP[impact]} | {CONFIDENCE_MAP[confidence]} | {message}')
                


def main():
    rules = list_rules('rules')
    generate_rule_table(rules)


if __name__ == '__main__':
    main()