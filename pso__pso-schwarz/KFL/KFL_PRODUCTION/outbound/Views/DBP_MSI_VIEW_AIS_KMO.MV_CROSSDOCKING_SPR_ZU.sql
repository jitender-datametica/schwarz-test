CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_kmo.mv_crossdocking_spr_zu (mandant_id, crossdocking_id,
crossdocking_bez, crossdocking_bez_de, crossdocking_bez_cz, crossdocking_bez_sk, crossdocking_bez_hr,
crossdocking_bez_pl, crossdocking_bez_ro, crossdocking_bez_bg) AS SELECT mandant_id,
 crossdocking_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN crossdocking_bez
    ELSE NULL
    END), 'N/A') AS crossdocking_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN crossdocking_bez
    ELSE NULL
    END), 'N/A') AS crossdocking_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN crossdocking_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN crossdocking_bez
     ELSE NULL
     END), 'N/A')) AS crossdocking_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN crossdocking_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN crossdocking_bez
     ELSE NULL
     END), 'N/A')) AS crossdocking_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN crossdocking_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN crossdocking_bez
     ELSE NULL
     END), 'N/A')) AS crossdocking_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN crossdocking_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN crossdocking_bez
     ELSE NULL
     END), 'N/A')) AS crossdocking_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN crossdocking_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN crossdocking_bez
     ELSE NULL
     END), 'N/A')) AS crossdocking_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN crossdocking_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN crossdocking_bez
     ELSE NULL
     END), 'N/A')) AS crossdocking_bez_bg
FROM kfl_production_dbp_data.crossdocking_spr_zu AS V01
GROUP BY mandant_id,
 crossdocking_id;