CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_pm_spr_zu_en_1 (pm_id, pm_bez, mandant_id, spr_id) AS SELECT
 pm_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN pm_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN pm_bez
    ELSE NULL
    END)) AS pm_bez,
 mandant_id,
 spr_id
FROM kfl_production_dbp_view.v_pm_1
WHERE spr_id IN (22, 24)
GROUP BY mandant_id,
 pm_id,
 spr_id;