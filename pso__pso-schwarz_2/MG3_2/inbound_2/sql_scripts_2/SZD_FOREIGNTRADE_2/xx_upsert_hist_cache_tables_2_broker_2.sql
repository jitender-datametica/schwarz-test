INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
  party_key_type_cd,
  broker_party_id,
  broker_number,
  broker_name,
  broker_postcode,
  broker_authorized_fg, 
  dwh_src_file_name,
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
  'BROKER' as party_key_type_cd,
  declarant_eori as broker_party_id,
  declarant_eori as broker_number,
  COALESCE(nullif(declarant_name,'NULL'),'Unknown') as broker_name,
  NULL as broker_postcode,
  0 as broker_authorized_fg, 
  dwh_src_file_name,
  dwh_src_1_tmsp,
  DWH_SRC_1_TMSP as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename  
from etl.t_cache_ceva_2
 where Broker_Party_Id !='NULL'
UNION
  select distinct
  'BROKER' as party_key_type_cd,
  declarant_eori as broker_party_id,
  declarant_eori as broker_number,
  COALESCE(nullif(declarant_name,'NULL'),'Unknown') as broker_name,
  NULL as broker_postcode,
  0 as broker_authorized_fg, 
  dwh_src_file_name,
  dwh_src_1_tmsp,
  DWH_SRC_1_TMSP as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename  
from etl.t_cache_maersk_lgb_2
 where Broker_Party_Id !='NULL'
UNION  
select distinct
  'BROKER' as party_key_type_cd,
  declarant_eori as broker_party_id,
  declarant_eori as broker_number,
  COALESCE(nullif(declarant_name,'NULL'),'Unknown') as broker_name,
  NULL as broker_postcode,
  0 as broker_authorized_fg, 
  dwh_src_file_name,
  dwh_src_1_tmsp,
  DWH_SRC_1_TMSP as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename 
  from etl.t_cache_maersk_lukt_2
  where Broker_Party_Id !='NULL'
  UNION
  select distinct
  'BROKER' as party_key_type_cd,
  declarant_eori as broker_party_id,
  declarant_eori as broker_number,
  COALESCE(nullif(declarant_name,'NULL'),'Unknown') as broker_name,
  NULL as broker_postcode,
  0 as broker_authorized_fg, 
  dwh_src_file_name,
  dwh_src_1_tmsp,
  DWH_SRC_1_TMSP as dwh_mapping_tmsp,
  0 as tf_error_fg,
  0 as deleted_fg,
  0 as record_id,
  dwh_src_file_name as filename  
from etl.t_cache_cds_header_2
 where Broker_Party_Id !='NULL'
   ) 
   QUALIFY ROW_NUMBER() OVER(PARTITION BY BROKER_PARTY_ID ORDER BY DWH_SRC_FILE_NAME) = 1
   ) ct
   left join meta.t_party_key_2 pk
   on ct.BROKER_PARTY_ID=pk.PARTY_NAT_KEY_NR
   and pk.party_key_type_cd = 'BROKER'
   left join core_rel.t_broker_2 b
   on pk.party_sid= b.party_sid
   where b.party_sid is null;
