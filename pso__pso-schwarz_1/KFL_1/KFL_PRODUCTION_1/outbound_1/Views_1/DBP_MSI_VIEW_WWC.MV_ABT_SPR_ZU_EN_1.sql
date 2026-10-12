CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_abt_spr_zu_en_1 (mandant_id, arthiertyp_id, abt_id, abt_bez,
spr_id) AS SELECT mandant_id,
 arthiertyp_id,
 abt_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN abt_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN abt_bez
    ELSE NULL
    END)) AS abt_bez,
 MAX(spr_id) AS spr_id
FROM kfl_production_dbp_view.v_abt_spr_zu_1 AS V01
WHERE arthiertyp_id = 2
 AND spr_id IN (22, 24)
GROUP BY mandant_id,
 arthiertyp_id,
 abt_id;