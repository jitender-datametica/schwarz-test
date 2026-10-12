INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  resource_item_key_type_cd,
  export_warehouse_name, 
  dwh_src_file_name, 
  dwh_src_1_tmsp,  
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename
)
   select distinct ct.*
 from (select * 
 from (  select distinct
  'EXPORT_WAREHOUSE' as  resource_item_key_type_cd,
  UPPER(TRIM(ENTITAETSNR)) as export_warehouse_name, 
  dwh_src_file_name,     
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
   from  ETL.T_cache_SVENTITAET_1    
   where ENTITAETSART = 'PLAG' and ENTITAETSNR is not null
        ) 
   QUALIFY ROW_NUMBER() OVER(PARTITION BY export_warehouse_name ORDER BY DWH_SRC_FILE_NAME) = 1
   ) ct                   
   left join meta.t_resource_item_key_1 rk
   on rk.RESOURCE_ITEM_KEY_TYPE_CD=ct.resource_item_key_type_cd
   and ct.export_warehouse_name=rk.RESOURCE_ITEM_NAT_KEY_NR
   left join core_rel.t_export_warehouse_1 c
   on rk.RESOURCE_ITEM_SID= c.RESOURCE_ITEM_SID
   where c.RESOURCE_ITEM_SID is null;
