CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_poolfahigkeit_ffz_spr_zu_1 (poolfahigkeit_ffz_id, mandant_id,
poolfahigkeit_ffz_bez) AS SELECT tp_merkmalart_id AS poolfahigkeit_ffz_id,
 mandant_id,
 tp_merkmalart_bez AS poolfahigkeit_ffz_bez
FROM kfl_production_dbp_view.v_tp_merkmalart_spr_zu_1
WHERE (mandant_id, tp_merkmal_id) IN (SELECT (mandant_id, tp_merkmal_id)
   FROM kfl_production_dbp_view.v_l_tp_merkmal_1
   WHERE tp_merkmal_sap_id = 'FFZ-POOLFAEHIG')
 AND spr_id = 22
GROUP BY poolfahigkeit_ffz_id,
 mandant_id,
 poolfahigkeit_ffz_bez
UNION DISTINCT
SELECT - 1 AS equipmentklasse_ffz_id,
 mandant_id,
 'keine Angabe' AS equipmentklasse_ffz_bez
FROM kfl_production_dbp_view.v_mandant_1;