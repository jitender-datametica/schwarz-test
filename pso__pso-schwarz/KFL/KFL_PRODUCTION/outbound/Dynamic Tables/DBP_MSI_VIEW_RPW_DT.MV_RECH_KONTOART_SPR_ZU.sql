CREATE OR REPLACE TABLE dbp_msi_view_rpw_dt.mv_rech_kontoart_spr_zu AS
SELECT 7 AS system_id,
 mandant_id,
 rech_kontoart_id,
 spr_id,
 rech_kontoart_bez
FROM kfl_production_dbp_view.v_rech_kontoart_spr_zu
WHERE mandant_id = 1
 AND spr_id = 22
UNION ALL
SELECT 7 AS system_id,
 1 AS mandant_id,
 '0' AS rech_kontoart_id,
 22 AS spr_id,
 'system generated' AS rech_kontoart_bez
FROM kfl_production_dbp_view.v_rech_kontoart_spr_zu
GROUP BY 1,
 2,
 3,
 4;