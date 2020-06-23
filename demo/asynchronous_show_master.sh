#/bin/bash
cd ../output
out_ds=`(ls)`
for out_d in ${out_ds}
do
    cd ${out_d}
    echo "input_set: ${out_d}"
    echo
    echo "master: fcntl, slave: fcntl"
    echo "master transmission time, file size:"
    cat async_ff_master_time_size
    sleep 1s
    echo
    echo "master: mmap, slave: mmap"
    echo "master transmission time, file size:"
    cat async_mm_master_time_size
    sleep 0.5s
    echo "master dmesg:"
    cat async_mm_master_dmesg
    sleep 1s
    echo
    echo "master: mmap, slave: fcntl"
    echo "master transmission time, file size:"
    cat async_ff_master_time_size
    sleep 0.5s
    echo "master dmesg:"
    cat async_mf_master_dmesg
    sleep 1s
    echo
    echo "master: fcntl, slave: mmap"
    echo "master transmission time, file size:"
    cat async_fm_master_time_size
    sleep 1s
    echo
    echo
    cd ..
done
