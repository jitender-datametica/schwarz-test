CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ek_sort.mv_gfk_hhp_leh_account (mandant_id, gfk_account_id,
gfk_account_bez) AS SELECT mandant_id,
 gfk_account_id,
 gfk_account_bez
FROM kfl_production_dbp_view.v_gfk_hhp_leh_account;