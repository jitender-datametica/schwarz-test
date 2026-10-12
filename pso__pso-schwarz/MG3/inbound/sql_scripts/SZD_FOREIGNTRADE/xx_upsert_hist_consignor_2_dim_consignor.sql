INSERT INTO ${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
(
party_sid,
dwh_valid_fg,
consignor_stream_cd,
consignor_stream_name,
importer_party_sid,
importer_nr,
importer_name,
consignor_name,
dwh_src_file_name,
dwh_src_1_tmsp,
tf_error_fg,
error_descr,
record_id,
filename,
deleted_fg,
dwh_mapping_tmsp
)
SELECT 
distinct
c.party_sid,
1 AS dwh_valid_fg,
c.consignor_stream_cd,
cs.consignor_stream_name,
c.importer_party_sid,
i.importer_number,
i.importer_name,
c.consignor_name,
c.dwh_src_file_name,
c.dwh_src_1_tmsp,
0 tf_error_fg,
'' error_descr,
0 record_id,
c.dwh_src_file_name filename,
0 deleted_fg,
c.DWH_VALID_FROM_TMSP  dwh_mapping_tmsp
FROM 
core_rel.t_consignor c 
join core_rel.t_consignor_stream cs on c.consignor_stream_cd = cs.consignor_stream_cd
join core_rel.t_importer i on c.importer_party_sid = i.party_sid;
