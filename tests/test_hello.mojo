from testing import assert_true

from quantumojo.hello import hello_world


fn test_hello_world() raises:
    assert_true(hello_world() == "Hello, World!")
