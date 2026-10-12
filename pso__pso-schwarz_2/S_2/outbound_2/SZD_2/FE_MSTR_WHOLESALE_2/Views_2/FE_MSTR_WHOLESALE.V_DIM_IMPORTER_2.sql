CREATE OR REPLACE VIEW szd_fe_mstr_wholesale.v_dim_importer_2 (party_sid, importer_nr, importer_name) AS SELECT party_sid
 ,
 importer_nr,
 importer_name
FROM szd_core.t_dim_importer_2
WHERE dwh_valid_fg;