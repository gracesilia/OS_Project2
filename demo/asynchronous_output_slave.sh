#!/bin/bash
cd ../user_program
master_ip=$1
in_ds=`(ls ../input)`
for in_d in ${in_ds}
do
    n=`(ls ../input/${in_d} | wc -l)`
    fs=`(ls ../input/${in_d})`
    out_d=`(echo ${in_d} | sed "s/input/output/g")`
    
    out_fs=`(ls ../input/${in_d} | sed "s/target/..\/output\/${out_d}\/async_ff/g")`
    ./slave ${n} ${out_fs} fcntl ${master_ip} > ../output/${out_d}/async_ff_slave_time_size
    
    out_fs=`(ls ../input/${in_d} | sed "s/target/..\/output\/${out_d}\/async_mm/g")`
    dmesg --clear
    ./slave ${n} ${out_fs} mmap ${master_ip} > ../output/${out_d}/async_mm_slave_time_size
    dmesg | grep slave: > ../output/${out_d}/async_mm_slave_dmesg

    out_fs=`(ls ../input/${in_d} | sed "s/target/..\/output\/${out_d}\/async_mf/g")`
    ./slave ${n} ${out_fs} fcntl ${master_ip} > ../output/${out_d}/async_mf_slave_time_size

    out_fs=`(ls ../input/${in_d} | sed "s/target/..\/output\/${out_d}\/async_fm/g")`
    dmesg --clear
    ./slave ${n} ${out_fs} mmap ${master_ip} > ../output/${out_d}/async_fm_slave_time_size
    dmesg | grep slave: > ../output/${out_d}/async_fm_slave_dmesg
done

