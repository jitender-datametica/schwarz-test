CREATE OR REPLACE VIEW kfl_production_dbp_view.v_gfk_hhp_wug_account_kjmo_zu_1 AS SELECT mandant_id,
 gfk_account_id,
 gfk_wg_id,
 gfk_wug_id,
 kjmo,
 wrg_id,
 umsatz_tsd_eur,
 umsatz_potenzial_tsd_eur,
 umsatz_potenzial_anteil,
 td_update,
 td_insert
FROM kfl_production_dbp_data.gfk_hhp_wug_account_kjmo_zu_1;