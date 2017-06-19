#/bin/bash

cd ~
mkdir simutrans-src
cd simutrans-src
wget -O simutrans-120-2-2.zip https://sourceforge.net/projects/simutrans/files/simutrans/120-2-2/simutrans-src-120-2-2.zip/download
unzip -O simutrans-120-2-2.zip
./configure
make

cp sim simutrans
cd simutrans
wget -O pak128.zip https://sourceforge.net/projects/simutrans/files/pak128/pak128%20for%20ST%20120%20%282.6%2C%20completed%20elevated%20tracks%29/pak128-2.6--ST120.zip/download

unzip pak128.zip -o pak128
