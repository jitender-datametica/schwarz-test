CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_hgp_buchungskreis_zu_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT mandant_id,
 gp_id AS hgp_id,
 einkaufsorganisation_id,
 buchungskreis_id,
 zahlsperre_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_gp_buchungskreis_zu_1
WHERE mandant_id = 1
 AND gp_id < 1000000;