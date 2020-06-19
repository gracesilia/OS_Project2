cd ./ksocket

if [ ${1:-"NULL"} = "BONUS" ];
	then make CFLAGS=-BONUS
else 
	make 
fi

insmod ksocket.ko

cd ../master_device
make
insmod master_device.ko
cd ../slave_device
make
insmod slave_device.ko
cd ../user_program
make


