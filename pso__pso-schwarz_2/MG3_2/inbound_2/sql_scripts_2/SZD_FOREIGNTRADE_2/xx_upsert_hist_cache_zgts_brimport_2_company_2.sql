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
  NULL as company_nr,
  TRIM(PARNO_CAR_NAME1) as company_name,
  '-1' as company_id,
  'HAULER' as company_type_cd,
  'HAULER' as party_key_type_cd, 
  dwh_src_file_name, 
  TRIM(PARNO_CAR_NAME1) as source_company_name_address_city_txt,
  'A' as company_status_cd, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
  from etl.t_cache_zgts_brimport_2 
union 
          select distinct
  NULL as company_nr,
  SUBSTR(UPPER(TRIM(ENTITAETSNR)), 1, 100) as company_name,
  '-1' as company_id,
  'HAULER' as company_type_cd,
  'HAULER' as party_key_type_cd, 
  dwh_src_file_name, 
  UPPER(TRIM(ENTITAETSNR)) as source_company_name_address_city_txt,
  'A' as company_status_cd, 
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
   from etl.t_cache_SVENTITAET_2
  where ENTITAETSART = 'SPED' and ENTITAETSNR is not null   
  ) 
   QUALIFY ROW_NUMBER() OVER(PARTITION BY source_company_name_address_city_txt ORDER BY DWH_SRC_FILE_NAME) = 1
   ) ct
   left join meta.t_party_key_2 pk
   on pk.PARTY_KEY_TYPE_CD  =ct.party_key_type_cd
   AND TRIM(ct.source_company_name_address_city_txt)=pk.PARTY_NAT_KEY_NR
   left join core_rel.t_company_2 c
   on pk.party_sid= c.party_sid
   where c.party_sid is null;
