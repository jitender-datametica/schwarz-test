INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  product_variant_id,
  product_variant_key_type_cd,    
  product_sid, 
  sales_variant_number,
  sales_variant_name,
  dwh_src_file_name, 
  dwh_src_1_tmsp,  
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename
)
 select distinct ct.* 
 from (select prvsy as product_variant_id,
         'SALES_VARIANT' as product_variant_key_type_cd,
         -1 as product_sid,
         try_to_number(prvsy) as sales_variant_number,
         SUBSTR(PRTXT, 1, 100) as sales_variant_name,
         dwh_src_file_name, 
         dwh_src_1_tmsp as dwh_src_1_tmsp,  
         dwh_src_1_tmsp as dwh_mapping_tmsp,
         0 as tf_error_fg,
         0 as deleted_fg,
         0 as record_id,
         dwh_src_file_name as filename
 from etl.t_cache_ZGTS_BRIMPORT_2 
  QUALIFY ROW_NUMBER() OVER(PARTITION BY try_to_number(prvsy) ORDER BY DWH_SRC_FILE_NAME) = 1) ct 
 left join META.T_PRODUCT_KEY_2 pk
 on pk.PRODUCT_KEY_TYPE_CD=ct.product_variant_key_type_cd
 and ct.product_variant_id=pk.PRODUCT_NAT_KEY_NR
 left join core_rel.T_SALES_VARIANT_2 sv 
 on pk.PRODUCT_SID= sv.PRODUCT_variant_SID;
