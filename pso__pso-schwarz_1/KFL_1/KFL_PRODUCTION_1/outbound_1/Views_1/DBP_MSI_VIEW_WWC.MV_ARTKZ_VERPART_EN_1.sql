CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_artkz_verpart_en_1 (mandant_id, verpart_id, spr_id, verpart_bez
) AS SELECT mandant_id,
 verpart_id,
 MAX(spr_id) AS spr_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN verpart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN verpart_bez
    ELSE NULL
    END)) AS verpart_bez
FROM kfl_production_dbp_view.v_artkz_verpart_1 AS V01
WHERE spr_id IN (22, 24)
GROUP BY mandant_id,
 verpart_id;