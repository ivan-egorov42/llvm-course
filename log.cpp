#include <stdio.h>
#include <map>
#include <iostream>

static std::map <std::string, long long> stat;

void insnLogger(char* opName, long int valID) {
    if (!opName)
        return;
    std::string instr{opName};
    stat[instr]++;
}

void dump() {
    for (auto i: stat) {
        std::cout << i.first << " " << i.second << std::endl;
    }
}
