CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_lagernummer_spr_zu AS SELECT mandant_id,
 wup_id,
 nb_id,
 lagernummer_id,
 LEFT(lagernummer_id, 3) AS lagernummer_erp_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN lagernummer_bez
   ELSE NULL
   END) AS lagernummer_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN lagernummer_bez
   ELSE NULL
   END) AS lagernummer_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN lagernummer_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagernummer_bez
    ELSE NULL
    END)) AS lagernummer_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN lagernummer_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagernummer_bez
    ELSE NULL
    END)) AS lagernummer_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN lagernummer_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagernummer_bez
    ELSE NULL
    END)) AS lagernummer_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN lagernummer_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagernummer_bez
    ELSE NULL
    END)) AS lagernummer_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN lagernummer_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagernummer_bez
    ELSE NULL
    END)) AS lagernummer_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN lagernummer_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagernummer_bez
    ELSE NULL
    END)) AS lagernummer_bez_bg
FROM kfl_production_dbp_view.v_lagernummer_spr_zu AS V01
WHERE LEFT(lagernummer_id, 1) IN ('D', 'H', 'S', 'P', 'B', 'C', 'M', 'R')
 AND wup_id > 0
 AND LENGTH(TRIM(lagernummer_id)) = 4
GROUP BY mandant_id,
 wup_id,
 nb_id,
 lagernummer_id,
 lagernummer_erp_id;