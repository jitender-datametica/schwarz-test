INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
clearance_dt, 
authority_country_location_sid, 
consignor_party_sid, 
customs_procedure_cd, 
customs_declaration_type_cd, 
declaration_cnt,
dwh_mapping_tmsp,
dwh_src_file_name,
dwh_src_1_tmsp,
tf_error_fg,
dwh_load_id,
record_id,
filename,
deleted_fg
)
select ccr.clearance_dt,
       ccr.authority_country_location_sid,
       ccr.consignor_party_sid,
       crl.customs_procedure_cd,
       ccr.customs_declaration_type_cd,
       count(distinct crl.movement_ref_number) as declaration_cnt,
ccr.dwh_src_1_tmsp dwh_mapping_tmsp,
ccr.dwh_src_file_name,
ccr.dwh_src_1_tmsp,
0 tf_error_fg,
0 as dwh_load_id,
0 record_id,
ccr.dwh_src_file_name filename,
0 deleted_fg
from core_rel.t_customs_clearance_report ccr
  join core_rel.t_customs_clearance_report_line crl
    on ccr.movement_ref_number = crl.movement_ref_number
 group
    by ccr.clearance_dt,
       ccr.authority_country_location_sid,
       ccr.consignor_party_sid,
       crl.customs_procedure_cd,
       ccr.customs_declaration_type_cd,
ccr.dwh_src_1_tmsp,
ccr.dwh_src_file_name;
