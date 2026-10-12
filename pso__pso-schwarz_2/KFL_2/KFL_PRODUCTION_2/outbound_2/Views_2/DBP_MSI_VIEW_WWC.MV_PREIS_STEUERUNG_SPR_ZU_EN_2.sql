CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_preis_steuerung_spr_zu_en_2 (mandant_id, preis_steuer_kz,
preis_steuerung_bez, spr_id) AS SELECT mandant_id,
 preis_steuer_kz,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN preis_steuerung_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN preis_steuerung_bez
    ELSE NULL
    END)) AS preis_steuerung_bez,
 MAX(spr_id) AS spr_id
FROM kfl_production_dbp_view.v_preis_steuerung_spr_zu_2 AS V01
WHERE spr_id IN (22, 24)
GROUP BY mandant_id,
 preis_steuer_kz;