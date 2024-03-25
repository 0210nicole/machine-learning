using DataFrames
using Random

# 讀取資料
using CSV
original_data = CSV.File("D:/資料/元智/研究所/1122/機器學習/Julia Split/mtcars.csv") |> DataFrame

# 資料分割函數
function data_split(dat, trf, vlf, tsf)
    nrows = size(dat, 1)
    trnr = Int(trf * nrows)
    vlnr = Int(vlf * nrows)

    shuffled_data = shuffle(dat)
    tr_data = shuffled_data[1:trnr, :]
    vl_data = shuffled_data[trnr+1:trnr+vlnr, :]
    ts_data = shuffled_data[trnr+vlnr+1:end, :]

    return tr_data, vl_data, ts_data
end

# 使用資料分割函數
train_data, validation_data, test_data = data_split(original_data, 0.5, 0.25, 0.25)
