CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_lagerprozessart_spr_zu_1 (mandant_id, lagerprozessart_id,
lagerprozessart_bez, lagerprozessart_bez_de, lagerprozessart_bez_cz, lagerprozessart_bez_sk, lagerprozessart_bez_hr,
lagerprozessart_bez_pl, lagerprozessart_bez_ro, lagerprozessart_bez_bg) AS SELECT mandant_id,
 lagerprozessart_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN lagerprozessart_bez
   ELSE NULL
   END) AS lagerprozessart_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN lagerprozessart_bez
   ELSE NULL
   END) AS lagerprozessart_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN lagerprozessart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerprozessart_bez
    ELSE NULL
    END)) AS lagerprozessart_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN lagerprozessart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerprozessart_bez
    ELSE NULL
    END)) AS lagerprozessart_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN lagerprozessart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerprozessart_bez
    ELSE NULL
    END)) AS lagerprozessart_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN lagerprozessart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerprozessart_bez
    ELSE NULL
    END)) AS lagerprozessart_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN lagerprozessart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerprozessart_bez
    ELSE NULL
    END)) AS lagerprozessart_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN lagerprozessart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerprozessart_bez
    ELSE NULL
    END)) AS lagerprozessart_bez_bg
FROM kfl_production_dbp_view.v_lagerprozessart_spr_zu_1 AS V01
GROUP BY mandant_id,
 lagerprozessart_id;