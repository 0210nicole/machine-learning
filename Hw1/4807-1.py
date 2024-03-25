import matplotlib.pyplot as plt

# 初始資料點和重心
x = [2, 3, 3, 3, 4, 4, 6, 6, 6, 7, 7, 7, 7, 8, 8]
y = [5, 2, 3, 4, 3, 4, 3, 4, 6, 2, 5, 6, 7, 6, 7]
kx = [2, 4, 6, 8]
ky = [2, 6, 5, 8]

# 定義距離函數
def dis(x1, y1, x2, y2):
    return ((x2 - x1) ** 2 + (y2 - y1) ** 2) ** 0.5

# 將點分配到最近的重心
def cluster(x, y, kx, ky):
    team = [[] for _ in range(4)]  # 初始化 4 個組
    mindis = []  # 初始化最小距離列表
    for i in range(len(x)):
        distances = [dis(x[i], y[i], kx[j], ky[j]) for j in range(len(kx))]
        min_distance = min(distances)
        mindis.append(min_distance)
        min_distance_index = distances.index(min_distance)
        team[min_distance_index].append((x[i], y[i]))
    return team, mindis

# 重新計算重心
def re_seed(team):
    new_seeds = [(sum(node[0] for node in nodes) / len(nodes), sum(node[1] for node in nodes) / len(nodes)) if nodes else (0, 0) for nodes in team]
    return [seed[0] for seed in new_seeds], [seed[1] for seed in new_seeds]

# 繪製群集和重心
def plot_clusters(team, kx, ky, iteration):
    plt.figure(figsize=(5, 5))
    colors = ['red', 'green', 'blue', 'yellow']
    for index, nodes in enumerate(team):
        px, py = zip(*nodes) if nodes else ([], [])
        plt.scatter(px, py, color=colors[index], label=f'Cluster {index+1}')
    plt.scatter(kx, ky, color='magenta', marker='x', s=100, label='Centroids')
    plt.title(f'Iteration {iteration}')
    plt.legend()
    plt.grid(True)
    plt.show()

# 執行 k-means 算法
def kmeans(x, y, kx, ky):
    iteration = 1
    mean = []  # 初始化存儲每次迭代的平均最小距離的列表
    while True:
        team, mindis = cluster(x, y, kx, ky)
        mean.append(sum(mindis) / len(mindis))  # 計算並存儲當前迭代的平均最小距離
        nkx, nky = re_seed(team)
        plot_clusters(team, kx, ky, iteration)
        if (nkx, nky) == (kx, ky):
            print(f'\n\n分群完成，共執行了 {iteration} 次迭代。')
            break
        kx, ky = nkx, nky
        iteration += 1
    return mean

# 繪製平均最小距離的折線圖
def plot_mean_distance(mean):
    plt.figure(figsize=(8, 4))
    plt.plot(range(1, len(mean)+1), mean, marker='o', linestyle='-', color='blue')
    plt.title('Average Minimum Distance by Iteration')
    plt.xlabel('Iteration')
    plt.ylabel('Average Minimum Distance')
    plt.grid(True)
    plt.show()

# 執行 k-means 算法並繪製結果
mean = kmeans(x, y, kx, ky)
plot_mean_distance(mean)
print(mean)