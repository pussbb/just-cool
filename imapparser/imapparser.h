#ifndef IMAPPARSER_H
#define IMAPPARSER_H

#include <string>
#include <iostream>
#include <exception>
#include <functional>

namespace Imap {

    class UnexcepectedTagChar : public std::exception {
        public:
            explicit UnexcepectedTagChar(const std::string& msg): message_(msg) {}
            explicit UnexcepectedTagChar(const char * char_): message_("Unknown char: " + std::string(char_)) {}
            virtual const char* what() const throw() {
                return message_.c_str();
            }
        private:
            std::string message_;
    };


    class ImapParser
    {
        public:
            enum TAG {END, ATOM, LITERAL, LIST, LIST_END, QUOTED};
            ImapParser(std::string* str);
            ~ImapParser();
            bool inline hasNext() const {return *it != *end;}
            TAG nextTag();
            long inline getLiteralValue() {return atol(readUntil('}').c_str());}
            std::string inline getQuotedText() { return readUntil(current);}
            std::string inline getAtomText() { return std::string(&current) + readUntil(' ');}

        private:
            std::string::iterator it;
            std::string::iterator end;
            void skipWhiteSpaces();
            char current;
            int listCount = 0;
            std::string inline readUntil(const char delim) {return readUntil(delim, false);}
            std::string readUntil(const char delim, bool appendDelim);
            bool isAtom(const char *str);
    };
}

#endif // IMAPPARSER_H
