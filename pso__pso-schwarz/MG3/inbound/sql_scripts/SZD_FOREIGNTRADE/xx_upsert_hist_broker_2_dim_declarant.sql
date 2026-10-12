INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
party_sid,
declarant_type_cd,
declarant_type_name,
declarant_nr,
declarant_name,
declarant_auth_status_cd,
declarant_auth_status_name,
declarant_authorized_fg,
dwh_valid_fg,
dwh_mapping_tmsp,
dwh_src_file_name,
dwh_src_1_tmsp,
tf_error_fg,
record_id,
filename,
deleted_fg
)
SELECT 
party_sid,
'BROKER' as declarant_type_cd,
'Broker' as declarant_type_name,                                                                                                 
broker_number,
broker_name,
declarant_auth_status_cd,
declarant_auth_status_name,
declarant_authorized_fg,
b.dwh_valid_fg,
b.dwh_valid_from_tmsp as dwh_mapping_tmsp,
b.dwh_src_file_name,
b.dwh_src_1_tmsp,
0 tf_error_fg,
0 record_id,
b.dwh_src_file_name filename,
0 deleted_fg 
FROM core_rel.t_broker b
  join core.t_dim_declarant_auth_status s
    on b.broker_authorized_fg = s.declarant_authorized_fg
   and s.declarant_auth_status_cd != '-1'
WHERE
party_sid != -1   
                                                                                                 
union
                                                                                                 
select i.party_sid,
'IMPORTER' as declarant_type_cd,
'Importer' as declarant_type_name,
i.importer_number as declarant_number,
i.importer_name as declarant_name,
s.declarant_auth_status_cd,					
s.declarant_auth_status_name,			
s.declarant_authorized_fg,					
i.dwh_valid_fg,
i.dwh_valid_from_tmsp as dwh_mapping_tmsp,
i.dwh_src_file_name,
i.dwh_src_1_tmsp,
0 tf_error_fg,
0 record_id,
i.dwh_src_file_name filename,
0 deleted_fg                                                                                                 
from core_rel.t_importer i
join core.t_dim_declarant_auth_status s
on s.declarant_authorized_fg = true
and s.declarant_auth_status_cd != '-1' 
WHERE party_sid != -1 
