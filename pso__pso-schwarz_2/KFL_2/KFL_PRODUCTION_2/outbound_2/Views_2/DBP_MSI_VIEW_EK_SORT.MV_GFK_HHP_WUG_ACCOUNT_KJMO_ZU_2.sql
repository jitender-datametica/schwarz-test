CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_gfk_hhp_wug_account_kjmo_zu_2 (mandant_id, gfk_account_id,
gfk_wg_id, gfk_wug_id, kjmo, wrg_id, umsatz_tsd_eur, umsatz_potenzial_tsd_eur, umsatz_potenzial_anteil) AS SELECT
 mandant_id,
 gfk_account_id,
 gfk_wg_id,
 gfk_wug_id,
 kjmo,
 wrg_id,
 umsatz_tsd_eur,
 umsatz_potenzial_tsd_eur,
 umsatz_potenzial_anteil
FROM kfl_production_dbp_view.v_gfk_hhp_wug_account_kjmo_zu_2 AS V01;