CREATE OR REPLACE VIEW kfl_production_dbp_msi_view2.mv_gp_ums_ek_1 (gp_id, kj_bezugsjahr, teilgebiet, lief_umsatz,
umsatz_wrg_id) AS SELECT DISTINCT gp_id,
 kj_bezugsjahr,
 teilgebiet,
 umsatz_netto AS lief_umsatz,
 umsatz_wrg_id
FROM kfl_production_dbp_view.v_gp_ums_ek_1
WHERE mandant_id = 1;