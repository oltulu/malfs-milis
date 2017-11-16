#!/bin/sh
cd /usr/share/paxtest
if [ $# = 1 ]
then
	if [ "$1" = "kiddie" ]
	then
		PAXTEST_MODE=0
	elif [ "$1" = "blackhat" ]
	then
		PAXTEST_MODE=1
	else
		echo "usage: paxtest [kiddie|blackhat]"
		exit 1
	fi
else
	echo "usage: paxtest [kiddie|blackhat]"
	exit 1
fi

export PAXTEST_MODE

if [ "${LD_LIBRARY_PATH}" = "" ]
then
	LD_LIBRARY_PATH=.
else
	LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:.
fi
export LD_LIBRARY_PATH

cat <<__end__ | tee paxtest.log
PaXtest - Copyright(c) 2003,2004 by Peter Busser <peter@adamantix.org>
Released under the GNU Public Licence version 2 or later

__end__

echo "Mode: $1" >>paxtest.log
uname -a >>paxtest.log
echo >>paxtest.log

echo 'Writing output to paxtest.log'
echo 'It may take a while for the tests to complete'

for i in anonmap execbss execdata execheap execstack shlibbss shlibdata mprotanon mprotbss mprotdata mprotheap mprotstack mprotshbss mprotshdata writetext randamap randheap1 randheap2 randmain1 randmain2 randshlib randstack1 randstack2 randarg1 randarg2 randexhaust1 randexhaust2 rettofunc1 rettofunc2 rettofunc1x rettofunc2x
do
	./$i
done >>paxtest.log 2>&1

echo "Test results:"
cat paxtest.log

echo

cd -
