CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_rpw.mv_rech_kontoart_spr_zu_2 (system_id, mandant_id, rech_kontoart_id
, spr_id, rech_kontoart_bez) AS SELECT 7 AS system_id,
 mandant_id,
 rech_kontoart_id,
 spr_id,
 rech_kontoart_bez
FROM kfl_production_dbp_view.v_rech_kontoart_spr_zu_2
WHERE mandant_id = 1
 AND spr_id = 22
UNION ALL
SELECT 7 AS system_id,
 1,
 '0',
 22,
 'system generated'
FROM kfl_production_dbp_view.v_rech_kontoart_spr_zu_2
GROUP BY 1,
 2,
 3,
 4;