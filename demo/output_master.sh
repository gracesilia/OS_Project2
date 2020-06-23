#/bin/bash
#cd ..
#./comple.sh
#cd user_program
cd ../user_program
in_ds=`(ls ../input)`
for in_d in ${in_ds}
do
    n=`(ls ../input/${in_d} | wc -l)`
    out_d=`(echo ${in_d} | sed "s/input/output/g")`
    in_fs=`(ls ../input/${in_d} | sed "s/target/..\/input\/${in_d}\/target/g")`    

    ./master ${n} ${in_fs} fcntl > ../output/${out_d}/fcntl_fcntl_master_time_size
    
    dmesg --clear
    ./master ${n} ${in_fs} mmap > ../output/${out_d}/mmap_mmap_master_time_size
    dmesg | grep master: > ../output/${out_d}/mmap_mmap_master_dmesg
    
    dmesg --clear
    ./master ${n} ${in_fs} mmap > ../output/${out_d}/mmap_fcntl_master_time_size
    dmesg | grep master: > ../output/${out_d}/mmap_fcntl_master_dmesg
    
    ./master ${n} ${in_fs} fcntl > ../output/${out_d}/fcntl_mmap_master_time_size
done
