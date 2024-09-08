#!/bin/bash

export HIP_VISIBLE_DEVICES=2

model_name="iTransformer"
csv_folder="/public/home/achwdu6prw/pre_commodities/"
log_file="/public/home/achwdu6prw/all_logs_${model_name}.txt"

for csv_file in "$csv_folder"/*.csv
do
    filename=$(basename "$csv_file")
    num_features=$(awk -F',' 'NR==1 {print NF-2}' "$csv_file")
    echo "Processing $filename with $num_features features." >> "$log_file"

    python -u run.py \
        --task_name long_term_forecast \
        --is_training 1 \
        --root_path $csv_folder \
        --data_path $csv_file \
        --model_id usa_iTransformer \
        --model $model_name \
        --data MYC \
        --features MS \
        --target ret \
        --freq b \
        --seq_len 15 \
        --label_len 1 \
        --pred_len 1 \
        --enc_in $num_features \
        --dec_in $num_features \
        --c_out 1 \
        --e_layers 4 \
        --d_layers 1 \
        --factor 3 \
        --des 'Exp' \
        --d_model 512 \
        --d_ff 512 \
        --batch_size 16 \
        --learning_rate 0.001 \
        --itr 1

    echo "Finished processing $filename" >> "$log_file"
    echo "----------------------------------------" >> "$log_file"
done

echo "All tasks completed. Logs stored in $log_file"
