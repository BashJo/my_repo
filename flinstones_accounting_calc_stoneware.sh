#!/usr/bin/env bash
# File: flinstones_accounting_calc_stoneware.sh

function products_list {
	declare -A pro_pri
	if [[ products_list.csv != $(ls ./) ]]
	then
		touch products_list.txt
	fi
	while true
	do
		echo "Enter product name (or exit to close): "
		read product_name
		if [[ $product_name =~ 'exit' ]]
		then
			break
		fi
		echo "Enter price per piece/Kg: "
		read price
		echo $pro_pri[$product_name]=$price >> products_list.txt
	done
	
}

function stone_calc () {
	client_no=0
	sum=0
#	daily_sum=0
	while true
	do
		echo "Enter product name (or enter 'sum' to calculate the sum): "
		read product
		if [[ $product =~ 'sum' ]]
		then
			echo "amount to pay is $sum Stones"
			echo "Paied="
			read payment
			echo "Change="
			echo "$(echo $payment-$sum | bc -l) Stones"
			break
		else
#		price=$(egrep $product products_list.txt | sed -n "s/^.*=\([[:digit:]]\+\).*$/\1/p")
#if [[ $product =~ $(cat products_list.txt) ]]
		echo "Enter amount:"
		read amount
		price=$(egrep $product products_list.txt | sed -n "s/^.*=\([[:digit:]]\+\).*$/\1/p")
		let sum=$sum+$(echo $price*$amount | bc -l)
 		fi
	done
}

function annual_rec {

	if [[ annual_rec.txt != $(ls ./) ]]
	then
		touch annual_rec.txt
	fi
	echo "$(date -I)  income= $daily_sum Stones  Clients= $visitors" >> annual_rec.txt
}


daily_sum=0
visitors=0
echo 'Welcome!'
echo 'Choose please (1 or 2):'
echo '1- log in'
echo '2- update products table'
read comnd 
if [[ $comnd =~ '1' ]]
then
	while true
	do
		echo "press any key for a new client or 'finish' to end the shift"
		read newcl
		if [[ $newcl != 'finish' ]]
		then
			stone_calc
			let daily_sum=$daily_sum+$sum
			let visitors=$visitors+1
		else
			annual_rec
			break
		fi
	done
else
	products_list
fi
