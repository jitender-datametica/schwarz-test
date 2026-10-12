CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_lagerort_spr_zu_en (mandant_id, werks, nb_id, lgort,
lagerort_bez, spr_id) AS SELECT mandant_id,
 wup_id AS werks,
 nb_id,
 lagerort_id AS lgort,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN lagerort_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lagerort_bez
    ELSE NULL
    END)) AS lagerort_bez,
 MAX(spr_id) AS spr_id
FROM kfl_production_dbp_view.v_lagerort_spr_zu AS V01
WHERE spr_id IN (22, 24)
GROUP BY mandant_id,
 werks,
 nb_id,
 lgort;