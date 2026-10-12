CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_gp_land_zu
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT A.land_id,
 B.land_bez,
 B.mandant_id,
 7 AS system_id
FROM kfl_production_dbp_view.v_gp AS A
 LEFT JOIN kfl_production_dbp_view.v_land AS B ON A.land_id = B.land_id AND A.mandant_id = B.mandant_id
WHERE A.mandant_id = 1
GROUP BY A.land_id,
 B.land_bez,
 B.mandant_id,
 system_id;