CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_filiale_bereich_l3_lu_1 AS SELECT hr_objekt_bereich_id AS
 filiale_bereich_l3_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN hr_objekt_bereich_bez
   ELSE TRIM(SUBSTR(CAST(hr_objekt_bereich_id AS STRING), 1, 39))
   END) AS filiale_bereich_l3_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN hr_objekt_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hr_objekt_bereich_bez
    ELSE TRIM(SUBSTR(CAST(hr_objekt_bereich_id AS STRING), 1, 39))
    END)) AS filiale_bereich_l3_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN hr_objekt_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hr_objekt_bereich_bez
    ELSE TRIM(SUBSTR(CAST(hr_objekt_bereich_id AS STRING), 1, 39))
    END)) AS filiale_bereich_l3_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN hr_objekt_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hr_objekt_bereich_bez
    ELSE TRIM(SUBSTR(CAST(hr_objekt_bereich_id AS STRING), 1, 39))
    END)) AS filiale_bereich_l3_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN hr_objekt_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hr_objekt_bereich_bez
    ELSE TRIM(SUBSTR(CAST(hr_objekt_bereich_id AS STRING), 1, 39))
    END)) AS filiale_bereich_l3_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN hr_objekt_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hr_objekt_bereich_bez
    ELSE TRIM(SUBSTR(CAST(hr_objekt_bereich_id AS STRING), 1, 39))
    END)) AS filiale_bereich_l3_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN hr_objekt_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hr_objekt_bereich_bez
    ELSE TRIM(SUBSTR(CAST(hr_objekt_bereich_id AS STRING), 1, 39))
    END)) AS filiale_bereich_l3_bez_bg,
 MAX(CASE
   WHEN spr_id = 22
   THEN hr_objekt_bereich_bez
   ELSE TRIM(SUBSTR(CAST(hr_objekt_bereich_id AS STRING), 1, 39))
   END) AS hr_objekt_bereich
FROM kfl_production_dbp_view.v_org_einheit_bereich_spr_zu_1 AS OEB
GROUP BY filiale_bereich_l3_id;