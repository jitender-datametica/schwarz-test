CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_lager_bewgrund_spr_zu_en_1 (mandant_id, grund, bwart, grund_bez
, spr_id) AS SELECT mandant_id,
 grund_id AS grund,
 lager_bewart_id AS bwart,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN grund_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN grund_bez
    ELSE NULL
    END)) AS grund_bez,
 MAX(spr_id) AS spr_id
FROM kfl_production_dbp_view.v_lager_bewgrund_spr_zu_1 AS V01
WHERE spr_id IN (22, 24)
 AND hist_fg = 0
GROUP BY mandant_id,
 grund,
 bwart;