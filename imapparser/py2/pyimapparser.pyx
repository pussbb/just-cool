# -*- coding: utf-8 -*-
"""
"""

from libcpp.string cimport string
from libcpp.vector cimport vector
from libcpp cimport bool, int

from cython.operator cimport dereference, postincrement, preincrement,\
                             predecrement

cdef extern from "ctype.h":
    int isblank ( int c )
    int isalnum ( int c )
    int atoi (const char * str)

cdef Py_UCS4 LIST_START = '('
cdef Py_UCS4 LIST_END = ')'
cdef Py_UCS4 LITERAL_START = '{'
cdef Py_UCS4 LITERAL_END = '}'
cdef Py_UCS4 DOUBLE_QUOTE = '"'
cdef Py_UCS4 SINGLE_QUOTE = '\''
cdef Py_UCS4 WHITESPACE = ' '
cdef Py_UCS4 SQUARE_BRACKETS_START = '['
cdef Py_UCS4 SQUARE_BRACKETS_END = ']'
cdef Py_UCS4 ESCAPING_CHAR = '\\'
cdef Py_UCS4 END_OF_LINE = '\0'


cdef class Parser:
    cdef string line
    cdef string.iterator it
    cdef vector[string] literals
    cdef char current
    cdef int list_count

    def __init__(self, line, literals):
        self.line = line
        self.it = self.line.begin()
        self.literals = literals
        self.list_count = 0

    def __iter__(self):
        return self

    def __next__(self):
        if not self.has_next():
            raise StopIteration()

        self.skipWhiteSpaces()
        self.current = dereference(postincrement(self.it))

        if self.current == LIST_START:
            preincrement(self.list_count)
            return [item for item in self]
        elif self.current == LIST_END:
            if predecrement(self.list_count) >= 0:
                preincrement(self.it)
            raise StopIteration()
        elif self.current == DOUBLE_QUOTE or self.current == SINGLE_QUOTE:
            return self.read_until(self.current)
        elif self.current == LITERAL_START:
            return atoi(self.read_until(LITERAL_END).c_str())
        elif self.is_atom(self.current):
            return <bytes>self.current + self.read_until(WHITESPACE)
        elif self.current == END_OF_LINE:
            raise StopIteration()

        raise KeyError(<bytes>self.current)

    cdef bool has_next(self):
        return self.it != self.line.end()

    cdef void skipWhiteSpaces(self):
        while self.has_next() and isblank(dereference(self.it)):
            preincrement(self.it)

    cdef bool is_atom(self, const char & char_):
        return isalnum(char_)

    cdef string read_until(self, const char & delim, bool append_delim=False):
        cdef string res
        cdef char char_ = dereference(self.it)
        while self.has_next() or char_ != dereference(self.line.end()):
            if delim == WHITESPACE:
                if self.list_count > 0 and char_ == LIST_END:
                    break
                if char_ == SQUARE_BRACKETS_START:
                    preincrement(self.it)
                    res.push_back(char_)
                    res.append(self.read_until(SQUARE_BRACKETS_END, True))
                    break

            if char_ == delim and not dereference(res.end()) == ESCAPING_CHAR:
                if append_delim:
                    res.push_back(char_)
                preincrement(self.it)
                break
            res.push_back(char_)
            char_ = dereference(preincrement(self.it))
        return res
