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
 SELECT 
  TRIM(UPPER(parno_consignor_name1)) as consignor_name,
  TRIM(UPPER(parno_consignor_name1)) as party_id,
  'CONSIGNOR' party_key_type_cd, 
  dwh_src_file_name, 
  'EXTERNAL' consignor_stream_cd,
  '-1' importer_party_id,
  'IMPORTER' importer_party_key_type_cd,
  dwh_src_1_tmsp,  
  coalesce(etats, etd) as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename
 FROM etl.T_CACHE_ZGTS_BRIMPORT_1 
 where parno_consignor_name1 !='NULL'

) SRC
LEFT JOIN META.T_PARTY_KEY_1 P
ON SRC.party_id = P.PARTY_NAT_KEY_NR
LEFT JOIN CORE_REL.T_CONSIGNOR_1 C
ON P.PARTY_SID = C.PARTY_SID
WHERE C.PARTY_SID IS NULL
   QUALIFY ROW_NUMBER() OVER(PARTITION BY SRC.party_id, SRC.dwh_mapping_tmsp ORDER BY SRC.DWH_SRC_FILE_NAME) = 1;
