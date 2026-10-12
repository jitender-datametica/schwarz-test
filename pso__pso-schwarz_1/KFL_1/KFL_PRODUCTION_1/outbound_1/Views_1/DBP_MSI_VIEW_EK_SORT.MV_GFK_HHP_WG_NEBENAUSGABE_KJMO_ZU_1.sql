CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_gfk_hhp_wg_nebenausgabe_kjmo_zu_1 (mandant_id,
gfk_account_id, gfk_wg_id, kjmo, wrg_id, nebenausgaben_anteil, nebenausgaben_tsd_eur, nebenausgaben_index) AS SELECT
 mandant_id,
 gfk_account_id,
 gfk_wg_id,
 kjmo,
 wrg_id,
 nebenausgaben_anteil,
 nebenausgaben_tsd_eur,
 nebenausgaben_index
FROM kfl_production_dbp_view.v_gfk_hhp_wg_account_na_kjmo_zu_1 AS V01;