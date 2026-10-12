CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_saison_spr_zu_en_2 (mandant_id, saiso, saison_bez, spr_id) AS
SELECT mandant_id,
 saison_id AS saiso,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN saison_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN saison_bez
    ELSE NULL
    END)) AS saison_bez,
 MAX(spr_id) AS spr_id
FROM kfl_production_dbp_view.v_saison_spr_zu_2 AS V01
WHERE spr_id IN (22, 24)
GROUP BY mandant_id,
 saiso;