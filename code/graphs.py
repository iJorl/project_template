import sys,os, random
graphs = 10;
random.seed(1);
seeds = random.sample(range(1,1000),graphs)
for i in range(graphs):
    os.system("graph_generator.py " + str(seeds[i]) + " " + str(i) + " > " + "graphs/graph_" + str(i) + ".txt")
