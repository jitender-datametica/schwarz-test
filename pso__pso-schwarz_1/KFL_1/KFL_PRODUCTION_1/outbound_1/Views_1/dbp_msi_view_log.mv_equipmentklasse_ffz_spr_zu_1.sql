CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_equipmentklasse_ffz_spr_zu_1 (equipmentklasse_ffz_id,
equipmentklasse_ffz_bez) AS SELECT tp_merkmalart_id AS equipmentklasse_ffz_id,
 MAX(tp_merkmalart_bez) AS equipmentklasse_ffz_bez
FROM kfl_production_dbp_view.v_tp_merkmalart_spr_zu_1
WHERE (mandant_id, tp_merkmal_id) IN (SELECT (mandant_id, tp_merkmal_id)
   FROM kfl_production_dbp_view.v_l_tp_merkmal_1
   WHERE tp_merkmal_sap_id = 'FFZ-TYP')
 AND spr_id = 22
GROUP BY equipmentklasse_ffz_id
UNION DISTINCT
SELECT - 1 AS equipmentklasse_ffz_id,
 'kein FFZ' AS equipmentklasse_ffz_bez;