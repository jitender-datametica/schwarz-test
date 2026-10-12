CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_vorgangsart_ag08_spr_zu
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT 7 AS system_id,
 mandant_id,
 vorgangsart_ag08_id,
 spr_id,
 vorgangsart_ag08_bez
FROM kfl_production_dbp_view.v_vorgangsart_ag08_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22;