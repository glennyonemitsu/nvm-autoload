#! /bin/zsh

TF1=$(tempfile)
TF2=$(tempfile)
TF3=$(tempfile)
TF3Z="$TF3.zwc"

cp --force $HOME/.nvm/nvm.sh $TF1

START=$(expr $(grep -n '^nvm()' $TF1 | cut -f 1 -d ':') + 1)

tail --lines +$START $TF1 > $TF2

END=$(expr $(grep -n '^}' $TF2 | cut -f 1 -d ':') - 1)

echo '[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM' > $TF3
head --lines $END $TF2 >> $TF3

zcompile $TF3

cp --force $TF3Z $HOME/.nvm/nvm.zwc
cp --force $TF3Z $HOME/nvm

rm --force $TF1 $TF2 $TF3 $TF3Z
