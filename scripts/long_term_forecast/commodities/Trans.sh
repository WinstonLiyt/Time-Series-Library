#!/bin/bash

csv_folder="D:/Study/THURA/pre_commodities"
log_file="D:/Study/THURA/all_logs.txt"

# 遍历文件夹中的所有 CSV 文件
for csv_file in "$csv_folder"/*.csv
do
    # 获取文件名（不带路径）
    filename=$(basename -- "$csv_file")

    # 使用awk读取特征列数量（假设第三列之后都是特征列，ComCode、Date_、ret不算）
    num_features=$(awk -F',' 'NR==1 {print NF-3}' "$csv_file")

    # 打印当前处理的文件和特征数量
    echo "Processing $filename with $num_features features." >> "$log_file"

    # 构建命令并执行
    python -u run.py \
        --task_name long_term_forecast \
        --is_training 1 \
        --root_path test_file/ \
        --data_path "$csv_file" \
        --seasonal_patterns 'Monthly' \
        --inverse \
        --model_id usa_1 \
        --model Transformer \
        --data MYC \
        --features MS \
        --target ret \
        --freq b \
        --mask_rate 0 \
        --enc_in $num_features \
        --dec_in $num_features \
        --c_out 1 \
        --d_model 512 \
        --n_heads 8 \
        --e_layers 2 \
        --d_layers 1 \
        --moving_avg 15 \
        --factor 3 \
        --train_epochs 20 \
        --batch_size 16 \
        --des 'Exp' \
        --itr 1 \
        --learning_rate 0.0001 \
        --patience 5 \
        --loss 'SMAPE' >> "$log_file" 2>&1

    echo "Finished processing $filename" >> "$log_file"
    echo "----------------------------------------" >> "$log_file"
done

echo "All tasks completed. Logs stored in $log_file"
