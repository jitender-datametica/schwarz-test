CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_dim_consignor_2 (party_sid, consignor_stream_cd, consignor_stream_name,
importer_party_sid, importer_nr, importer_name, consignor_name) AS SELECT party_sid,
 consignor_stream_cd,
 consignor_stream_name,
 importer_party_sid,
 importer_nr,
 importer_name,
 consignor_name
FROM szd_core.t_dim_consignor_2
WHERE dwh_valid_fg;