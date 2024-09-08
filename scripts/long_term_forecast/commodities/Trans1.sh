export HIP_VISIBLE_DEVICES=0,1,2,3

model_name="Transformer"

root_folder="/public/home/achwdu6prw/pre_commodities/"
# csv_folder="/public/home/achwdu6prw/pre_commodities"
log_file="/public/home/achwdu6prw/all_logs_${model_name}.txt"
csv_file="/public/home/achwdu6prw/pre_commodities/57.csv"

# 使用awk读取特征列数量（假设第三列之后都是特征列，ComCode、Date_、ret不算）
num_features=$(awk -F',' 'NR==1 {print NF-2}' "$csv_file")
echo "Number of features: $num_features"

# 构建命令并执行
python -u run.py \
    --task_name long_term_forecast \
    --is_training 1 \
    --root_path $root_folder \
    --data_path "57.csv" \
    --seasonal_patterns 'Monthly' \
    --inverse \
    --model_id usa_1 \
    --model $model_name \
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
    --use_gpu True \
    --train_epochs 20 \
    --batch_size 16 \
    --des 'Exp' \
    --itr 1 \
    --learning_rate 0.0001 \
    --patience 5 \
    --loss 'SMAPE'
