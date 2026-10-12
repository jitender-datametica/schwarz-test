CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_belegart_spr_zu_en_2 (mandant_id, system_id, spr_id, blart,
belegart_bez) AS SELECT mandant_id,
 system_id,
 MAX(spr_id) AS spr_id,
 belegart_id AS blart,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN belegart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN belegart_bez
    ELSE NULL
    END)) AS belegart_bez
FROM kfl_production_dbp_view.v_belegart_spr_zu_2 AS V01
WHERE spr_id IN (22, 24)
GROUP BY mandant_id,
 system_id,
 blart;