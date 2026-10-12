CREATE OR REPLACE VIEW kfl_nfmd_fe_mstr_nfmd.mv_wup_2 (mandant_id, wup_id, wup_name, nb_id, dat_von, dat_bis,
dat_eroeffnung, wup_plz, breitengrad, laengengrad, uebernahme_von, vs_id) AS SELECT DISTINCT mandant_id,
 wup_id,
 wup_name_e AS wup_name,
 nb_id,
 dat_von,
 dat_bis,
 dat_eroeffnung,
 wup_plz,
 breitengrad,
 laengengrad,
 uebernahme_von,
 vs_id
FROM kfl_nfmd_core.src_teradata_master_data_wup_2 AS V01
WHERE nb_id = 0;