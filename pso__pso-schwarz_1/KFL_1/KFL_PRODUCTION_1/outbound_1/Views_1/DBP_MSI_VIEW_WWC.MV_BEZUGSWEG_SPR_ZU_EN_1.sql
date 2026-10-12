CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_bezugsweg_spr_zu_en_1 (mandant_id, bwscl, spr_id, bezugsweg_bez
) AS SELECT mandant_id,
 bezugsweg_id AS bwscl,
 MAX(spr_id) AS spr_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN bezugsweg_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN bezugsweg_bez
    ELSE NULL
    END)) AS bezugsweg_bez
FROM kfl_production_dbp_view.v_bezugsweg_spr_zu_1
WHERE spr_id IN (22, 24)
 AND mandant_id <> 1
GROUP BY mandant_id,
 bezugsweg_id;