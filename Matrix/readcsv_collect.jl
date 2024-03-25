using CSV
using DataFrames
using PrettyTables

# Load your data
df = CSV.read("D:\\資料\\元智\\研究所\\1122\\機器學習\\Matrix\\data_with_classes.csv",DataFrame)
# Initialize matrices to hold data for each class
# Start with empty arrays
global matclass1 = []
global matclass2 = []
global matclass3 = []

# Iterate through each row of the DataFrame
for row in eachrow(df)
    class_value = row.Class
    if class_value == 1
        push!(matclass1, row)
    elseif class_value == 2
        push!(matclass2, row)
    elseif class_value == 3
        push!(matclass3, row)
    end
end

# 印出各個 Class 的資料
println("Class 1:")
println(matclass1)
println()
println("Class 2:")
println(matclass2)
println()
println("Class 3:")
println(matclass3)