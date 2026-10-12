CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_l_vw
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT vw_id,
 mandant_id,
 spr_id,
 vk_id,
 vw_bez,
 vwvt_bez,
 vwart_id,
 sap_vw_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_l_vw
WHERE mandant_id = 1
 AND spr_id = 22;