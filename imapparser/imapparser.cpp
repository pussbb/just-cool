#include "imapparser.h"


Imap::ImapParser::ImapParser(std::string* str) {
    it = str->begin();
    end = str->end();
}

Imap::ImapParser::~ImapParser() {

}

bool Imap::ImapParser::isAtom(const char * str) {
    for(char const * p = str; *p; ++p) {
           if (!isalnum(*p) && *p != '.')
               return false;
       }
    return true;
}

Imap::ImapParser::TAG Imap::ImapParser::nextTag() {
    skipWhiteSpaces();
    if (!hasNext()) {
        return END;
    }
    current = *it++;

    if (current == '(') {
        ++listCount;
        return LIST;
    } else if ( current == ')') {
        if (--listCount >= 0) {
            ++it;
        }
        return LIST_END;
    } else if (current == '"' || current == '\''){
        return QUOTED;
    } else if (current == '{') {
        return LITERAL;
    } else if (isAtom(&current)) {
        return ATOM;
    }
    throw Imap::UnexcepectedTagChar(&current);
}

void Imap::ImapParser::skipWhiteSpaces() {
    while (hasNext() && isblank(*it)) {
        ++it;
    }
}

std::string Imap::ImapParser::readUntil(const char delim, bool appendDelim) {
    std::string res = "";
    char c = *it;
    while (hasNext() || c != *end) {
       /// std::cout << "delim: '" << delim << "' ends: " << res.back() << " char: " << c << std::endl;
        if (delim == ' ') {
            if (listCount > 0 && c == ')') {
                break;
            }
            if (c == '[') {
                ++it;
                res.push_back(c);
                res.append(readUntil(']', true));
                break;
            }
        }

        bool isPrevEscaping = res.back() == '\\';
        if (c == delim && !isPrevEscaping) {
            if (appendDelim) {
                res.push_back(c);
            }
            ++it;
            break;
        }
        res.push_back(c);
        c = *++it;
    }
    return res;
}
