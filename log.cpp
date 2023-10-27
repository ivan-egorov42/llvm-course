#include <stdio.h>
#include <map>
#include <iostream>

static std::map <uint64_t, long long> stat;
static std::map <std::string, uint64_t> opcodes;

void insnLogger(char* opName, long int valID, uint64_t opcode) {
    std::string name{opName};
    stat[opcode]++;
    opcodes[name] = opcode;
    std::cout << opcode << std::endl;
}

void dump() {
    std::cout << "Stat:\n";

    for (auto i: stat) {
        std::cout << i.first << " " << i.second << std::endl;
    }

    std::cout << "Match:\n";

    for (auto op: opcodes) {
        std::cout << op.first << " " << op.second << std::endl;
    }
}
