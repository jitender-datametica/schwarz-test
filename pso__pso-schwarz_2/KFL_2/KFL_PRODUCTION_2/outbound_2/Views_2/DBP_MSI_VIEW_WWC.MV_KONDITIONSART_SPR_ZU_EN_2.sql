CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_konditionsart_spr_zu_en_2 (system_id, mandant_id, spr_id, kschl
, kschl_bez) AS SELECT system_id,
 mandant_id,
 MAX(spr_id) AS spr_id,
 konditionsart_id AS kschl,
 COALESCE(MAX(CASE
    WHEN spr_id = 24
    THEN konditionsart_bez
    ELSE NULL
    END), MAX(CASE
    WHEN spr_id = 22
    THEN konditionsart_bez
    ELSE NULL
    END)) AS kschl_bez
FROM kfl_production_dbp_view.v_konditionsart_spr_zu_2 AS V01
WHERE spr_id IN (22, 24)
GROUP BY system_id,
 mandant_id,
 kschl;