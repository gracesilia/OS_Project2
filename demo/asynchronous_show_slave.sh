#!/bin/bash
cd ../
out_ds=`(ls output)`
for out_d in ${out_ds}
do
    in_d=`(echo ${out_d} | sed "s/output/input/g")`
    fs=`(ls input/${in_d})`
    echo "input_set: ${out_d}"
    echo    
    echo "master: fcntl, slave: fcntl"
    echo "slave transmission time, file size:"
    cat output/${out_d}/async_ff_slave_time_size
    sleep 0.5s
    echo "diff:"
    for f in ${fs}
    do
        in_f="input/${in_d}/${f}"
        out_f=`(echo ${f} | sed "s/target/output\/${out_d}\/async_ff/g")`
        echo "diff ${in_f} ${out_f}"
        diff ${in_f} ${out_f}
        sleep 0.2s
    done
    sleep 1s
    echo
    echo "master: mmap, slave: mmap"
    echo "slave transmission time, file size:"
    cat output/${out_d}/async_mm_slave_time_size
    sleep 0.5s
    echo "slave dmesg:"
    cat output/${out_d}/async_mm_slave_dmesg
    sleep 0.5s
    echo "diff:"
    for f in ${fs}
    do
        in_f="input/${in_d}/${f}"
        out_f=`(echo ${f} | sed "s/target/output\/${out_d}\/async_mm/g")`
        echo "diff ${in_f} ${out_f}"
        diff ${in_f} ${out_f}
        sleep 0.2s
    done
    sleep 1s
    echo
    echo "master: mmap, slave: fcntl"
    echo "slave transmission time, file size:"
    cat output/${out_d}/async_mf_slave_time_size
    sleep 0.5s
    echo "diff:"
    for f in ${fs}
    do
        in_f="input/${in_d}/${f}"
        out_f=`(echo ${f} | sed "s/target/output\/${out_d}\/async_mf/g")`
        echo "diff ${in_f} ${out_f}"
        diff ${in_f} ${out_f}
        sleep 0.2s
    done
    sleep 1s
    echo
    echo "master: fcntl, slave: mmap"
    echo "slave transmission time, file size:"
    cat output/${out_d}/async_fm_slave_time_size
    sleep 0.5s
    echo "slave dmesg:"
    cat output/${out_d}/async_fm_slave_dmesg
    sleep 0.5s
    echo "diff:"
    for f in ${fs}
    do
        in_f="input/${in_d}/${f}"
        out_f=`(echo ${f} | sed "s/target/output\/${out_d}\/async_fm/g")`
        echo "diff ${in_f} ${out_f}"
        diff ${in_f} ${out_f}
        sleep 0.2s
    done
    sleep 1s
    echo
    echo
done

