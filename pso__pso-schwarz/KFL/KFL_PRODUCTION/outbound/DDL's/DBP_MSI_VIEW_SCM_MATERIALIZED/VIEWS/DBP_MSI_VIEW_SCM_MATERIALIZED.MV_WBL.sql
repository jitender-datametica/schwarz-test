-- 2024-01-24, dknop, remove where-clause
 CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_scm_materialized.mv_wbl (ek_fg
, gf_id, wbl_dat_von, wbl_id, wbl_name, mandant_id) AS -- WHERE
 -- v01.mandant_id = 1;
 SELECT ek_fg,
 gf_id,
 wbl_dat_von,
 wbl_id,
 wbl_name,
 mandant_id
FROM kfl_production_dbp_view.v_wbl AS V01;