CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_equipmentklasse_ffz_2 (mandant_id, tp_object_id,
equipmentklasse_ffz_id) AS SELECT T0.mandant_id,
 T0.tp_objekt_id AS tp_object_id,
 COALESCE(t1.tp_merkmalart_id, - 1) AS equipmentklasse_ffz_id
FROM kfl_production_dbp_view.v_tp_objekt_per_2 AS T0
 LEFT JOIN (SELECT T00.mandant_id,
   T00.tp_objekt_id,
   T01.tp_merkmalart_id
  FROM kfl_production_dbp_view.v_tp_objekt_merkmal_2 AS T00
   INNER JOIN kfl_production_dbp_view.v_tp_merkmalart_spr_zu_2 AS T01 ON T00.mandant_id = T01.mandant_id AND T00.tp_merkmal_id
       = T01.tp_merkmal_id AND T01.spr_id = 22
   INNER JOIN kfl_production_dbp_view.v_l_tp_merkmal_2 AS T02 ON T00.mandant_id = T02.mandant_id AND T00.tp_merkmal_id =
      T02.tp_merkmal_id AND T02.tp_merkmal_sap_id = 'FFZ-TYP'
   INNER JOIN kfl_production_dbp_view.v_l_tp_merkmalart_2 AS T03 ON T00.mandant_id = T03.mandant_id AND T00.tp_merkmal_id
        = T03.tp_merkmal_id AND T02.tp_merkmal_klasse_id = T03.tp_merkmal_klasse_id AND T00.tp_merkmalwert = T03.tp_merkmalwert_id
       AND T01.tp_merkmalart_id = T03.tp_merkmalart_id) AS t1_2 ON T0.mandant_id = t1.mandant_id AND T0.tp_objekt_id = t1_2
   .tp_objekt_id
WHERE T0.dat_bis = DATE '9999-12-31';