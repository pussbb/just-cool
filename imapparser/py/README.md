I don't know why but python wrapper fails randomly

```shell
ewewe$ python3 ./setup.py build
Compiling pyimapparser.pyx because it changed.
[1/1] Cythonizing pyimapparser.pyx
running build
running build_ext
building 'pyimapparser' extension
x86_64-linux-gnu-gcc -pthread -DNDEBUG -g -fwrapv -O2 -Wall -Wstrict-prototypes -g -fdebug-prefix-map=/build/python3.5-7CCmgg/python3.5-3.5.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -fPIC -I/usr/include/python3.5m -c pyimapparser.cpp -o build/temp.linux-x86_64-3.5/pyimapparser.o -g -std=c++11
cc1plus: warning: command line option ‘-Wstrict-prototypes’ is valid for C/ObjC but not for C++
x86_64-linux-gnu-gcc -pthread -DNDEBUG -g -fwrapv -O2 -Wall -Wstrict-prototypes -g -fdebug-prefix-map=/build/python3.5-7CCmgg/python3.5-3.5.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 -fPIC -I/usr/include/python3.5m -c imapparser.cpp -o build/temp.linux-x86_64-3.5/imapparser.o -g -std=c++11
cc1plus: warning: command line option ‘-Wstrict-prototypes’ is valid for C/ObjC but not for C++
x86_64-linux-gnu-g++ -pthread -shared -Wl,-O1 -Wl,-Bsymbolic-functions -Wl,-Bsymbolic-functions -Wl,-z,relro -Wl,-Bsymbolic-functions -Wl,-z,relro -g -fdebug-prefix-map=/build/python3.5-7CCmgg/python3.5-3.5.3=. -fstack-protector-strong -Wformat -Werror=format-security -Wdate-time -D_FORTIFY_SOURCE=2 build/temp.linux-x86_64-3.5/pyimapparser.o build/temp.linux-x86_64-3.5/imapparser.o -o build/lib.linux-x86_64-3.5/pyimapparser.cpython-35m-x86_64-linux-gnu.so

```

if everything is ok you will see
```shell
ewewe$ /usr/bin/python3.5 main.py
[8, b'wewe', b' sdasdas ', b'UID', b'BODY<1...77>', b'BODY<33.55>[dsfsd sdfdsf sdfdsf]', [], [b'UID', b'00', [b'dodod', b'assa'], b'sdasd', b'asdasd'], b'R\x80']
[b'1', [b'UID', b'387', b'ENVELOPE', [b'Wed, 11 Nov 2015 08:37:14 -0500', b' dsfd ( ss ) # ( ', [[b'NIL', b'NIL', b'MAIL-SYSTEM', b'test.centos5486.com'], [[b'NIL', b'NIL', b'MAIL-SYSTEM', b'test.centos5486.com'], [[b'NIL', b'NIL', b'MAIL-SYSTEM', b'test.centos5486.com'], [[b'NIL', b'NIL', b'rtrt-usage-stats', b'rtrt.com'], b'NIL', b'NIL', b'NIL', b'<H0000000000354e1.1447249034.test.centos5486.com@MHS>']]]]]]]
[b'2', [b'UID', b'383']]

Process finished with exit code 0

```

but . shit happens

```shell
ewewe$ /usr/bin/python3.5 main.py
[8, b'wewe', b' sdasdas ', b'UID', b'BODY<1...77>', b'BODY<33.55>[dsfsd sdfdsf sdfdsf]', [], [b'UID', b'00', [b'dodod', b'assa'], b'sdasd', b'asdasd']]
terminate called after throwing an instance of 'Imap::UnexcepectedTagChar'
  what():  Unknown char: !

Process finished with exit code 134 (interrupted by signal 6: SIGABRT)

ewewe$ /usr/bin/python3.5 main.py
terminate called after throwing an instance of 'Imap::UnexcepectedTagChar'
  what():  Unknown char: �

Process finished with exit code 134 (interrupted by signal 6: SIGABRT)

```


if comment this line
```cpp
# throw Imap::UnexcepectedTagChar(&current);
```


you will get 

```shell
qweqwe$ /usr/bin/python3.5 /home/pussbb/PycharmProjects/py_imap_parser/main.py
[8, b'wewe', b' sdasdas ', b'U:9\x18ID', b'B:9\x18ODY<1...77>', b'B:9\x18ODY<33.55>[dsfsd sdfdsf sdfdsf]', [], [b'U:9\x18\x01ID', b'0:9\x18\x010', [b'd:9\x18\x02odod', b'a:9\x18\x02ssa'], b's:9\x18\x01dasd', b'a:9\x18\x01sdasd']]
[b'1rce', [b'Urce\x01ID', b'3rce\x0187', b'Erce\x01NVELOPE', [b'Wed, 11 Nov 2015 08:37:14 -0500', b' dsfd ( ss ) # ( ', [[b'Nrce\x04IL', b'Nrce\x04IL', b'MAIL-SYSTEM', b'test.centos5486.com'], [[b'Nrce\x05IL', b'Nrce\x05IL', b'MAIL-SYSTEM', b'test.centos5486.com'], [[b'Nrce\x06IL', b'Nrce\x06IL', b'MAIL-SYSTEM', b'test.centos5486.com'], [[b'Nrce\x07IL', b'Nrce\x07IL', b'rtrt-usage-stats', b'rtrt.com'], b'Nrce\x06IL', b'Nrce\x06IL', b'Nrce\x06IL', b'<H0000000000354e1.1447249034.test.centos5486.com@MHS>']], b'9rce\x04\xb5U\x02']]]]]
[b'2', [b'UID', b'383']]
```

a lot broken ...
