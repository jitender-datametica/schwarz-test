CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_lagerort_spr_zu_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT wup_id,
 mandant_id,
 lagerort_id,
 nb_id,
 spr_id,
 lagerort_bez,
 7 AS system_id
FROM kfl_production_dbp_view.v_lagerort_spr_zu_1
WHERE mandant_id = 1
 AND spr_id = 22;