import pytest


def test_python_pass():
    x: int = 2
    assert x == 2


def test_python_fail():
    x: int = 2
    assert x == 3


@pytest.mark.parametrize(("lhs","rhs"), [(3, 4), (5, 7)]) 
def test_parameterized(lhs, rhs):
    assert lhs + 1 == rhs


