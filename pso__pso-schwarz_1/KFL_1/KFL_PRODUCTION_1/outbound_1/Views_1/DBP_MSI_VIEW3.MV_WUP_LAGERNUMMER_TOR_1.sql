CREATE OR REPLACE VIEW kfl_production_dbp_msi_view3.mv_wup_lagernummer_tor_1 (mandant_id, wup_id, nb_id, lagernummer_id,
tor_id, bsflaeche_id) AS SELECT DISTINCT mandant_id,
 wup_id,
 nb_id,
 lagernummer_id,
 tor_id_zugeordnet AS tor_id,
 bsflaeche_id
FROM kfl_production_dbp_view.v_wup_lagernummer_bsflaeche_per_1 AS T01
WHERE DATE(datzeit_bis) = DATE '9999-12-31'
 AND EXISTS (SELECT 1
  FROM kfl_production_dbp_data.l_vz_sap_system_zu_1 AS SVZ
   INNER JOIN kfl_production_dbp_data.l_system_1 AS S ON SVZ.mandant_id = S.mandant_id AND SVZ.system_id = S.system_id
  WHERE S.system_gruppe = 'SAP LVS'
   AND SVZ.mandant_id = T01.mandant_id
   AND SVZ.wup_id = T01.wup_id
   AND SVZ.system_id = T01.system_id);