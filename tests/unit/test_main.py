# SPDX-FileCopyrightText: 0000 Author Name <author@example.org>
# SPDX-License-Identifier: CC-PDDC

# TODO: expand a little

def test_main():
    from unittest import mock
    from unittest.mock import patch
    import io
    import project_name.main
    assert 'main' in dir(project_name.main)
    with mock.patch('sys.stdout', new=io.StringIO()) as stdout_main:
	    main()
    assert stdout_main.getvalue() == 'Hello world!\n'

