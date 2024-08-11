export CUDA_VISIBLE_DEVICES=1

model_name=Transformer

python -u run.py \
  --task_name long_term_forecast \
  --is_training 1 \
  --root_path test_file/ \
  --data_path AAPL.csv \
  --model_id usa_1 \
  --model $model_name \
  --data MY \
  --features MS \
  --target RETX \
  --freq b \
  --seq_len 20 \
  --label_len 1 \
  --pred_len 1 \
  --mask_rate 0 \
  --enc_in 5 \
  --dec_in 5 \
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
  --loss 'SMAPE'