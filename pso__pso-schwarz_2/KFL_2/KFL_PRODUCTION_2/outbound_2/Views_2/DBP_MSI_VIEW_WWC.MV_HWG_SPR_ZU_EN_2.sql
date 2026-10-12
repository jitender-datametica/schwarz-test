CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_hwg_spr_zu_en_2 (hwg_id, arthiertyp_id, mandant_id, spr_id,
hwg_bez, hwg_id_bez) AS SELECT hwg_id,
 arthiertyp_id,
 mandant_id,
 MAX(spr_id) AS spr_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN hwg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN hwg_bez
    ELSE NULL
    END)) AS hwg_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN TRIM(CAST(hwg_id AS STRING FORMAT '000')) || ' ' || hwg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN TRIM(CAST(hwg_id AS STRING FORMAT '000')) || ' ' || hwg_bez
    ELSE NULL
    END)) AS hwg_id_bez
FROM kfl_production_dbp_view.v_hwg_spr_zu_2 AS V01
WHERE spr_id IN (22, 24)
 AND arthiertyp_id = 2
 AND hwg_id >= 0
GROUP BY hwg_id,
 mandant_id,
 arthiertyp_id;