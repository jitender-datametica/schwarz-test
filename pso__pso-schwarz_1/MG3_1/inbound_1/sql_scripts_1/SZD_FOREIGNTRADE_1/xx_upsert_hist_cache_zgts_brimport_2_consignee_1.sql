INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  consignee_id,
  consignee_name,    
  party_key_type_cd, 
  country_location_key_type_cd,
  country_location_id,
  dwh_src_file_name, 
  consignee_additional_name,
  dwh_src_1_tmsp,  
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename
)  select distinct
  nullif(UPPER(TRIM(EG.ENTITAETSNR)),'NULL') as consignee_id,
  COALESCE (nullif(TRIM(EG.ENTITAETSNR),'NULL'), 'Unknown')  as consignee_name,
  'CONSIGNEE' as party_key_type_cd, 
  'COUNTRY_1' as country_location_key_type_cd,
  COALESCE(MAX(nullif(UPPER(TRIM(L.USTIDLANDCODE)),'NULL')),'-1') as country_location_id, 
  MAX(g.dwh_src_file_name), 
  MAX(nullif(TRIM(A.KURZNAME),'NULL')) as consignee_additional_name,  
  MAX(g.dwh_src_1_tmsp) as dwh_src_1_tmsp,  
  CURRENT_TIMESTAMP as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  MAX(g.dwh_src_file_name) as filename
   from  ETL.T_cache_SGGP_1 G
  JOIN ETL.T_cache_SGADR_1 A
    ON G.ADRID = A.ADRID 
  JOIN ETL.T_cache_SSLAND_1 L
    ON A.LANDID = L.LANDID
  JOIN ETL.T_cache_SVENTITAET_1 EG
    ON G.GPID = EG.ENTITAETSID
  where NULLIF(consignee_id,'NULL') is not null
  group by 1,2,3,4,9,10,11,12;




INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  consignee_id,
  consignee_name,    
  party_key_type_cd, 
  country_location_key_type_cd,
  country_location_id,
  dwh_src_file_name, 
  consignee_additional_name,
  dwh_src_1_tmsp,  
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename
)
 select ct1.* from (
 select distinct ct.*
 from (  
  select 
   nullif(UPPER(TRIM(PARNO_CONS_NAME1)),'NULL') as consignee_id,
   COALESCE (nullif(UPPER(PARNO_CONS_NAME1),'NULL'), 'Unknown') as consignee_name,    
  'CONSIGNEE' as party_key_type_cd, 
  'COUNTRY_1' as country_location_key_type_cd,
  'GB' as country_location_id,
  MAX(dwh_src_file_name) dwh_src_file_name , 
  NULL as consignee_additional_name,  
  dwh_src_1_tmsp as dwh_src_1_tmsp,  
  coalesce(etd,etats) as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  MAX(dwh_src_file_name) as filename
  from etl.t_cache_zgts_brimport_1 
  where NULLIF(consignee_id,'NULL') is not null  
  GROUP BY 1,2,3,4,5,7,8,9,10,11,12
   ) ct
   LEFT JOIN meta.t_location_key_1 l
   ON l.LOCATION_KEY_TYPE_CD  =ct.country_location_key_type_cd
   AND l.LOCATION_NAT_KEY_NR = ct.country_location_id 
   left join core_rel.t_consignee_1 c
   on l.LOCATION_SID= c.COUNTRY_LOCATION_SID   
   left join meta.t_party_key_1 pk
   on pk.PARTY_KEY_TYPE_CD  =ct.party_key_type_cd
   and ct.consignee_id=pk.PARTY_NAT_KEY_NR
   left join core_rel.t_consignee_1 c1
   on pk.party_sid= c1.party_sid
   where c.COUNTRY_LOCATION_SID is null or c1.party_sid is null) ct1
   left join etl.t_tf_cache_zgts_brimport_2_consignee_int tf
  on ct1.consignee_id=tf.consignee_id
  where tf.consignee_id is null;
