CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_bewart_spr_zu_en_1 (mandant_id, bwart, lager_bewart_bez, spr_id
) AS SELECT mandant_id,
 lager_bewart_id AS bwart,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN lager_bewart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lager_bewart_bez
    ELSE NULL
    END)) AS lager_bewart_bez,
 MAX(spr_id) AS spr_id
FROM kfl_production_dbp_view.v_lager_bewart_spr_zu_1 AS V01
WHERE spr_id IN (22, 24)
GROUP BY mandant_id,
 bwart;