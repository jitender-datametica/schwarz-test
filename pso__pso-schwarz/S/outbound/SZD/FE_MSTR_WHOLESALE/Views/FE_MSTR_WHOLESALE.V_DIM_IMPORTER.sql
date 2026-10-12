CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_dim_importer (party_sid, importer_nr, importer_name) AS SELECT party_sid
 ,
 importer_nr,
 importer_name
FROM szd_core.t_dim_importer
WHERE dwh_valid_fg;