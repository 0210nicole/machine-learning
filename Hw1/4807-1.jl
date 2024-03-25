# 初始資料點和重心
x = [2, 3, 3, 3, 4, 4, 6, 6, 6, 7, 7, 7, 7, 8, 8]
y = [5, 2, 3, 4, 3, 4, 3, 4, 6, 2, 5, 6, 7, 6, 7]
kx = [2, 4, 6, 8]
ky = [2, 6, 5, 8]

# 定義距離函數
function dis(x1, y1, x2, y2)
    return sqrt((x2 - x1)^2 + (y2 - y1)^2)
end

# 將點分配到最近的重心
function cluster(x, y, kx, ky)
    team = [[] for _ in 1:4]  # 初始化 4 個組
    mindis = []  # 初始化最小距離列表
    for i in 1:length(x)
        distances = [dis(x[i], y[i], kx[j], ky[j]) for j in 1:length(kx)]
        min_distance = minimum(distances)
        push!(mindis, min_distance)
        min_distance_index = argmin(distances)
        push!(team[min_distance_index], (x[i], y[i]))
    end
    return team, mindis
end

# 重新計算重心
function re_seed(team)
    new_seeds = [(length(nodes) > 0 ? (sum(node[1] for node in nodes) / length(nodes), sum(node[2] for node in nodes) / length(nodes)) : (0, 0)) for nodes in team]
    return [seed[1] for seed in new_seeds], [seed[2] for seed in new_seeds]
end

# 執行 k-means 算法
function kmeans(x, y, kx, ky)
    iteration = 1
    mean = []  # 初始化存儲每次迭代的平均最小距離的列表
    while true
        team, mindis = cluster(x, y, kx, ky)
        push!(mean, sum(mindis) / length(mindis))  # 計算並存儲當前迭代的平均最小距離
        nkx, nky = re_seed(team)

        if (nkx, nky) == (kx, ky)
            println("分群完成，共執行了 $iteration 次迭代。")
            break
        end
        kx, ky = nkx, nky
        iteration += 1
    end
    return mean
end

# 執行 k-means 算法並顯示結果
mean = kmeans(x, y, kx, ky)
println(mean)