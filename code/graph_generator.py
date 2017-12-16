import random, math
random.seed(42);

#set number of vertices
n = random.randint(20,100);
xmin = 0; xmax = 30;
ymin = 0; ymax = 30;
mdist = round(math.sqrt(xmax**2 + ymax**2))
colLimit = 10;

#create nodes
nodes = [[i+1, 0,0,round(random.uniform(xmin, xmax),2) , round(random.uniform(ymin, ymax),2)] for i in range(n)]
def dist(a, b):
    return round(math.sqrt((nodes[a][3] - nodes[b][3])**2 + (nodes[a][4]-nodes[b][4])**2))

deg = [0 for i in range(n)]

s = set()
for i in range(n):
    for j in range(n):
        if i <= j:
            continue
        p = 1/(2**((dist(i,j)/mdist)*10)); #prob for no edge between them
        r = random.uniform(0,1);
        if r <= p:
            s.add((i,j))
            deg[i] += 1
            deg[j] += 1
m = len(s)
# determine colonies
ll = []
for i in range(n):
    if(deg[i] > 0):
        ll.append(i)
cols = random.randint(2, min(len(ll),colLimit));
l = random.sample(range(0,n),cols)
for i in range(len(l)):
    nodes[ll[l[i]]][1] = 1
    nodes[ll[l[i]]][2] = i+1

# output graph
print(n, m)
for edge in s:
    print(edge[0]+1, edge[1]+1, dist(edge[0], edge[1]))
for node in nodes:
    print(node[0], node[1], node[2], node[3], node[4])
