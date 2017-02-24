#include <iostream>

#include "imapparser.h"

using namespace std;


void printParserResults(Imap::ImapParser* parser, Imap::ImapParser::TAG tag) {

    switch(tag) {
        case Imap::ImapParser::LITERAL: {
            std::cout << "Found literal value : '" << parser->getLiteralValue() << "'" << endl;
            break;
        }
        case Imap::ImapParser::QUOTED: {
            std::cout << "Found qouted printable value : '" << parser->getQuotedText() << "'" << endl;
            break;
        }
        case Imap::ImapParser::ATOM: {
            std::cout << "Found ATOM value : '" << parser->getAtomText() << "'" << endl;
            break;
        }
        case Imap::ImapParser::LIST: {
            std::cout << "Found start of list: ---- " << endl;
            ///new Imap::ImapParser(parser->it)
            Imap::ImapParser::TAG tag2;
            while(parser->hasNext()) {
                tag2 = parser->nextTag();
                if (tag2 == Imap::ImapParser::LIST_END)
                    break;
                printParserResults(parser, tag2);
            }
            std::cout << "End of List: ---- " << endl;
            break;
        }

        default:
            break;
    }

}

int main(int argc, char *argv[])
{
    std::string str = "{8} 'wewe' \" sdasdas \" UID BODY<1...77> BODY<33.55>[dsfsd sdfdsf sdfdsf] () (UID 00 (dodod assa) sdasd asdasd)";
    Imap::ImapParser* parser = new Imap::ImapParser(&str);
    while(parser->hasNext()) {
        printParserResults(parser, parser->nextTag());
    }
    delete parser;
    cout << "Hello World!" << endl;
    return 0;
}
