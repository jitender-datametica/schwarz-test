CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_sort_gfk_hhp_leh_account_2 (mandant_id, gfk_account_id,
gfk_account_bez) AS SELECT mandant_id,
 gfk_account_id,
 gfk_account_bez
FROM kfl_production_dbp_data.gfk_hhp_leh_account_2;