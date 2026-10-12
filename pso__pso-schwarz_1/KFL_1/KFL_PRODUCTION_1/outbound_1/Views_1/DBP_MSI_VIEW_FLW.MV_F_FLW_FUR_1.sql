CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_flw.mv_f_flw_fur_1 (mandant_id, in_art_id, in_kunde_id, dat, einh_id,
menge_sicherheit, menge_plan, dat_erstellung) AS SELECT mandant_id,
 flw_art_id AS in_art_id,
 flw_kunde_id AS in_kunde_id,
 dat,
 einh_id,
 menge_sicherheit,
 menge_plan,
 dat_erstellung
FROM kfl_production_dbp_view.v_flw_fur_1 AS V01;