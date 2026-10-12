CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_artikelart_spr_zu_en (mandant_id, mtart, artikelart_bez,
spr_id) AS SELECT mandant_id,
 artikelart_id AS mtart,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN artikelart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN artikelart_bez
    ELSE NULL
    END)) AS artikelart_bez,
 MAX(spr_id) AS spr_id
FROM kfl_production_dbp_view.v_artikelart_spr_zu AS V01
WHERE spr_id IN (22, 24)
GROUP BY mandant_id,
 mtart;