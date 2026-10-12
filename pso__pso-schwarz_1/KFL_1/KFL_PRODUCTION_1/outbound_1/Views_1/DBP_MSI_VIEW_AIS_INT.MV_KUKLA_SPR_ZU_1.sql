CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_ais_int.mv_kukla_spr_zu_1 (mandant_id, kukla_id, kukla_bez,
kukla_bez_de, kukla_bez_cz, kukla_bez_sk, kukla_bez_hr, kukla_bez_pl, kukla_bez_ro, kukla_bez_bg) AS SELECT mandant_id,
 kukla_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN kukla_bez
    ELSE NULL
    END), 'N/A') AS kukla_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 22
    THEN kukla_bez
    ELSE NULL
    END), 'N/A') AS kukla_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN kukla_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kukla_bez
     ELSE NULL
     END), 'N/A')) AS kukla_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN kukla_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kukla_bez
     ELSE NULL
     END), 'N/A')) AS kukla_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN kukla_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kukla_bez
     ELSE NULL
     END), 'N/A')) AS kukla_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN kukla_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kukla_bez
     ELSE NULL
     END), 'N/A')) AS kukla_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN kukla_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kukla_bez
     ELSE NULL
     END), 'N/A')) AS kukla_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN kukla_bez
    ELSE NULL
    END), COALESCE(MAX(CASE
     WHEN spr_id = 22
     THEN kukla_bez
     ELSE NULL
     END), 'N/A')) AS kukla_bez_bg
FROM kfl_production_dbp_data.kukla_spr_zu_1 AS V01
GROUP BY mandant_id,
 kukla_id;