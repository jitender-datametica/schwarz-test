INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
party_sid,
importer_nr,
importer_name,
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
importer_number,
importer_name,
dwh_valid_fg,
dwh_valid_from_tmsp dwh_mapping_tmsp,
dwh_src_file_name,
dwh_src_1_tmsp,
0 tf_error_fg,
0 record_id,
dwh_src_file_name filename,
0 deleted_fg
--SELECT * 
FROM core_rel.t_importer_1;
