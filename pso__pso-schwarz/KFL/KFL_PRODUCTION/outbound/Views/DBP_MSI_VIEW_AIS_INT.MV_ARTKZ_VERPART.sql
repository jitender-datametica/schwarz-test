CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_int.mv_artkz_verpart
OPTIONS(enable_refresh = TRUE, refresh_interval_minutes = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) 
AS
SELECT mandant_id,
 verpart_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN verpart_bez
    ELSE NULL
    END), 'N/A') AS verpart_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN verpart_bez
    ELSE NULL
    END), 'N/A') AS verpart_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN verpart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN verpart_bez
     ELSE NULL
     END), 'N/A')) AS verpart_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN verpart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN verpart_bez
     ELSE NULL
     END), 'N/A')) AS verpart_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN verpart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN verpart_bez
     ELSE NULL
     END), 'N/A')) AS verpart_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN verpart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN verpart_bez
     ELSE NULL
     END), 'N/A')) AS verpart_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN verpart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN verpart_bez
     ELSE NULL
     END), 'N/A')) AS verpart_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN verpart_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN verpart_bez
     ELSE NULL
     END), 'N/A')) AS verpart_bez_bg
FROM kfl_production_dbp_view.v_artkz_verpart AS V01
GROUP BY mandant_id,
 verpart_id;