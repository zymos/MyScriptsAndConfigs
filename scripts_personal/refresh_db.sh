#!/bin/bash


rm -rf /tmp/cpu-db.tar.gz /tmp/zymos-cpu-db-*

wget https://github.com/zymos/cpu-db/tarball/master -O /tmp/cpu-db.tar.gz

tar -zxf /tmp/cpu-db.tar.gz -C /tmp/

cd /tmp/zymos-cpu-db-*

./scripts/generate_full_cpu_list.sh

cp cpu-db.csv cpu_db_table.csv



mysqlimport --local --columns=\
manufacturer,\
family,part,alternative_label_1,\
alternative_label_2,alternative_label_3,\
alternative_label_4,alternative_label_5,\
alternative_label_6,\
@x,@x,@x,\
chip_type,sub_family,model_number,\
core,core_designer,microarchitecture,\
threads,cpuid,core_count,\
pipeline,multiprocessing,\
@x,@x,@x,\
architecture,data_bus_ext,\
address_bus,bus_comments,\
frequency_ext,frequency_min,\
frequency_max_typ,actual_bus_frequency,\
effective_bus_frequency,bus_bandwidth,\
clock_multiplier,core_stepping,\
@x,@x,@x,@x,\
l1_data_cache,l1_data_associativity,\
l1_instruction_cache,l1_instruction_associativity,\
l1_unified_cache,l1_unified_associativity,\
l2_cache,l2_associativity,\
l3_cache,l3_associativity,\
boot_rom,rom_internal,rom_type,\
ram_internal,ram_max,ram_type,\
virtual_memory_max,\
@x,@x,@x,@x,\
package,\
package_size,package_weight,socket,\
transistor_count,process_size,\
metal_layers,metal_type,\
process_technology,die_size,\
rohs,\
@x,@x,@x,\
vcc_core_range,vcc_core_typ,\
@x,\
vcc_secondary,vcc_tertiary,\
@x,\
vcc_i_o,i_o_compatibillity,power_min,\
power_typ,power_max,\
power_thermal_design,temperature_range,\
temperature_grade,\
low_power_features,\
@x,@x,@x,@x,@x,\
instruction_set,\
instruction_set_extensions,\
additional_instructions,\
computer_architecture,isa,\
@x,@x,@x,@x,\
fpu,\
on_chip_peripherals,features,\
@x,@x,\
production_type,clone,\
release_date,initial_price,\
applications,military_spec,comments,\
@x,@x,@x,@x,@x,@x,\
reference_1,reference_2,\
reference_3,reference_4,\
reference_5,reference_6,\
reference_7,reference_8,\
@x,@x,@x,@x,@x,\
photo_front_filename_1,photo_front_source_1,photo_front_copyright_1,\
photo_front_comment_1,\
@x,\
photo_back_filename_1,photo_back_source_1,photo_back_copyright_1,\
photo_back_comment_1,\
@x,\
photo_front_filename_2,photo_front_source_2,photo_front_copyright_2,\
photo_front_comment_2,\
@x,\
photo_back_filename_2,photo_back_source_2,photo_back_copyright_2,\
photo_back_comment_2,\
@x,\
photo_front_filename_3,photo_front_source_3,photo_front_copyright_3,\
photo_front_comment_3,\
@x,\
photo_back_filename_3,photo_back_source_3,photo_back_copyright_3,\
photo_back_comment_3,\
@x,\
photo_front_filename_4,photo_front_source_4,photo_front_copyright_4,\
photo_front_comment_4,\
@x,\
photo_back_filename_4,photo_back_source_4,photo_back_copyright_4,\
photo_back_comment_4,\
@x,\
die_photo_filename_1,die_photo_source_1,die_photo_copyright_1,\
die_photo_comment_1 \
--ignore-lines=1 --delete --fields-enclosed-by='"' --fields-terminated-by=',' --lines-terminated-by="\n" --user=root -p cpu_db cpu_db_table.csv

