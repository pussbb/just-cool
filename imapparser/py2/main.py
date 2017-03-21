# -*- coding: utf-8 -*-
"""
"""
from __future__ import generator_stop

import sys
sys.path.append('./build/lib.linux-x86_64-3.5/')

from pyimapparser import Parser


ll=b"{8} 'wewe' \" sdasdas \" UID BODY<1...77> BODY<33.55>[dsfsd sdfdsf sdfdsf] () (UID 00 (dodod assa) sdasd asdasd)"
#ll=b'1 (UID 387 ENVELOPE ("Wed, 11 Nov 2015 08:37:14 -0500" " dsfd ( ss ) # ( " ((NIL NIL "MAIL-SYSTEM" "test.centos5486.com")) ((NIL NIL "MAIL-SYSTEM" "test.centos5486.com")) ((NIL NIL "MAIL-SYSTEM" "test.centos5486.com")) ((NIL NIL "rtrt-usage-stats" "rtrt.com")) NIL NIL NIL "<H0000000000354e1.1447249034.test.centos5486.com@MHS>")))'


for _ in range(1, 1000):
    print(list(Parser(ll, [])))

raise SystemExit
print(list(ImapParser(ll)))



lines = [
   b'1 (UID 387 ENVELOPE ("Wed, 11 Nov 2015 08:37:14 -0500" " dsfd ( ss ) # ( " ((NIL NIL "MAIL-SYSTEM" "test.centos5486.com")) ((NIL NIL "MAIL-SYSTEM" "test.centos5486.com")) ((NIL NIL "MAIL-SYSTEM" "test.centos5486.com")) ((NIL NIL "rtrt-usage-stats" "rtrt.com")) NIL NIL NIL "<H0000000000354e1.1447249034.test.centos5486.com@MHS>")))',
   b'2 (UID 383)'
]

for line in lines:
    print(list(Parser(line)))

