from lambda_utils import invoke_lambda


def test_AC():
    assert invoke_lambda('primos_arrojados/good/ribas-ac.c', 'primos_arrojados', 'c') == "Accepted"
    assert invoke_lambda('fso-escalonador-round-robin/good/slower_mas_good2.cpp', 'fso-escalonador-round-robin', 'cpp') == 'Accepted'
    assert invoke_lambda('fso-escalonador-round-robin/good/slower_mas_good3.cpp', 'fso-escalonador-round-robin', 'cpp') == 'Accepted'
    assert invoke_lambda('fso-escalonador-round-robin/good/slower_mas_good.c', 'fso-escalonador-round-robin', 'c') == 'Accepted'
    assert invoke_lambda('fso-escalonador-round-robin/good/sundfeld.c', 'fso-escalonador-round-robin', 'c') == 'Accepted'
    assert invoke_lambda('fso-escalonador-round-robin/good/sundfeld.cpp', 'fso-escalonador-round-robin', 'cpp') == 'Accepted'


def test_TL():
    assert invoke_lambda('primos_arrojados/slow/john-tle.c', 'primos_arrojados', 'c') == "Time Limit Exceeded"
    assert invoke_lambda('primos_arrojados/slow/ribas-tle.c', 'primos_arrojados', 'c') == "Time Limit Exceeded"
    assert invoke_lambda('primos_arrojados/slow/ribas2-tle.c', 'primos_arrojados', 'c') == "Time Limit Exceeded"
    assert invoke_lambda('fso-escalonador-round-robin/slow/sundfeld.cpp', 'fso-escalonador-round-robin', 'cpp') == 'Time Limit Exceeded'
    assert invoke_lambda('fso-escalonador-round-robin/slow/sundfeld2.cpp', 'fso-escalonador-round-robin', 'cpp') == 'Time Limit Exceeded'
