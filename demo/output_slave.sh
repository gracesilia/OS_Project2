#!/bin/bash
cd ../user_program
master_ip=$1
in_ds=`(ls ../input)`
for in_d in ${in_ds}
do
    n=`(ls ../input/${in_d} | wc -l)`
    fs=`(ls ../input/${in_d})`
    out_d=`(echo ${in_d} | sed "s/input/output/g")`
    
    out_fs=`(ls ../input/${in_d} | sed "s/target/..\/output\/${out_d}\/fcntl_fcntl/g")`
    ./slave ${n} ${out_fs} fcntl ${master_ip} > ../output/${out_d}/fcntl_fcntl_slave_time_size
    
    out_fs=`(ls ../input/${in_d} | sed "s/target/..\/output\/${out_d}\/mmap_mmap/g")`
    dmesg --clear
    ./slave ${n} ${out_fs} mmap ${master_ip} > ../output/${out_d}/mmap_mmap_slave_time_size
    dmesg | grep slave: > ../output/${out_d}/mmap_mmap_slave_dmesg

    out_fs=`(ls ../input/${in_d} | sed "s/target/..\/output\/${out_d}\/mmap_fcntl/g")`
    ./slave ${n} ${out_fs} fcntl ${master_ip} > ../output/${out_d}/mmap_fcntl_slave_time_size

    out_fs=`(ls ../input/${in_d} | sed "s/target/..\/output\/${out_d}\/fcntl_mmap/g")`
    dmesg --clear
    ./slave ${n} ${out_fs} mmap ${master_ip} > ../output/${out_d}/fcntl_mmap_slave_time_size
    dmesg | grep slave: > ../output/${out_d}/fcntl_mmap_slave_dmesg
done

