import pytest


def test_python_pass() -> None:
    x: int = 2
    assert x == 2

def test_python_fail() -> None:
    x: int = 2
    assert x == 3


@pytest.mark.parametrize(("lhs","rhs"), [(3, 4), (5, 7)]) 
def test_parameterized(lhs, rhs) -> None:
    assert lhs + 1 == rhs


