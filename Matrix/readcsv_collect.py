import pandas as pd

# 讀取 CSV 檔案
df = pd.read_csv(r"D:\\資料\\元智\\研究所\\1122\\機器學習\\Matrix\\data_with_classes.csv")

# 初始化用來儲存每個類別資料的列表
matclass1 = []
matclass2 = []
matclass3 = []

# 根據 "Class" 欄位將資料分配到對應的列表中
for index, row in df.iterrows():
    class_value = row["Class"]
    if class_value == 1:
        matclass1.append(row)
    elif class_value == 2:
        matclass2.append(row)
    elif class_value == 3:
        matclass3.append(row)

# 印出各個 Class 的資料
print("Class 1:")
print(matclass1)
print()
print("Class 2:")
print(matclass2)
print()
print("Class 3:")
print(matclass3)
