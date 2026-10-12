CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_hr_objekt_bereich_spr_zu_2 AS SELECT hr_objekt_bereich_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN hr_objekt_bereich_bez
   ELSE TRIM(SUBSTR(CAST(hr_objekt_bereich_id AS STRING), 1, 39))
   END) AS hr_objekt_bereich_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN hr_objekt_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hr_objekt_bereich_bez
    ELSE TRIM(SUBSTR(CAST(hr_objekt_bereich_id AS STRING), 1, 39))
    END)) AS hr_objekt_bereich_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN hr_objekt_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hr_objekt_bereich_bez
    ELSE TRIM(SUBSTR(CAST(hr_objekt_bereich_id AS STRING), 1, 39))
    END)) AS hr_objekt_bereich_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN hr_objekt_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hr_objekt_bereich_bez
    ELSE TRIM(SUBSTR(CAST(hr_objekt_bereich_id AS STRING), 1, 39))
    END)) AS hr_objekt_bereich_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN hr_objekt_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hr_objekt_bereich_bez
    ELSE TRIM(SUBSTR(CAST(hr_objekt_bereich_id AS STRING), 1, 39))
    END)) AS hr_objekt_bereich_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN hr_objekt_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hr_objekt_bereich_bez
    ELSE TRIM(SUBSTR(CAST(hr_objekt_bereich_id AS STRING), 1, 39))
    END)) AS hr_objekt_bereich_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN hr_objekt_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hr_objekt_bereich_bez
    ELSE TRIM(SUBSTR(CAST(hr_objekt_bereich_id AS STRING), 1, 39))
    END)) AS hr_objekt_bereich_bez_bg,
 MAX(CASE
   WHEN spr_id = 22
   THEN hr_objekt_bereich_bez
   ELSE TRIM(SUBSTR(CAST(hr_objekt_bereich_id AS STRING), 1, 39))
   END) AS hr_objekt_bereich_bez_de
FROM kfl_production_dbp_view.v_org_einheit_bereich_spr_zu_2 AS OEB
GROUP BY hr_objekt_bereich_id;