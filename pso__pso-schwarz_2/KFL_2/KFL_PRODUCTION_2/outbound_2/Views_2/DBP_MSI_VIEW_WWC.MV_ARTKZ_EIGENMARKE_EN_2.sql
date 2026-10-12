CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_artkz_eigenmarke_en_2 (mandant_id, eigenmarke_id, eigenmarke_bez
, spr_id) AS SELECT mandant_id,
 eigenmarke_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN eigenmarke_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN eigenmarke_bez
    ELSE NULL
    END)) AS eigenmarke_bez,
 MAX(spr_id) AS spr_id
FROM kfl_production_dbp_view.v_artkz_eigenmarke_2 AS V01
WHERE spr_id IN (22, 24)
GROUP BY mandant_id,
 eigenmarke_id;