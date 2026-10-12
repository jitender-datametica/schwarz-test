CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_nfmd.mv_wup_1 AS SELECT DISTINCT mandant_id,
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
FROM kfl_production_dbp_view.v_wup_1 AS V01
WHERE nb_id = 0;