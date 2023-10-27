import numpy as np
import matplotlib.pyplot as plt
import argparse

parser = argparse.ArgumentParser(
                    prog='parse',
                    description='Generate a stat from parsing')

parser.add_argument('filename')
args = parser.parse_args()

insn = {}
insn_pairs = {}
insn_three = {}
opcodes = {}

with open(args.filename) as file:
    first = file.readline().strip()
    second = file.readline().strip()

    for third in file:
        third = third.strip()
        if (third == "Stat:"):
            break

        if (insn_pairs.get(first + "|" + second, None)):
            insn_pairs[first + "|" + second] += 1
        else:
            insn_pairs[first + "|" + second] = 1

        if(insn_three.get(first + "|" + second + "|" + third, None)):
            insn_three[first + "|" + second + "|" + third] += 1
        else:
            insn_three[first + "|" + second + "|" + third] = 1

        first = second
        second = third

    for line in file:
        if (line == "Match:\n"):
            break

        insn[line.split()[0]] = int(line.split()[1])

    for line in file:
        opcodes[line.split()[1]] = line.split()[0]

fig, ax = plt.subplots(3, figsize=(20, 40))

ax[0].xaxis.set_tick_params(rotation=90)
ax[1].xaxis.set_tick_params(rotation=90)
ax[2].xaxis.set_tick_params(rotation=90)

x = list(map(lambda x: x[1], sorted(opcodes.items(), key=lambda x: x[0])))
y = list(map(lambda x: x[1], sorted(insn.items(), key=lambda x: x[0])))
data = dict(sorted(zip(x, y), key=lambda x: x[1], reverse=True))
ax[0].bar(data.keys(), data.values())
# print(data.keys(), data.values())

data = dict(map(lambda x: [opcodes[x[0].split("|")[0]] + " and " + opcodes[x[0].split("|")[1]], x[1]], insn_pairs.items()))
data_median = np.median(list(data.values()))
data = dict(filter(lambda x: x[1] > data_median, data.items()))
data = dict(sorted(data.items(), key=lambda x: x[1], reverse=True))
ax[1].bar(data.keys(), data.values())
# print(data.keys(), data.values())

data = dict(map(lambda x:[opcodes[x[0].split("|")[0]] + " and " + opcodes[x[0].split("|")[1]] + " and " + opcodes[x[0].split("|")[2]], x[1]], insn_three.items()))
data_median = np.median(list(data.values()))
data = dict(filter(lambda x: x[1] > data_median, data.items()))
data = dict(sorted(data.items(), key=lambda x: x[1], reverse=True))
ax[2].bar(data.keys(), data.values())
# print(data.keys(), data.values())

plt.savefig('stats.png')