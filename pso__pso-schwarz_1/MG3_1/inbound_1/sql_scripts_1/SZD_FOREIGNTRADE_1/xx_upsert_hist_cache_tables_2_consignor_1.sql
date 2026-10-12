INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(

  consignor_name,
  party_id,
  party_key_type_cd, 
  dwh_src_file_name, 
  consignor_stream_cd,
  importer_party_id,
  importer_party_key_type_cd,
  dwh_src_1_tmsp,  
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename
)
    
select src.* from(
  select 
  UPPER(TRIM(consignor_name)) as consignor_name,
  UPPER(TRIM(consignor_name)) as party_id,
  'CONSIGNOR' party_key_type_cd, 
  dwh_src_file_name, 
  'EXTERNAL' consignor_stream_cd,
  '-1' importer_party_id,
  'IMPORTER' importer_party_key_type_cd,
  dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
  from etl.t_cache_ceva_1
  where consignor_name !='NULL'
UNION 
select 
  UPPER(TRIM(consignor_name)) as consignor_name,
  UPPER(TRIM(consignor_name)) as party_id,
  'CONSIGNOR' party_key_type_cd, 
  dwh_src_file_name, 
  'EXTERNAL' consignor_stream_cd,
  '-1' importer_party_id,
  'IMPORTER' importer_party_key_type_cd,
  dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
  from etl.T_CACHE_MAERSK_LGB_1 
  where consignor_name !='NULL'
  UNION 
  select 
  UPPER(TRIM(consignor_name)) as consignor_name,
  UPPER(TRIM(consignor_name)) as party_id,
  'CONSIGNOR' party_key_type_cd, 
  dwh_src_file_name, 
  'EXTERNAL' consignor_stream_cd,
  '-1' importer_party_id,
  'IMPORTER' importer_party_key_type_cd,
  dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
  from etl.T_CACHE_MAERSK_LUKT_1
  where consignor_name !='NULL'
 UNION 
  select 
  UPPER(TRIM(consignor)) as consignor_name,
  UPPER(TRIM(consignor)) as party_id,
  'CONSIGNOR' party_key_type_cd, 
  dwh_src_file_name, 
  'EXTERNAL' consignor_stream_cd,
  '-1' importer_party_id,
  'IMPORTER' importer_party_key_type_cd,
  dwh_src_1_tmsp,  
  dwh_src_1_tmsp as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
  from etl.T_CACHE_CDS_ITEM_1 
  where consignor !='NULL'
) SRC
LEFT JOIN META.T_PARTY_KEY_1 P
ON SRC.party_id = P.PARTY_NAT_KEY_NR
LEFT JOIN CORE_REL.T_CONSIGNOR_1 C
ON P.PARTY_SID = C.PARTY_SID
WHERE C.PARTY_SID IS NULL
   QUALIFY ROW_NUMBER() OVER(PARTITION BY SRC.party_id, SRC.dwh_mapping_tmsp ORDER BY SRC.DWH_SRC_FILE_NAME) = 1;
