CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_artkz_lead_en (mandant_id, lead_id, lead_bez, spr_id) AS
SELECT mandant_id,
 lead_id,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN lead_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN lead_bez
    ELSE NULL
    END)) AS lead_bez,
 MAX(spr_id) AS spr_id
FROM kfl_production_dbp_view.v_artkz_lead AS V01
WHERE spr_id IN (22, 24)
GROUP BY mandant_id,
 lead_id;