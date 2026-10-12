CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_reb.mv_werbewoche_kl (mandant_id, dat, akt_kjwo_ww,
akt_kjwo_ww_komplett, kjwo_ww, wo_ww) AS SELECT mandant_id,
 dat,
 akt_kjwo_ww,
 akt_kjwo_ww_komplett,
 kjwo_ww,
 kjwo_ww AS wo_ww
FROM kfl_production_dbp_view.v_werbewoche_kl;