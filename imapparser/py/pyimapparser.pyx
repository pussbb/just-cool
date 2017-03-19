# -*- coding: utf-8 -*-
"""
"""
from __future__ import generator_stop

from libcpp.string cimport string
from libcpp cimport bool


cdef extern from "imapparser.h" namespace "Imap":
    cdef cppclass ImapParser:
        ImapParser(string*) except +
        ctypedef enum TAG "TAG":
            END "Imap::ImapParser::TAG::END",
            ATOM "Imap::ImapParser::TAG::ATOM",
            LITERAL "Imap::ImapParser::TAG::LITERAL",
            LIST "Imap::ImapParser::TAG::LIST",
            LIST_END "Imap::ImapParser::TAG::LIST_END",
            QUOTED "Imap::ImapParser::TAG::QUOTED"
        bool hasNext()
        TAG nextTag()
        long getLiteralValue()
        string getQuotedText()
        string getAtomText()

cdef class RersponseTokanize:
    cdef ImapParser* c_parser
    cdef string line
    def __cinit__(self, line):
        self.line = line
        self.c_parser = new ImapParser(&self.line)

    def __dealloc__(self):
        del self.c_parser

    def __iter__(self):
        return self

    def __next__(self):
        if not self.c_parser.hasNext():
            raise StopIteration

        cdef ImapParser.TAG tag = self.c_parser.nextTag()
        if tag == ImapParser.TAG.LITERAL:
            return self.c_parser.getLiteralValue()
        if tag == ImapParser.TAG.QUOTED:
            return self.c_parser.getQuotedText()
        if tag == ImapParser.TAG.ATOM:
            return self.c_parser.getAtomText()
        if tag == ImapParser.TAG.LIST:
            return [i for i in self]
        if tag == ImapParser.TAG.LIST_END or tag == ImapParser.TAG.END:
            raise StopIteration