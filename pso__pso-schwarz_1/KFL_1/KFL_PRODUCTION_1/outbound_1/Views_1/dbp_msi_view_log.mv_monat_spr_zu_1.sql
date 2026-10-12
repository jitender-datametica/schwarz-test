CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_monat_spr_zu_1 (mo_id, mo_bez, mo_bez_de, mo_bez_cz, mo_bez_sk,
mo_bez_hr, mo_bez_pl, mo_bez_ro, mo_bez_bg) AS SELECT mo_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN mo_bez
   ELSE NULL
   END) AS mo_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN mo_bez
   ELSE NULL
   END) AS mo_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN mo_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN mo_bez
    ELSE NULL
    END)) AS mo_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN mo_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN mo_bez
    ELSE NULL
    END)) AS mo_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN mo_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN mo_bez
    ELSE NULL
    END)) AS mo_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN mo_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN mo_bez
    ELSE NULL
    END)) AS mo_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN mo_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN mo_bez
    ELSE NULL
    END)) AS mo_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN mo_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN mo_bez
    ELSE NULL
    END)) AS mo_bez_bg
FROM kfl_production_dbp_view.v_monat_spr_zu_1 AS V01
GROUP BY mo_id;