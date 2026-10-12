INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
product_sid,  
dwh_valid_fg, 
ian_nr, 
product_name, 
product_name_txt,
product_division_type_cd, 
incoterm_name, 
--hs_list_txt, 
product_status_cd,
dwh_src_file_name,
dwh_mapping_tmsp,
dwh_src_1_tmsp,
tf_error_fg,
record_id,
filename,
deleted_fg
)
select p.product_sid,
       p.dwh_valid_fg,
       p.ian_nr,
       p.product_name,
       p.product_name as product_name_txt,
       p.product_division_type_cd,
       p.incoterm_name,
      -- p.hs_list_txt,
       p.product_status_cd,
p.dwh_src_file_name,
p.dwh_valid_from_tmsp dwh_mapping_tmsp,
p.dwh_src_1_tmsp,
0 tf_error_fg,
0 record_id,
p.dwh_src_file_name filename,
0 deleted_fg
 from core_rel.t_product p
  left
  join core.t_dim_product dp
    on p.product_sid = dp.product_sid
 where dp.product_sid is null and p.dwh_valid_fg; 
