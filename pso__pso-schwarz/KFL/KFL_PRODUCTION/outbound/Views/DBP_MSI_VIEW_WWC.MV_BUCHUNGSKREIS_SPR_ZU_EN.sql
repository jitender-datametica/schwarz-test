CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_buchungskreis_spr_zu_en (mandant_id, bukrs, buchungskreis_bez
, spr_id) AS SELECT mandant_id,
 buchungskreis_id AS bukrs,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN buchungskreis_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN buchungskreis_bez
    ELSE NULL
    END)) AS buchungskreis_bez,
 MAX(spr_id) AS spr_id
FROM kfl_production_dbp_view.v_buchungskreis_spr_zu AS V01
WHERE spr_id IN (22, 24)
GROUP BY mandant_id,
 bukrs;