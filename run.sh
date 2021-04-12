#! /bin/sh

today=$(date +%Y%m%d)

running=$(docker ps | grep FightBaseball)

#if [ -n "$running" ]; then
docker run -v $(pwd)/cv:/home/char-rnn/cv -v $(pwd)/data/BaseballNames.txt:/home/char-rnn/data/fightbaseball/input.txt --name FightBaseball mbartoli/char-rnn &
#fi

docker exec FightBaseball /bin/bash -c "th train.lua -data_dir data/fightbaseball/ -rnn_size 256 -num_layers 2 -dropout 0.5 -model rnn -batch_size 26 -seq_length 26 -savefile $today.t7"

docker exec FightBaseball /bin/bash -c "th sample.lua ~/cv/$today.t7 > ~/data/$today.txt"
