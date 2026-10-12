CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_altersstruktur_spr_zu_sk_1 AS SELECT altersstruktur_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 108
    THEN altersstruktur_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN altersstruktur_bez
    ELSE NULL
    END)) AS altersstruktur_bez,
 MAX(spr_id) AS spr_id
FROM kfl_production_dbp_view.v_altersstruktur_spr_zu_1 AS V01
WHERE spr_id IN (108, 22)
GROUP BY altersstruktur_id;