CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_buchungskreis_spr_zu_2
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 buchungskreis_id,
 spr_id,
 buchungskreis_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_buchungskreis_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22;