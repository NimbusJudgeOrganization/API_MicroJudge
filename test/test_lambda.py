from lambda_utils import invoke_lambda


def test_AC():
    assert invoke_lambda('fatorial/good/jorge.c', 'fatorial') == "Accepted"
    assert invoke_lambda('fatorial/good/jorge.c', 'fatorial') == "Accepted"
    assert invoke_lambda('primos_arrojados/good/ribas-ac.c', 'primos_arrojados') == "Accepted"


def test_TL():
    assert invoke_lambda('primos_arrojados/slow/john-tle.c', 'primos_arrojados') == "Time Limit Exceeded"
    assert invoke_lambda('primos_arrojados/slow/ribas-tle.c', 'primos_arrojados') == "Time Limit Exceeded"
    assert invoke_lambda('primos_arrojados/slow/ribas2-tle.c', 'primos_arrojados') == "Time Limit Exceeded"
