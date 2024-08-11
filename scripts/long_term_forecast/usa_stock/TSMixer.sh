
model_name=TSMixer
learning_rate=0.001

python -u run.py \
  --task_name long_term_forecast \
  --is_training 1 \
  --root_path test_file/ \
  --data_path AAPL.csv \
  --model_id usa_tsmixer_appl \
  --model $model_name \
  --data MY \
  --features MS \
  --target RETX \
  --seq_len 20 \
  --label_len 1 \
  --pred_len 1 \
  --e_layers 2 \
  --d_layers 1 \
  --factor 3 \
  --enc_in 5 \
  --dec_in 5 \
  --c_out 1 \
  --d_model 512 \
  --d_ff 32 \
  --des 'Exp' \
  --itr 1 \
  --learning_rate $learning_rate \
