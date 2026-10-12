CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_artikeltyp_spr_zu_en_1 (mandant_id, attyp, artikeltyp_bez,
spr_id) AS SELECT mandant_id,
 artikeltyp_id AS attyp,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN artikeltyp_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN artikeltyp_bez
    ELSE NULL
    END)) AS artikeltyp_bez,
 MAX(spr_id) AS spr_id
FROM kfl_production_dbp_view.v_artikeltyp_spr_zu_1 AS V01
WHERE spr_id IN (22, 24)
GROUP BY mandant_id,
 artikeltyp_id;