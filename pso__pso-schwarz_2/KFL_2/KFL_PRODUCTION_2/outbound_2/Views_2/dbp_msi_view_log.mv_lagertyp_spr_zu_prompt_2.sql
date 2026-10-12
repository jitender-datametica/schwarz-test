CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_lagertyp_spr_zu_prompt_2 (lagertyp_id, lagertyp_bez,
lagertyp_bez_de, lagertyp_bez_cz, lagertyp_bez_sk, lagertyp_bez_hr, lagertyp_bez_pl, lagertyp_bez_ro, lagertyp_bez_bg)
AS SELECT lagertyp_id,
 MAX(CASE
   WHEN spr_id = 22
   THEN UPPER(lagertyp_bez)
   ELSE NULL
   END) AS lagertyp_bez,
 MAX(CASE
   WHEN spr_id = 22
   THEN UPPER(lagertyp_bez)
   ELSE NULL
   END) AS lagertyp_bez_de,
 COALESCE(MAX(CASE
    WHEN spr_id = 124
    THEN UPPER(lagertyp_bez)
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN UPPER(lagertyp_bez)
    ELSE NULL
    END)) AS lagertyp_bez_cz,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN UPPER(lagertyp_bez)
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN UPPER(lagertyp_bez)
    ELSE NULL
    END)) AS lagertyp_bez_sk,
 COALESCE(MAX(CASE
    WHEN spr_id = 65
    THEN UPPER(lagertyp_bez)
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN UPPER(lagertyp_bez)
    ELSE NULL
    END)) AS lagertyp_bez_hr,
 COALESCE(MAX(CASE
    WHEN spr_id = 90
    THEN UPPER(lagertyp_bez)
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN UPPER(lagertyp_bez)
    ELSE NULL
    END)) AS lagertyp_bez_pl,
 COALESCE(MAX(CASE
    WHEN spr_id = 95
    THEN UPPER(lagertyp_bez)
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN UPPER(lagertyp_bez)
    ELSE NULL
    END)) AS lagertyp_bez_ro,
 COALESCE(MAX(CASE
    WHEN spr_id = 18
    THEN UPPER(lagertyp_bez)
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN UPPER(lagertyp_bez)
    ELSE NULL
    END)) AS lagertyp_bez_bg
FROM kfl_production_dbp_view.v_lagertyp_spr_zu_2 AS V01
WHERE LENGTH(TRIM(lagertyp_id)) = 4
 AND wup_id > 0
GROUP BY lagertyp_id;