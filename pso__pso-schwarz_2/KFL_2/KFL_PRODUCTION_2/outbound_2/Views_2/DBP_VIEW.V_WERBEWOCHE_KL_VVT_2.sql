CREATE OR REPLACE VIEW kfl_production_dbp_view.v_werbewoche_kl_vvt_2 AS SELECT mandant_id,
 dat,
 akt_kjwo_ww,
 akt_kjwo_ww_komplett,
 kjwo_ww,
 td_update,
 td_insert
FROM kfl_production_dbp_data.werbewoche_kl_vvt_2;