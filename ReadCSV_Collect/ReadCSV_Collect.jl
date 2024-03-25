using CSV
using DataFrames
DF = CSV.read("D:\\Julia Program\\data_with_classes.csv",DataFrame)
global M1 = []
global M2 = []
global M3 = []
# print(DF.Class)
for row in eachrow(DF)
    global M1 , M2 , M3
    # row.Class  班級
    class = row.Class
    if class == 1
        push!(M1, row[1:5])
    elseif class == 2
        push!(M2, row[1:5])
    elseif class == 3
        push!(M3, row[1:5])
    end
end

println("M1大小:",size(M1))
println("M1 : ",M1)
println("M2大小:",size(M2))
println("M2 : ",M2)
println("M3大小:",size(M3))
println("M3 : ",M3)