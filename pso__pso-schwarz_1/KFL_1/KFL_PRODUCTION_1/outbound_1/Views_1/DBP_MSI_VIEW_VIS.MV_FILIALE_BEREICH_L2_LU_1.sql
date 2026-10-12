CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_vis.mv_filiale_bereich_l2_lu_1 AS SELECT OEB.hr_objekt_bereich_id AS
 filiale_bereich_l2_id,
 MAX(CASE
   WHEN OEB.spr_id = 22
   THEN OEB.hr_objekt_bereich_bez
   ELSE TRIM(SUBSTR(CAST(OEB.hr_objekt_bereich_id AS STRING), 1, 39))
   END) AS filiale_bereich_l2_bez,
 COALESCE(MAX(CASE
    WHEN OEB.spr_id = 124
    THEN OEB.hr_objekt_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN OEB.spr_id = 22
    THEN OEB.hr_objekt_bereich_bez
    ELSE TRIM(SUBSTR(CAST(OEB.hr_objekt_bereich_id AS STRING), 1, 39))
    END)) AS filiale_bereich_l2_bez_cz,
 COALESCE(MAX(CASE
    WHEN OEB.spr_id = 108
    THEN OEB.hr_objekt_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN OEB.spr_id = 22
    THEN OEB.hr_objekt_bereich_bez
    ELSE TRIM(SUBSTR(CAST(OEB.hr_objekt_bereich_id AS STRING), 1, 39))
    END)) AS filiale_bereich_l2_bez_sk,
 COALESCE(MAX(CASE
    WHEN OEB.spr_id = 65
    THEN OEB.hr_objekt_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN OEB.spr_id = 22
    THEN OEB.hr_objekt_bereich_bez
    ELSE TRIM(SUBSTR(CAST(OEB.hr_objekt_bereich_id AS STRING), 1, 39))
    END)) AS filiale_bereich_l2_bez_hr,
 COALESCE(MAX(CASE
    WHEN OEB.spr_id = 90
    THEN OEB.hr_objekt_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN OEB.spr_id = 22
    THEN OEB.hr_objekt_bereich_bez
    ELSE TRIM(SUBSTR(CAST(OEB.hr_objekt_bereich_id AS STRING), 1, 39))
    END)) AS filiale_bereich_l2_bez_pl,
 COALESCE(MAX(CASE
    WHEN OEB.spr_id = 95
    THEN OEB.hr_objekt_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN OEB.spr_id = 22
    THEN OEB.hr_objekt_bereich_bez
    ELSE TRIM(SUBSTR(CAST(OEB.hr_objekt_bereich_id AS STRING), 1, 39))
    END)) AS filiale_bereich_l2_bez_ro,
 COALESCE(MAX(CASE
    WHEN OEB.spr_id = 18
    THEN OEB.hr_objekt_bereich_bez
    ELSE NULL
    END), MAX(CASE
    WHEN OEB.spr_id = 22
    THEN OEB.hr_objekt_bereich_bez
    ELSE TRIM(SUBSTR(CAST(OEB.hr_objekt_bereich_id AS STRING), 1, 39))
    END)) AS filiale_bereich_l2_bez_bg,
 MAX(CASE
   WHEN OEB.spr_id = 22
   THEN OEB.hr_objekt_bereich_bez
   ELSE TRIM(SUBSTR(CAST(OEB.hr_objekt_bereich_id AS STRING), 1, 39))
   END) AS hr_objekt_bereich
FROM kfl_production_dbp_view.v_l_org_einheit_bereich_level2_1 AS LVL2
 INNER JOIN kfl_production_dbp_view.v_org_einheit_bereich_spr_zu_1 AS OEB ON LVL2.hr_objekt_bereich_level2_id = OEB.hr_objekt_bereich_id
  
GROUP BY filiale_bereich_l2_id;