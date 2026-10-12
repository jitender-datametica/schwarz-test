CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_hl_en (mandant_id, hausleiter_id, ma_anrede, ma_name,
ma_vorname, spr_id) AS SELECT mandant_id,
 ma_id AS hausleiter_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN ma_anrede
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_anrede
    ELSE NULL
    END)) AS ma_anrede,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN ma_name
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_name
    ELSE NULL
    END)) AS ma_name,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN ma_vorname
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN ma_vorname
    ELSE NULL
    END)) AS ma_vorname,
 MAX(spr_id) AS spr_id
FROM kfl_production_dbp_view.v_ma_spr_zu AS V01
WHERE spr_id IN (22, 24)
 AND (mandant_id, ma_id) IN (SELECT (mandant_id, hausleiter_id)
   FROM kfl_production_dbp_msi_v_view.v_wup_denorm)
GROUP BY mandant_id,
 hausleiter_id;