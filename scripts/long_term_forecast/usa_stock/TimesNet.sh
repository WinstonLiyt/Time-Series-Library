export CUDA_VISIBLE_DEVICES=2

model_name=TimesNet

python -u run.py \
  --task_name long_term_forecast \
  --is_training 1 \
  --root_path test_file/ \
  --data_path AAPL.csv \
  --model_id usa_timesnet_appl \
  --model $model_name \
  --data MY \
  --features MS \
  --target RETX \
  --seq_len 60 \
  --label_len 20 \
  --pred_len 20 \
  --e_layers 2 \
  --d_layers 1 \
  --factor 3 \
  --enc_in 5 \
  --dec_in 5 \
  --c_out 1 \
  --d_model 512 \
  --d_ff 512 \
  --top_k 5 \
  --des 'Exp' \
  --itr 1