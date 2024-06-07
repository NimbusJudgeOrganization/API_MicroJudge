from lambda_utils import invoke_lambda


def test_fatorial_AC1():
    assert invoke_lambda('test/fatorial/good/jorge.c', 'fatorial') == "Accepted"


def test_fatorial_AC2():
    assert invoke_lambda('test/fatorial/good/jorge.c', 'fatorial') == "Accepted"


def test_primos_arrojados_AC1():
    assert invoke_lambda('test/primos_arrojados/good/ribas-ac.c', 'primos_arrojados') == "Accepted"


def primos_arrojados_TL1():
    assert invoke_lambda('test/primos_arrojados/slow/john-tle.c', 'primos_arrojados') == "Time Limit Exceeded"


def test_primos_arrojados_TL2():
    assert invoke_lambda('test/primos_arrojados/slow/ribas-tle.c', 'primos_arrojados') == "Time Limit Exceeded"


def test_primos_arrojados_TL3():
    assert invoke_lambda('test/primos_arrojados/slow/ribas2-tle.c', 'primos_arrojados') == "Time Limit Exceeded"


