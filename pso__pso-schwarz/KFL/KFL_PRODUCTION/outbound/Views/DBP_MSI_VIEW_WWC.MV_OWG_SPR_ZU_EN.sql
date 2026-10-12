CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_owg_spr_zu_en (owg_id, arthiertyp_id, mandant_id, spr_id,
owg_bez, owg_id_bez) AS SELECT owg_id,
 arthiertyp_id,
 mandant_id,
 MAX(spr_id) AS spr_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN owg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN owg_bez
    ELSE NULL
    END)) AS owg_bez,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN TRIM(CAST(owg_id AS STRING FORMAT '0000')) || ' ' || owg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN TRIM(CAST(owg_id AS STRING FORMAT '0000')) || ' ' || owg_bez
    ELSE NULL
    END)) AS owg_id_bez
FROM kfl_production_dbp_view.v_owg_spr_zu AS V01
WHERE spr_id IN (22, 24)
 AND arthiertyp_id = 2
 AND owg_id >= 0
GROUP BY owg_id,
 mandant_id,
 arthiertyp_id;