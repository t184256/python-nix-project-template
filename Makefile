.PHONY: unit coverage lint nix-tests installation-tests
.PHONY: lint-flake8 lint-codespell lint-spdx-check
.PHONY: check coverage-html clean

check: coverage lint
# not nix-tests, not installation-tests because it runs main
# not unit because it's included in coverage

unit:
	PYTHONPATH=. pytest

coverage:
	coverage run -m pytest --doctest-modules project_name tests  # TODO: replace
	coverage report --fail-under=100

coverage-html: coverage
	coverage html
	xdg-open htmlcov/index.html || true

lint: lint-flake8 lint-codespell lint-spdx-check

lint-flake8:
	flake8

lint-codespell:
	codespell

# TODO: replace with actual info
COPYRIGHT=SPDX-FileCopyrightText: 0000 Author Name <author@example.org>
LICENSE=SPDX-License-Identifier: CC-PDDC
lint-spdx-check:
	@echo spdx-check
	@(find . -name '*.py'; find . -name '*.sh') | \
	while IFS= read -r FILE; do \
		if [ $$(wc -c < $$FILE) = 0 ]; then \
			echo "  not checking SPDX tags of empty $$FILE."; \
			continue; \
		fi; \
		echo -n "  checking SPDX tags of $$FILE: "; \
		if ! grep -q "# ${COPYRIGHT}$$" $$FILE; then \
			echo "NO ${COPYRIGHT}"; exit 1; \
		fi; \
		if ! grep -q "# ${COPYRIGHT}$$" $$FILE; then \
			echo "NO ${LICENSE}"; exit 1; \
		fi; \
		echo 'OK'; \
	done
	@echo '  SPDX tags of Python files are in order.'


installation-tests:
	rm -rf .empty && mkdir .empty
	sh -c 'cd .empty && ../tests/installation/main.sh'

nix-tests:
	nix run .
	nix shell . -c tests/installation/main.sh
	nix flake check

clean:
	rm -rf ./htmlcov .empty
