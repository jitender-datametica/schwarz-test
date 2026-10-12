CREATE OR REPLACE VIEW kfl_production_dbp_view.v_gfk_hhp_wg_account_na_kjmo_zu_1 AS SELECT mandant_id,
 gfk_account_id,
 gfk_wg_id,
 kjmo,
 wrg_id,
 nebenausgaben_anteil,
 nebenausgaben_tsd_eur,
 nebenausgaben_index,
 td_insert,
 td_update
FROM kfl_production_dbp_data.gfk_hhp_wg_account_na_kjmo_zu_1;