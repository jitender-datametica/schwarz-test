INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
movement_ref_number,
item_position,
declarant_party_sid,
cds_acceptance_dt,
attribute_name,
attribute_value_txt,
dwh_mapping_tmsp,
dwh_src_file_name,
dwh_src_1_tmsp,
tf_error_fg,
dwh_load_id,
record_id,
filename,
deleted_fg
)
SELECT 
movement_ref_number,
item_position,
broker_declarant_party_sid,
cds_acceptance_dt,
attribute_name,
attribute_value_txt,
dwh_src_1_tmsp dwh_mapping_tmsp,
dwh_src_file_name,
dwh_src_1_tmsp,
0 tf_error_fg,
0 as dwh_load_id,
0 record_id,
dwh_src_file_name filename,
0 deleted_fg
--SELECT * 
FROM core_rel.t_broker_report_error_1;
