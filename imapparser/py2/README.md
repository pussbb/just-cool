
sometimes

```shell
/usr/bin/python3.5  main.py
[8, b'wewe', b' sdasdas ', b'UID', b'BODY<1...77>', b'BODY<33.55>[dsfsd sdfdsf sdfdsf]', [], [b'UID', b'00', [b'dodod', b'assa'], b'sdasd', b'asdasd']]
Traceback (most recent call last):
  File "/home/pussbb/PycharmProjects/py_imap_parser/main.py", line 17, in <module>
    print(list(Parser(ll, [])))
  File "pyimapparser.pyx", line 69, in pyimapparser.Parser.__next__ (pyimapparser.cpp:1562)
    raise KeyError(<bytes>self.current)
KeyError: b'\xc2'
```
