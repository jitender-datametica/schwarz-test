INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  company_nr,
  company_name,
  company_id,
  company_type_cd,
  party_key_type_cd, 
  dwh_src_file_name, 
  source_company_name_address_city_txt,
  company_status_cd, 
  dwh_src_1_tmsp,  
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename
)
   select ct.*
 from (select * 
 from (     
  select distinct
  declarant_eori as company_nr,
  declarant_name as company_name,
  '-1' as company_id,
  'BROKER' as company_type_cd,
  'BROKER' as party_key_type_cd, 
  dwh_src_file_name, 
  declarant_name as source_company_name_address_city_txt,
  'A' as company_status_cd, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
  from etl.t_cache_ceva_2
  where company_nr !='NULL'
  union
    select distinct
  declarant_eori as company_nr,
  declarant_name as company_name,
  '-1' as company_id,
  'BROKER' as company_type_cd,
  'BROKER' as party_key_type_cd, 
  dwh_src_file_name, 
  declarant_name as source_company_name_address_city_txt,
  'A' as company_status_cd, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
  from etl.t_cache_maersk_lgb_2
  where company_nr !='NULL'
  union
    select distinct
  declarant_eori as company_nr,
  declarant_name as company_name,
  '-1' as company_id,
  'BROKER' as company_type_cd,
  'BROKER' as party_key_type_cd, 
  dwh_src_file_name, 
  declarant_name as source_company_name_address_city_txt,
  'A' as company_status_cd, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
  from etl.t_cache_maersk_lukt_2
  where company_nr !='NULL'
     union
    select distinct
  declarant_eori as company_nr,
  declarant_name as company_name,
  '-1' as company_id,
  'BROKER' as company_type_cd,
  'BROKER' as party_key_type_cd, 
  dwh_src_file_name, 
  declarant_name as source_company_name_address_city_txt,
  'A' as company_status_cd, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
  from etl.t_cache_cds_header_2
  where company_nr !='NULL'   
  ) 
   QUALIFY ROW_NUMBER() OVER(PARTITION BY company_nr ORDER BY DWH_SRC_FILE_NAME) = 1
   ) ct
   left join meta.t_party_key_2 pk
   on ct.company_nr=pk.PARTY_NAT_KEY_NR
   and pk.party_key_type_cd = 'BROKER'
   left join core_rel.t_company_2 c
   on pk.party_sid= c.party_sid
   and c.dwh_valid_fg
   where c.party_sid is null;
